import 'package:flutter/material.dart';
import 'package:frontend/core/app_colors.dart';
import 'package:frontend/screens/auth/local_widgets/auth_button.dart';
import 'package:frontend/screens/auth/local_widgets/auth_stepper.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text_field.dart';

class AuthCreatePassword extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onNext;

  const AuthCreatePassword({
    super.key,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AuthText(label: 'Crear contraseña', isTitle: true),
        SizedBox(height: 30),
        AuthStepper(step: 3),
        SizedBox(height: 30),
        AuthText(
          label: '¡Ya casi terminamos! Elige una contraseña.',
          isTitle: false,
        ),
        SizedBox(height: 40),
        AuthTextField(label: 'Contraseña', hint: '', isPassword: true),
        SizedBox(height: 10),
        AuthTextField(
          label: 'Confirmar contraseña',
          hint: '',
          isPassword: true,
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
