import 'package:flutter/material.dart';
import 'package:frontend/core/app_colors.dart';
import 'package:frontend/screens/auth/local_widgets/auth_button.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text_field.dart';

class AuthLogin extends StatelessWidget {
  final VoidCallback onCreateAccount;

  const AuthLogin({super.key, required this.onCreateAccount});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        AuthText(label: 'RED VECINAL', isTitle: true),
        SizedBox(height: 20),
        AuthText(
          label:
              'Cree una cuenta o inicie sesión para explorar nuestra comunidad.',
          isTitle: false,
        ),
        SizedBox(height: 45),
        AuthTextField(
          label: 'Numero Telefonico',
          hint: '+56900000000',
          isPassword: false,
        ),
        SizedBox(height: 10),
        AuthTextField(label: 'Contraseña', hint: '*********', isPassword: true),
        SizedBox(height: 45),
        AuthButton(
          title: 'Iniciar sesion',
          foregroundColor: Colors.white,
          border: false,
          backgroundColor: AppColors.primary,
          onPressed: () {},
        ),
        SizedBox(height: 10),
        AuthButton(
          title: 'Crear cuenta',
          foregroundColor: AppColors.primary,
          border: true,
          backgroundColor: Colors.white,
          onPressed: onCreateAccount,
        ),
      ],
    );
  }
}
