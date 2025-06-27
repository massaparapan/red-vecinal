import 'package:flutter/material.dart';
import 'package:frontend/features/profile/models/MyProfileDto.dart';
import 'package:frontend/features/profile/models/UpdateProfileDto.dart';
import 'package:frontend/features/profile/presentation/screens/white_recovery_section/white_recovery.dart';
import 'package:frontend/features/user/services/user_service.dart';
import 'package:frontend/shared/widgets/primary_button.dart';
import 'package:frontend/shared/widgets/alt_button.dart';
import 'package:frontend/features/profile/presentation/screens/profile_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late MyProfileDto user;
  bool _isLoading = true;
  final userService = UserService.withDefaults();

  late String originalName;
  late String originalDescription;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final result = await userService.getMyProfile();
      setState(() {
        user = result;
        originalName = result.username;
        originalDescription = result.description;
        _isLoading = false;
      });
    } catch (e) {
      print("Error cargando el perfil: $e");
    }
  }

  bool get _hasChanges {
    return user.username != originalName || user.description != originalDescription;
  }

  Future<void> _saveChanges() async {
    try {
      final updateDto = UpdateProfileDto(
        username: user.username,
        description: user.description,
      );
      await userService.updateMyProfile(updateDto);
      setState(() {
        originalName = user.username;
        originalDescription = user.description;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil actualizado con éxito')),
      );
    } catch (e) {
      print("Error al actualizar el perfil: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al actualizar el perfil')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        'Perfil',
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
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue[100],
                        child: Text(
                          user.username.isNotEmpty ? user.username[0].toUpperCase() : '?',
                          style: const TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ProfileField(
                        label: "Nombre",
                        value: user.username,
                        editable: true,
                        onChanged: (value) {
                          setState(() {
                            user.username = value;
                          });
                        },
                      ),
                      ProfileField(
                        label: "Número de Teléfono",
                        value: user.phoneNumber,
                        editable: false,
                      ),
                      ProfileField(
                        label: "Descripción",
                        value: user.description,
                        editable: true,
                        onChanged: (value) {
                          setState(() {
                            user.description = value;
                          });
                        },
                      ),
                      ProfileField(
                        label: "Mi Comunidad",
                        value: user.nameOfCommunity,
                        editable: false,
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const WhiteRecoveryScreen(),
                            ),
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Cambiar contraseña',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (_hasChanges)
                        PrimaryButton(
                          label: "Guardar Cambios",
                          onPressed: _saveChanges,
                          width: double.infinity,
                        ),
                      const SizedBox(height: 10),
                      AltButton(
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
      ),
    );
  }
}
