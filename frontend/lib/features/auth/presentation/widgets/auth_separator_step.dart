import 'package:flutter/material.dart';
import 'package:frontend/core/theme/colors.dart';

class AuthSeparatorStep extends StatelessWidget {
  final bool isActive;

  const AuthSeparatorStep({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 5,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.white,
        shape: BoxShape.rectangle,
      ),
    );
  }
}