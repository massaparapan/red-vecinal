import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/features/user/models/request/reset_password_request.dart';
import 'package:frontend/features/user/services/user_service.dart';

class UserRepository {
  final UserService _userService;
  UserRepository() : _userService = UserService.withDefaults();
  final _storage = FlutterSecureStorage();

  Future<void> resetPassword({
    required String phoneNumber,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (newPassword.isEmpty ||
        confirmPassword.isEmpty && newPassword != confirmPassword) {
      throw ("Datos invalidos.");
    }

    final resetToken = await _storage.read(key: "reset-token");
    if (resetToken != null) {
      _userService.resetPassword(
        ResetPasswordRequest(
          phoneNumber: phoneNumber,
          newPassword: newPassword,
        ),
        resetToken,
      );
    }
  }

  Future<void> consultPhoneNumber({required phoneNumber}) async {
    try {
      final response = await _userService.consultPhoneNumber(phoneNumber);

      if (response.exists) {
        throw ("El telefono ya esta registrado");
      }
    } on DioException catch (e) {
      throw e.message ?? "Error inesperado";
    }
  }
}
