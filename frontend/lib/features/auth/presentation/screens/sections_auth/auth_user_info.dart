import 'package:flutter/material.dart';
import 'package:frontend/core/navigation/app_routes.dart';
import 'package:frontend/core/navigation/navegation_service.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_stepper.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_text.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:frontend/features/auth/repository/auth_repository.dart';
import 'package:frontend/shared/widgets/error_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUserInfo extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onNext;
  const AuthUserInfo({super.key, required this.onBack, required this.onNext});

  @override
  State<AuthUserInfo> createState() => _AuthUserInfoState();
}

class _AuthUserInfoState extends State<AuthUserInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final _authRepository = AuthRepository();
  String _errorMessage = '';

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> _changeErrorMessage(String? message) async {
    setState(() {
      _errorMessage = message!;
    });
  }

  Future<void> _handleNext() async {
    final name = nameController.text.trim();
    final address = addressController.text.trim();

    if (name.isEmpty || address.isEmpty) {
      _changeErrorMessage("Por favor, rellenar todos los campos");
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final passwordSaved = prefs.getString('password');
    final phoneNumberSaved = prefs.getString('phoneNumber');

    try {
      await _authRepository.register(
      phoneNumber: phoneNumberSaved.toString(),
      username: nameController.text.toString(),
      address: address,
      password: passwordSaved.toString(),
    );
    } catch (e) {
      _changeErrorMessage(e.toString());
    }

    prefs.remove('password');
    prefs.remove('phoneNumber');

    NavegationService().navigateToAndClearStack(AppRoutes.noCommunityHome);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AuthText(label: 'Completar', isTitle: true),
        SizedBox(height: 20),
        AuthStepper(step: 4),
        SizedBox(height: 20),
        AuthText(
          label:
              'Por favor, completa los siguientes datos para finalizar el proceso.',
          isTitle: false,
        ),
        SizedBox(height: 40),
        AuthTextField(
          label: 'Nombre',
          hint: 'Ej: Juan Perez',
          isPassword: false,
          controller: nameController,
        ),
        SizedBox(height: 10),
        AuthTextField(
          label: 'Dirección',
          hint: 'Ej: Montt 1422',
          isPassword: false,
          controller: addressController,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ErrorText(text: _errorMessage),
          ),
        ),
        SizedBox(height: 25),
        AuthButton(
          title: 'Continuar',
          foregroundColor: Colors.white,
          border: false,
          backgroundColor: AppColors.primary,
          onPressed: _handleNext,
        ),
        SizedBox(height: 10),
        AuthButton(
          title: 'Volver',
          foregroundColor: AppColors.primary,
          border: true,
          backgroundColor: Colors.white,
          onPressed: widget.onBack,
        ),
      ],
    );
  }
}
