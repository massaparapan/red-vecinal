import 'package:flutter/material.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:frontend/features/otp/repositories/otp_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/shared/widgets/error_text.dart';

class AuthRecoveryPassword extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onNext;

  const AuthRecoveryPassword({
    super.key,
    required this.onBack,
    required this.onNext,
  });

  @override
  State<AuthRecoveryPassword> createState() => _AuthRecoveryPasswordState();
}

class _AuthRecoveryPasswordState extends State<AuthRecoveryPassword> {
  final _phoneNumberController = TextEditingController();
  final _otpService = OtpRepository();
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadPhoneNumber();
  }

  Future<void> _changeErrorMessage(String? message) async {
    setState(() {
      _errorMessage = message!;
    });
  }

  Future<void> _loadPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    final storedPhoneNumber = prefs.getString('phoneNumber');

    if (storedPhoneNumber != null && storedPhoneNumber != 'null') {
      _phoneNumberController.text = storedPhoneNumber;
    }
  }

  Future<void> _handleNext() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('phoneNumber', _phoneNumberController.text);
      await _otpService.sendOtp(phoneNumber: _phoneNumberController.text);
      widget.onNext();
    } catch (e) {
      _changeErrorMessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          textAlign: TextAlign.center,
          'Recuperar contraseña',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        SizedBox(height: 30),
        Text(
          'Por favor, indica tu número  de teléfono para recuperar tu contraseña.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            color: const Color.fromARGB(179, 2, 2, 2),
          ),
        ),
        SizedBox(height: 45),
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
        SizedBox(height: 60),
        AuthButton(
          title: 'Continuar',
          foregroundColor: Colors.white,
          border: false,
          onPressed: _handleNext,
          backgroundColor: Colors.blueAccent,
        ),
        SizedBox(height: 10),
        AuthButton(
          title: 'Volver',
          foregroundColor: Colors.blueAccent,
          border: true,
          backgroundColor: Colors.white,
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
