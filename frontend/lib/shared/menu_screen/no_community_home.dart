import 'package:flutter/material.dart';
import 'package:frontend/core/navigation/navegation_service.dart';
import 'package:frontend/features/community/presentation/screens/nearby_communities_map.dart';
import 'package:frontend/shared/widgets/primary_button.dart';
import 'package:frontend/shared/widgets/alt_button.dart';
import 'package:frontend/features/community/presentation/screens/create_community_screen.dart';
import 'package:frontend/features/community/presentation/screens/get_close_communities_screen.dart';

class NoCommunityScreen extends StatelessWidget {
  const NoCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: const Alignment(0, -0.13),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.groups, size: 120, color: Colors.blueAccent),
              const SizedBox(height: 10),
              Text(
                'No estás en una comunidad',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Únete a una comunidad para ver anuncios\ny participar en actividades.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: const Color(0xFF9C9C9C),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Ver comunidades cercanas',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CloseCommunityScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              AltButton(
                label: 'Ver comunidades en el mapa',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NearbyCommunitiesMap(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: 'Crear Comunidad',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateCommunityScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 80),
              AltButton(
                label: 'Cerrar sesión',
                color: Colors.red,
                icon: Icons.logout,
                onPressed: NavegationService().logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
