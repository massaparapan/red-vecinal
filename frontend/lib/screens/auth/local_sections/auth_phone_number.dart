import 'package:flutter/material.dart';
import 'package:frontend/core/app_colors.dart';
import 'package:frontend/screens/auth/local_widgets/auth_button.dart';
import 'package:frontend/screens/auth/local_widgets/auth_stepper.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text_field.dart';
import 'package:frontend/services/otp/otp_service.dart';
import 'package:frontend/services/user/user_service.dart';
import 'package:frontend/widgets/error_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPhoneNumber extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onNext;

  const AuthPhoneNumber({
    super.key,
    required this.onBack,
    required this.onNext,
  });

  @override
  State<AuthPhoneNumber> createState() => _AuthPhoneNumberState();
}

class _AuthPhoneNumberState extends State<AuthPhoneNumber> {
  final _userService = UserService();
  final _phoneNumberController = TextEditingController();
  final _otpService = OtpService();
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadPhoneNumber();
  }

  Future<void> _loadPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    final storedPhoneNumber = prefs.getString('phoneNumber');

    if (storedPhoneNumber != null) {
      _phoneNumberController.text = storedPhoneNumber;
    }
  }

  Future<void> _consultPhoneNumber() async {
    final result = await _userService.consultPhoneNumber(
      _phoneNumberController.text,
    );

    final success = result.success;

    if (!success) {
      setState(() {
        _errorMessage = result.message!;
      });
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', _phoneNumberController.text);

    if (result.data != null &&
        (result.data as Map<String, dynamic>)['exists'] == true) {
      setState(() {
        _errorMessage = 'El número telefónico ya está registrado.';
      });
    } else {
      setState(() {
        _errorMessage = '';
      });
      
      final otpResult = await _otpService.sendOtp(_phoneNumberController.text);
      if (otpResult.success) {
        widget.onNext();
      } else {
        setState(() {
          _errorMessage = otpResult.message!;
        });
      }
    }
  }

  Future<void> _handleNext() async {
    await _consultPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AuthText(label: 'Crear cuenta', isTitle: true),
        const SizedBox(height: 20),
        const AuthStepper(step: 1),
        const SizedBox(height: 20),
        const AuthText(
          label:
              'Proporcione su número telefónico para continuar con el registro.',
          isTitle: false,
        ),
        const SizedBox(height: 40),
        AuthTextField(
          label: 'Número Telefónico',
          hint: '+56900000000',
          isPassword: false,
          controller: _phoneNumberController,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ErrorText(text: _errorMessage),
          ),
        ),
        const SizedBox(height: 25),
        AuthButton(
          title: 'Siguiente',
          foregroundColor: Colors.white,
          border: false,
          backgroundColor: AppColors.primary,
          onPressed: _handleNext,
        ),
        const SizedBox(height: 10),
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
