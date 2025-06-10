import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/features/auth/models/request/login_request.dart';
import 'package:frontend/features/auth/models/request/register_request.dart';
import 'package:frontend/features/auth/services/auth_service.dart';

class AuthRepository {
  final _storage = FlutterSecureStorage();
  final AuthService _authService; 
  AuthRepository() : _authService = AuthService.withDefaults();
  Future<void> login({
    required String phoneNumber,
    required String password,
  }) async {
    if (phoneNumber.isEmpty || password.isEmpty) {
      throw ("Por favor, completar los campos");
    }

    final request = LoginRequest(phoneNumber: phoneNumber, password: password);

    try {
      final response = await _authService.login(request);
      await _storage.write(key: 'token', value: response.token);
    } on DioException catch (e) {
      throw e.message ?? "Error inesperado";
    }
  }

  Future<void> register({
    required String phoneNumber,
    required String username,
    required String address,
    required String password,
  }) async {
    if (phoneNumber.isEmpty || password.isEmpty) {
      throw ("Por favor, completar los campos");
    }

    final request = RegisterRequest(
      username: username,
      phoneNumber: phoneNumber,
      address: address,
      password: password,
    );

    try {
      final response = await _authService.register(request);
      await _storage.write(key: 'token', value: response.token);
    } on DioException catch (e) {
      throw (e.message ?? "Error inesperado");
    }
  }
}
