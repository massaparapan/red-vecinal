import 'package:flutter/material.dart';
import 'package:frontend/core/app_colors.dart';
import 'package:frontend/screens/auth/local_widgets/auth_button.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text_field.dart';
import 'package:frontend/widgets/error_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateNewPassword extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onNext;

  const CreateNewPassword({
    super.key,
    required this.onBack,
    required this.onNext,
  });

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? storedPassword;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadPassword();
  }

  Future<void> _loadPassword() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('password');
    if (saved != null) {
      passwordController.text = saved;
      confirmPasswordController.text = saved;
    }
    setState(() {
      storedPassword = saved;
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleNext() async {
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _errorMessage = "Por favor completar los campos";
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = "Las contraseñas no coinciden";
      });
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);

    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AuthText(label: 'Crear contraseña', isTitle: true),
        SizedBox(height: 30),
        AuthText(
          label: 'Escribe tu nueva contraseña, !No olvides guardarla!',
          isTitle: false,
        ),
        SizedBox(height: 40),
        AuthTextField(
          label: 'Completar',
          hint: '',
          isPassword: true,
          controller: passwordController,
        ),
        SizedBox(height: 10),
        AuthTextField(
          label: 'Confirmar contraseña',
          hint: '',
          isPassword: true,
          controller: confirmPasswordController,
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
