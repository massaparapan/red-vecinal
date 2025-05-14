import 'package:flutter/material.dart';
import 'package:frontend/core/app_colors.dart';
import 'package:frontend/screens/auth/local_widgets/auth_button.dart';
import 'package:frontend/screens/auth/local_widgets/auth_stepper.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text_field.dart';

class AuthUserInfo extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onNext;
  const AuthUserInfo({
    super.key,
    required this.onBack,
    required this.onNext,
  });
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
        ),
        SizedBox(height: 10),
        AuthTextField(
          label: 'Dirección',
          hint: 'Ej: Montt 1422',
          isPassword: false,
        ),
        SizedBox(height: 30),
        AuthButton(
          title: 'Continuar',
          foregroundColor: Colors.white,
          border: false,
          backgroundColor: AppColors.primary,
          onPressed: onNext,
        ),
        SizedBox(height: 10),
        AuthButton(
          title: 'Volver',
          foregroundColor: AppColors.primary,
          border: true,
          backgroundColor: Colors.white,
          onPressed: onBack,
        ),
      ],
    );
  }
}
