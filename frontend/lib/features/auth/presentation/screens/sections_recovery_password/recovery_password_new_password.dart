import 'package:flutter/material.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_text.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:frontend/features/user/repository/user_repository.dart';
import 'package:frontend/shared/widgets/error_text.dart';
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
  final _userRepository = UserRepository();
  String? storedPassword;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changeErrorMessage(String? message) async {
    setState(() {
      _errorMessage = message!;
    });
  }

  Future<void> _handleNext() async {
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final prefs = await SharedPreferences.getInstance();
    final phoneNumber = prefs.getString('phoneNumber') ?? "";
    try {
      await _userRepository.resetPassword(phoneNumber: phoneNumber, newPassword: password, confirmPassword: confirmPassword);
    } catch (e) {
      _changeErrorMessage(e.toString());
    }
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
