import 'package:flutter/material.dart';
import 'package:frontend/core/app_colors.dart';
import 'package:frontend/screens/auth/local_widgets/auth_button.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text_field.dart';
import 'package:frontend/services/auth/auth_service.dart';
import 'package:frontend/widgets/error_text.dart';
import 'package:frontend/screens/no_community_screen/no_community_screen.dart';

class AuthLogin extends StatefulWidget {
  final VoidCallback onCreateAccount;

  const AuthLogin({super.key, required this.onCreateAccount});

  @override
  State<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  String _errorMessage = '';

  Future<void> _handleLogin() async {
    final result = await _authService.login(
      _phoneController.text.trim(),
      _passwordController.text.trim(),
    );

    if (!result.success) {
      setState(() {
        _errorMessage = result.message!;
      });
    } else {
      setState(() {
        
        _errorMessage = '';
      });
    }
    if (result.success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NoCommunityScreen(),
        ),
      );
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
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ErrorText(text: _errorMessage),
          ),
        ),
        SizedBox(height: 30),
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
