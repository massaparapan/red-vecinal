import 'package:flutter/material.dart';
import 'package:frontend/core/navigation/app_routes.dart';
import 'package:frontend/core/navigation/navegation_service.dart';
import 'package:frontend/shared/menu_screen/local_widgets/menu-tile.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Menú',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5988FF),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuTile(
                    icon: Icons.map_outlined,
                    label: 'Mapa',
                    color: const Color(0xFF42A45C),
                    onTap: () => NavegationService().navigateTo(AppRoutes.map),
                  ),
                  const SizedBox(width: 20),
                  MenuTile(
                    icon: Icons.groups,
                    label: 'Miembros',
                    color: const Color(0xFF5988FF),
                    onTap: () => NavegationService().navigateTo(AppRoutes.communityMembers),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuTile(
                    icon: Icons.campaign,
                    label: 'Anuncios',
                    color: const Color(0xFFE27B56),
                    onTap: () => NavegationService().navigateTo('/home/admin/announcements')
                  ),
                  const SizedBox(width: 20),
                  MenuTile(
                    icon: Icons.info_outline_rounded,
                    label: 'Informacion',
                    color: const Color(0xFFCCC042),
                    onTap: () => NavegationService().navigateTo('/home/admin/information'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuTile(
                    icon: Icons.add,
                    label: 'Solicitudes',
                    color: const Color(0xFFE6881D),
                    onTap: () => NavegationService().navigateTo('/home/admin/community-requests'),
                  ),
                  const SizedBox(width: 20),
                  MenuTile(
                    icon: Icons.calendar_month,
                    label: 'Calendario',
                    color: const Color(0xFF2F9CB4),
                    onTap: () => NavegationService().navigateTo('/home/events'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuTile(
                    icon: Icons.meeting_room,
                    label: 'Cerrar Sesión',
                    color: const Color(0xFFDD4A4A),
                    onTap: NavegationService().logout,
                  ),
                  const SizedBox(width: 20),
                  MenuTile(
                    icon: Icons.account_circle,
                    label: 'Perfil',
                    color: const Color(0xFF736AED),
                    onTap: () => NavegationService().navigateTo('/profile')
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
