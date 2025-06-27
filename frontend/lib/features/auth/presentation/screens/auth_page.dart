import 'package:flutter/material.dart';
import 'package:frontend/features/auth/presentation/screens/sections_auth/auth_create_password.dart';
import 'package:frontend/features/auth/presentation/screens/sections_auth/auth_login.dart';
import 'package:frontend/features/auth/presentation/screens/sections_auth/auth_phone_number.dart';
import 'package:frontend/features/auth/presentation/screens/sections_auth/auth_user_info.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_decorative_circle.dart';
import 'package:frontend/features/auth/presentation/screens/sections_auth/auth_validate_code.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  int currentSection = 0;

  void setPage(int section) {
    setState(() {
      currentSection = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sections = [
      AuthLogin(onCreateAccount: () => setPage(1)),
      AuthPhoneNumber(
        onNext: () => setPage(currentSection + 1),
        onBack: () => setPage(currentSection - 1),
      ),
      AuthValidateCode(
        onValidate: () => setPage(currentSection + 1),
        onBack: () => setPage(currentSection - 1),
      ),
      AuthCreatePassword(
        onNext: () => setPage(currentSection + 1),
        onBack: () => setPage(currentSection - 1),
      ),
      AuthUserInfo(
        onNext: () => setPage(currentSection + 1),
        onBack: () => setPage(currentSection - 1),
      ),
    ];

    //Circle positions [top, bottom, left, right]
    final bottomLeft = [500.0, 10.0, -200.0, 225.0];
    final bottomRight = [500.0, 10.0, 225.0, -200.0];
    final topLeft = [10.0, 500.0, -200.0, 225.0];
    final topRight = [10.0, 500.0, 225.0, -200.0];
    var circlePositions = [];

    if (currentSection == 0) {
      circlePositions = [topLeft, bottomRight];
    } else if (currentSection == 1) {
      circlePositions = [bottomLeft, topRight];
    } else if (currentSection == 2) {
      circlePositions = [bottomRight, topLeft];
    } else if (currentSection == 3) {
      circlePositions = [topRight, bottomLeft];
    } else {
      circlePositions = [topLeft, bottomRight];}

    return Scaffold(
      backgroundColor: Color(0xFF5988FF),
      body: Stack(
        children: [
          DecorativeCircle(
            position: circlePositions[0],
            colors: [Color.fromARGB(225, 255, 242, 140), Color(0xFF5988FF)],
          ),
          DecorativeCircle(
            position: circlePositions[1],
            colors: [Color.fromARGB(225, 255, 255, 255), Color(0xFF5988FF)],
          ),
          Center(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.80),
                borderRadius: BorderRadius.circular(8),
              ),
              child: sections[currentSection],
            ),
          ),
        ],
      ),
    );
  }
}
