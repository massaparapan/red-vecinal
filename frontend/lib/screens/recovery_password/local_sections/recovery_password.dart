import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/local_widgets/auth_button.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text_field.dart';




class  AuthRecoveryPassword extends StatefulWidget {

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
  final TextEditingController _phoneController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          'Recuperar contraseña',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blueAccent),
        ),
        SizedBox(height: 30),
        Text(
          'Por favor, indica tu número  de teléfono para recuperar tu contraseña.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17, color: const Color.fromARGB(179, 2, 2, 2)),
        ),
        SizedBox(height: 45),
        AuthTextField(
          label: 'Número Telefónico',
          hint: '+56900000000',
          isPassword: false,
          controller: _phoneController,
        ),
        SizedBox(height: 60),
        AuthButton(
          title: 'Continuar', 
          foregroundColor: Colors.white, 
          border: false, 
          onPressed: widget.onNext, 
          backgroundColor: Colors.blueAccent),
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