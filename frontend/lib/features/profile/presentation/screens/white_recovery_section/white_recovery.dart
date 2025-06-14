
import 'package:flutter/material.dart';
import 'package:frontend/features/auth/presentation/screens/recovery_sections.dart';


class WhiteRecoveryScreen extends StatelessWidget {
  const WhiteRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RecoverySections()
    );
  }
}
