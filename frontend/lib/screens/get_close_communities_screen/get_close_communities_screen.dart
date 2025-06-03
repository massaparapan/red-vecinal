import 'package:flutter/material.dart';
import 'package:frontend/screens/get_close_communities_screen/local_widgets/close_community_box.dart';
import 'package:frontend/screens/get_close_communities_screen/local_services/location_service.dart';
import 'package:frontend/services/community_service.dart';
import 'package:frontend/widgets/primary_button.dart';

class CloseCommunityScreen extends StatefulWidget {
  const CloseCommunityScreen({super.key});

  @override
  State<CloseCommunityScreen> createState() => _CloseCommunityScreenState();
}

class _CloseCommunityScreenState extends State<CloseCommunityScreen> {
  List<Map<String, dynamic>> nearbyCommunities = [];

  @override
  void initState() {
    super.initState();
    fetchNearbyCommunities();
  }

  void fetchNearbyCommunities() async {
    final location = await LocationService.getCurrentLocation();
    print('📍 Ubicación actual: ${location?.latitude}, ${location?.longitude}');
    if (location == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo obtener tu ubicación')),
      );
      return;
    }

    final results = await CommunityService.getCloseCommunities(
      lat: location.latitude,
      lon: location.longitude,
    );

    setState(() {
      nearbyCommunities = results;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                'Comunidades cercanas',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
              ),
              const SizedBox(height: 8),
              Divider(
                color: const Color(0xFF5988FF),
                thickness: 3,
                height: 1,
                indent: 3,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: nearbyCommunities.isNotEmpty
                    ? ListView.builder(
                        itemCount: nearbyCommunities.length,
                        itemBuilder: (context, index) {
                          final community = nearbyCommunities[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CommunityCard(
                              name: community['name'],
                              description: community['description'],
                              membersCount: community['membersCount']?? 0,
                              onJoinPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Solicitud enviada a ${community['name']}'),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          'No se encontraron comunidades cercanas.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
              ),

              const SizedBox(height: 20),
              PrimaryButton(
                label: 'Volver',
                onPressed: () {
                  Navigator.pop(context);
                },
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
