import "package:flutter/material.dart";
import "package:frontend/features/auth/presentation/widgets/auth_step_indicator.dart";
import "package:frontend/features/auth/presentation/widgets/auth_separator_step.dart";

class AuthStepper extends StatelessWidget{
  final int step;

  const AuthStepper({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AuthStepIndicator(
          step: 1,
          isActive: step >= 1,
        ),
        AuthSeparatorStep(isActive: step >= 2),
        AuthStepIndicator(
          step: 2,
          isActive: step >= 2,
        ),
        AuthSeparatorStep(isActive: step >= 3),
        AuthStepIndicator(
          step: 3,
          isActive: step >= 3,
        ),
        AuthSeparatorStep(isActive: step >= 4),
        AuthStepIndicator(
          step: 4,
          isActive: step >= 4,
        ),
      ],
    );
  }
}