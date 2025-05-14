import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/local_sections/auth_create_password.dart';
import 'package:frontend/screens/auth/local_sections/auth_login.dart';
import 'package:frontend/screens/auth/local_sections/auth_phone_number.dart';
import 'package:frontend/screens/auth/local_sections/auth_user_info.dart';
import 'package:frontend/screens/auth/local_widgets/auth_decorative_circle.dart';
import 'package:frontend/screens/auth/local_sections/auth_validate_code.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  int currentPage = 0;

  void setPage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      AuthLogin(onCreateAccount: () => setPage(1)),
      AuthPhoneNumber(
        onNext: () => setPage(currentPage + 1),
        onBack: () => setPage(currentPage - 1),
      ),
      AuthValidateCode(
        onValidate: () => setPage(currentPage + 1),
        onBack: () => setPage(currentPage - 1),
      ),
      AuthCreatePassword(
        onNext: () => setPage(currentPage + 1),
        onBack: () => setPage(currentPage - 1),
      ),
      AuthUserInfo(
        onNext: () => setPage(currentPage + 1),
        onBack: () => setPage(currentPage - 1),
      ),
    ];

    // Circle positions [top, bottom, left, right]
    final bottomLeft = [500.0, 10.0, -200.0, 225.0];
    final bottomRight = [500.0, 10.0, 225.0, -200.0];
    final topLeft = [10.0, 500.0, -200.0, 225.0];
    final topRight = [10.0, 500.0, 225.0, -200.0];
    var circlePositions = [];

    if (currentPage == 0) {
      circlePositions = [topLeft, bottomRight];
    } else if (currentPage == 1) {
      circlePositions = [bottomLeft, topRight];
    } else if (currentPage == 2) {
      circlePositions = [bottomRight, topLeft];
    } else if (currentPage == 3) {
      circlePositions = [topRight, bottomLeft];
    } else {
      circlePositions = [topLeft, bottomRight];
    }

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
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.80),
                borderRadius: BorderRadius.circular(8),
              ),
              child: pages[currentPage],
            ),
          ),
        ],
      ),
    );
  }
}
