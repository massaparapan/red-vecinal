import 'package:flutter/material.dart';
import 'package:frontend/core/app_colors.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text_field.dart';
import 'package:frontend/screens/auth/local_widgets/decorative_circle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5988FF),
      body: Stack(
        children: [
          DecorativeCircle(
            top: 100,
            left: -200,
            colors: [Color.fromARGB(225, 255, 242, 140), Color(0xFF5988FF)],
            size: 400,
          ),
          DecorativeCircle(
            bottom: 100,
            right: -200,
            colors: [Color.fromARGB(225, 255, 255, 255), Color(0xFF5988FF)],
            size: 400,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      'Red Vecinal',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Inter',
                        color: Color(0xFF8FA0FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Cree una cuenta o inicie sesión para explorar nuestra comunidad.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF6C7278), fontSize: 18),
                    ),
                    SizedBox(height: 50),
                    AuthTextField(
                      label: 'Numero telefonico',
                      hint: '+56900000000',
                      isPassword: false,
                    ),
                    SizedBox(height: 20),
                    AuthTextField(
                      label: 'Contraseña',
                      hint: '',
                      isPassword: true,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8FA0FF),
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Iniciar sesión',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 12),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: Color(0xFF8FA0FF)),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Crear cuenta',
                        style: TextStyle(
                          color: Color(0xFF8FA0FF),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
