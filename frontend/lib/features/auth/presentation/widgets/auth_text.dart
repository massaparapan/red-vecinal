import 'package:flutter/material.dart';
import 'package:frontend/core/theme/colors.dart';

class AuthText extends StatelessWidget {

  final String label;
  final bool isTitle;

  const AuthText({super.key, required this.label, required this.isTitle});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: isTitle ? 30 : 17.5,
        fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
        color: isTitle ? AppColors.primary : const Color.fromARGB(255, 75, 75, 75),
      ),
    );
  }
}
