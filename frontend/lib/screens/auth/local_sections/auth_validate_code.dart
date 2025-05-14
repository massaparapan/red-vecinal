import 'package:flutter/material.dart';
import 'package:frontend/core/app_colors.dart';
import 'package:frontend/screens/auth/local_widgets/auth_button.dart';
import 'package:frontend/screens/auth/local_widgets/auth_input_code.dart';
import 'package:frontend/screens/auth/local_widgets/auth_stepper.dart';
import 'package:frontend/screens/auth/local_widgets/auth_text.dart';

class AuthValidateCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthText(label: 'Validar numero', isTitle: true),
          SizedBox(height: 30),
          AuthStepper(step: 2),
          SizedBox(height: 30),
          AuthText(
            label: 'Por favor, introduzca el código recibido vía SMS.',
            isTitle: false,
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AuthInputCode(),
              AuthInputCode(),
              AuthInputCode(),
              AuthInputCode(),
              AuthInputCode(),
            ],
          ),

          SizedBox(height: 60),
          AuthButton(
            title: 'Validar',
            foregroundColor: Colors.white,
            border: false,
            backgroundColor: AppColors.primary,
          ),
          SizedBox(height: 10),
          AuthButton(
            title: 'Volver',
            foregroundColor: AppColors.primary,
            border: true,
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
