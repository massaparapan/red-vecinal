import 'package:flutter/material.dart';
import 'package:frontend/core/app_colors.dart';
import 'package:frontend/screens/auth/local_widgets/auth_button.dart';
import 'package:frontend/screens/auth/local_widgets/auth_stepper.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text_field.dart';
import 'package:frontend/services/auth/auth_service.dart';
import 'package:frontend/widgets/error_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/screens/menu_screen/no_community_home.dart';


class AuthUserInfo extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onNext;
  const AuthUserInfo({
    super.key,
    required this.onBack,
    required this.onNext,
  });

  @override
  State<AuthUserInfo> createState() => _AuthUserInfoState();
}

class _AuthUserInfoState extends State<AuthUserInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final _authService = AuthService();
  String _errorMessage = '';

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> _handleNext() async {
    final name = nameController.text.trim();
    final address = addressController.text.trim();
    if (name.isEmpty || address.isEmpty) {
      setState(() {
        _errorMessage = "Por favor, rellenar todos los campos";
      });
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final passwordSaved = prefs.getString('password');
    final phoneNumberSaved = prefs.getString('phoneNumber');
    
    await _authService.register(phoneNumberSaved!, nameController.text, address, passwordSaved!);
    prefs.remove('password');
    prefs.remove('phoneNumber');
    Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const NoCommunityScreen(),
                  ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AuthText(label: 'Completar', isTitle: true),
        SizedBox(height: 20),
        AuthStepper(step: 4),
        SizedBox(height: 20),
        AuthText(
          label:
              'Por favor, completa los siguientes datos para finalizar el proceso.',
          isTitle: false,
        ),
        SizedBox(height: 40),
        AuthTextField(
          label: 'Nombre',
          hint: 'Ej: Juan Perez',
          isPassword: false,
          controller: nameController,
        ),
        SizedBox(height: 10),
        AuthTextField(
          label: 'Dirección',
          hint: 'Ej: Montt 1422',
          isPassword: false,
          controller: addressController,
        ),Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ErrorText(text: _errorMessage),
          ),
        ),
        SizedBox(height: 25),
        AuthButton(
          title: 'Continuar',
          foregroundColor: Colors.white,
          border: false,
          backgroundColor: AppColors.primary,
          onPressed: _handleNext,
        ),
        SizedBox(height: 10),
        AuthButton(
          title: 'Volver',
          foregroundColor: AppColors.primary,
          border: true,
          backgroundColor: Colors.white,
          onPressed: widget.onBack,
        ),
      ],
    );
  }
}
