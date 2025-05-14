import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/local_widgets/auth_decorative_circle.dart';
import 'package:frontend/screens/auth/local_sections/auth_validate_code.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5988FF),
      body: Stack(
        children: [
          DecorativeCircle(
            top: 10,
            left: -200,
            colors: [Color.fromARGB(225, 255, 242, 140), Color(0xFF5988FF)],
            size: 400,
          ),
          DecorativeCircle(
            bottom: 10,
            right: -200,
            colors: [Color.fromARGB(225, 255, 255, 255), Color(0xFF5988FF)],
            size: 400,
          ),
          Center(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(8),
              ),
              child: AuthValidateCode(),
            ),
          ),
        ],
      ),
    );
  }
}
