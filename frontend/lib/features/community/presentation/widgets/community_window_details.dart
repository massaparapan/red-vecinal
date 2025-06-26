import 'package:flutter/material.dart';
import 'package:frontend/shared/widgets/primary_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/features/community/services/community_service.dart';


class CommunityWindowDetails extends StatefulWidget {
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final int memberCount;
  final int id;

  const CommunityWindowDetails({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.memberCount,
  });

  @override
  State<CommunityWindowDetails> createState() => _CommunityWindowDetailsState();
}

class _CommunityWindowDetailsState extends State<CommunityWindowDetails> {
  String? address;
  final _communityService = CommunityService.withDefaults();

  @override
  void initState() {
    super.initState();
    _fetchAddress();
  }

  Future<void> _fetchAddress() async {
    final result = await getAddressFromMapbox(widget.latitude, widget.longitude);
    if (mounted) {
      setState(() {
        address = result;
      });
    }
  }

  Future<String> getAddressFromMapbox(double latitude, double longitude) async {
    try {
      await dotenv.load(fileName: "assets/.env");
      final accessToken = dotenv.env["MAPBOX_ACCESS_TOKEN"];

      if (accessToken == null || accessToken.isEmpty) {
        return 'Token no disponible';
      }

      final url =
          'https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$accessToken';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final features = data['features'] as List<dynamic>;

        if (features.isNotEmpty) {
          return features[0]['place_name'];
        } else {
          return 'Dirección no encontrada';
        }
      } else {
        return 'Error ${response.statusCode}';
      }
    } catch (e) {
      return 'Error al consultar dirección';
    }
  }

  String buildStaticMapUrl(double lat, double lon) {
    final accessToken = dotenv.env["MAPBOX_ACCESS_TOKEN"];
    final zoom = 14;
    final width = 600; // en píxeles
    final height = 300;

    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v12/static/$lon,$lat,$zoom/${width}x$height@2x?access_token=$accessToken';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: const Color(0xFF5988FF),
                ),
          ),

          const SizedBox(height: 8.0),
          SizedBox(
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                buildStaticMapUrl(widget.latitude, widget.longitude),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey,
                  child: const Center(child: Text('No se pudo cargar el mapa')),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Icon(Icons.location_on, color: Color(0xFF5988FF), size: 20),
              const SizedBox(width: 4.0),
              Expanded(
                child: address == null
                    ? const LinearProgressIndicator(minHeight: 2)
                    : Text(
                        address!,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 14,
                            ),
                      ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            widget.description,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                ),
          ),
          const SizedBox(height: 8.0),
          Text(
            '${widget.memberCount} Miembros',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
          ),
          const SizedBox(height: 24.0),
          PrimaryButton(
            label: 'Solicitar Unirse',
            width: double.infinity,
            onPressed: () async  {
                try {
                await _communityService.requestJoinCommunity(widget.id);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Solicitud enviada exitosamente'),
                  ),
                  );
                }
                } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error al enviar solicitud: $e'),
                  ),
                  );
                }
                debugPrint('Error al enviar solicitud: $e');
                }
            },
          ),
        ],
      ),
    );
  }
}
