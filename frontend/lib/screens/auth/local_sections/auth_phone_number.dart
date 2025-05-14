import 'package:flutter/material.dart';
import 'package:frontend/core/app_colors.dart';
import 'package:frontend/screens/auth/local_widgets/auth_button.dart';
import 'package:frontend/screens/auth/local_widgets/auth_stepper.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text_field.dart';

class AuthPhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AuthText(label: 'Crear cuenta', isTitle: true),
        SizedBox(height: 20),
        AuthStepper(step: 1),
        SizedBox(height: 20),
        AuthText(
          label:
              'Proporcione su número telefónico para continuar con el registro.',
          isTitle: false,
        ),
        SizedBox(height: 40),
        AuthTextField(
          label: 'Numero Telefonico',
          hint: '+56900000000',
          isPassword: false,
        ),
        SizedBox(height: 30),
        AuthButton(
          title: 'Siguiente',
          foregroundColor: Colors.white,
          border: false,
          backgroundColor: AppColors.primary,
        ),
        SizedBox(height: 10),
        AuthButton(
          title: 'Volver',
          foregroundColor: AppColors.primary,
          border: true,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
