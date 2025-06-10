
import 'package:flutter/material.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_decorative_circle.dart';
import 'package:frontend/features/auth/presentation/screens/sections_recovery_password/recovery_password.dart';
import 'package:frontend/features/auth/presentation/screens/sections_recovery_password/recovery_password_code.dart';
import 'package:frontend/features/auth/presentation/screens/sections_recovery_password/recovery_password_newPassword.dart';

class RecoverySections extends StatefulWidget {

  const RecoverySections({
    super.key,
  });

  @override
  State<RecoverySections> createState() => _RecoverySectionsState();
}

class _RecoverySectionsState extends State<RecoverySections> {
  int currentSection = 0;

  void setPage(int section) {
    setState(() {
      currentSection = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sections = [
      AuthRecoveryPassword(
        onBack: () => setPage(0),
        onNext: () => setPage(1),
      ),
      RecoveryPasswordCode(
        onBack: () => setPage(currentSection - 1),
        onValidate: () => setPage(currentSection + 1),
      ),
      CreateNewPassword(
        onBack: () => setPage(currentSection - 1),
        onNext: () => setPage(currentSection + 1),
      )
    ];

    final bottomLeft = [500.0, 10.0, -200.0, 225.0];
    final bottomRight = [500.0, 10.0, 225.0, -200.0];
    final topLeft = [10.0, 500.0, -200.0, 225.0];
    final topRight = [10.0, 500.0, 225.0, -200.0];
    var circlePositions = [];

    if (currentSection == 0) {
      circlePositions = [topRight, bottomLeft];
    } else if (currentSection == 1) {
      circlePositions = [bottomLeft, topRight];
    } else if (currentSection == 2) {
      circlePositions = [bottomRight, topLeft];
    } else if (currentSection == 3) {
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