import 'package:flutter/material.dart';
import 'package:frontend/core/app_colors.dart';

class AuthStepIndicator extends StatelessWidget {
  final int step;
  final bool isActive;

  const AuthStepIndicator({
    super.key,
    required this.step,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          step.toString(),
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontSize: 20
          ),
        ),
      ),
    );
  }

}
