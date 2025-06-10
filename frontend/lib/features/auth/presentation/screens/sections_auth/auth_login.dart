import 'package:flutter/material.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_text.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:frontend/features/auth/presentation/screens/recovery_sections.dart';
import 'package:frontend/features/auth/repository/auth_repository.dart';
import 'package:frontend/shared/widgets/error_text.dart';

class AuthLogin extends StatefulWidget {
  final VoidCallback onCreateAccount;

  const AuthLogin({super.key, required this.onCreateAccount});

  @override
  State<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authRepository = AuthRepository();
  String _errorMessage = '';

  Future<void> _changeErrorMessage(String? message) async {
    setState(() {
      _errorMessage = message!;
    });
  }

  Future<void> _handleLogin() async {
    try {
      await _authRepository.login(
        phoneNumber: _phoneController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } catch (e) {
      _changeErrorMessage(e.toString());
    }
  }

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
          label: 'Número Telefónico',
          hint: '+56900000000',
          isPassword: false,
          controller: _phoneController,
        ),
        SizedBox(height: 10),
        AuthTextField(
          label: 'Contraseña',
          hint: '*********',
          isPassword: true,
          controller: _passwordController,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: ErrorText(text: _errorMessage),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecoverySections()),
            );
          },
          child: Text(
            '¿Olvidaste tu contraseña?',
            style: TextStyle(color: AppColors.primary, fontSize: 16),
          ),
        ),
        SizedBox(height: 5),
        AuthButton(
          title: 'Iniciar sesión',
          foregroundColor: Colors.white,
          border: false,
          backgroundColor: AppColors.primary,
          onPressed: _handleLogin,
        ),
        SizedBox(height: 10),
        AuthButton(
          title: 'Crear cuenta',
          foregroundColor: AppColors.primary,
          border: true,
          backgroundColor: Colors.white,
          onPressed: widget.onCreateAccount,
        ),
      ],
    );
  }
}
