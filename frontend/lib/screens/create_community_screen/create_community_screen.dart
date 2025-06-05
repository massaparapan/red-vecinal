import 'package:flutter/material.dart';
import 'package:frontend/screens/create_community_screen/local_services/nominatim_service.dart';
import 'package:frontend/widgets/primary_button.dart';
import 'package:frontend/screens/create_community_screen/local_widgets/create_community_box.dart';
import 'package:frontend/widgets/alt_button.dart';
import 'package:frontend/services/community_service.dart';


class CreateCommunityScreen extends StatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    super.dispose();
  }

  
  void createCommunity() async {
    final name = nameController.text.trim();
    final description = descriptionController.text.trim();
    final address = addressController.text.trim();
    

    if (name.isEmpty || description.isEmpty || address.isEmpty) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa todos los campos obligatorios.'),
        ),
      );
    }
    return;
    }

    final coordinates = await NominatimService.geocodeAddress(address);
    if (coordinates == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo obtener lat/lon para esta dirección')),
        );
      }
      return;
    }

    final success = await CommunityService.createCommunity(
      name: nameController.text,
      description: descriptionController.text,
      lat: coordinates['lat']!,
      lon: coordinates['lon']!,
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? "Comunidad creada exitosamente" : "Error al crear comunidad",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Crea tu comunidad',
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
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Detalles de la comunidad',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Completa la información para crear una nueva comunidad vecinal.',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: const Color(0xFF9C9C9C),
                        fontSize: 16,
                      ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Nombre de la comunidad',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                ),
                const SizedBox(height: 15),
                CreateCommunityBox(
                  width: double.infinity,
                  hintText: 'Ej Villa Aron',
                  controller: nameController,
                  onPressed: () {},
                ),
                const SizedBox(height: 15),
                Text(
                  'Descripción',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                ),
                const SizedBox(height: 15),
                CreateCommunityBox(
                  minLines: 3,
                  maxLines: 5,
                  width: double.infinity,
                  hintText: 'Describe brevemente tu comunidad',
                  controller: descriptionController,
                  onPressed: () {},
                ),
                const SizedBox(height: 15),
                Text(
                  'Ingresa la dirección',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                ),
                const SizedBox(height: 15),
                CreateCommunityBox(
                  width: double.infinity,
                  hintText: 'Dirección',
                  controller: addressController,
                  onPressed: () {},
                ),
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      PrimaryButton(
                        label: 'Crear comunidad',
                        onPressed: createCommunity,
                        width: double.infinity,
                        height: 50,
                      ),
                      const SizedBox(height: 12),
                      AltButton(
                        label: 'Volver',
                        icon: Icons.arrow_back,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        width: double.infinity,
                        height: 50,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
