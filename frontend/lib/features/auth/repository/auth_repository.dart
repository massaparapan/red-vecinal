import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/features/auth/models/auth_response.dart';
import 'package:frontend/features/auth/models/login_request.dart';
import 'package:frontend/features/auth/models/register_request.dart';
import 'package:frontend/features/auth/services/i_auth_service.dart';
import 'package:frontend/shared/models/api_response.dart';

class AuthRepository {
  static const _storage = FlutterSecureStorage();
  late final IAuthService _authService;

  AuthRepository(IAuthService authService) : _authService = authService;

  Future<ApiResponse<AuthResponse>> login({
    required String phoneNumber,
    required String password,
  }) async {
    if (phoneNumber.isEmpty || password.isEmpty) {
      return ApiResponse.error("Por favor, completas los campos");
    }

    final request = LoginRequest(phoneNumber: phoneNumber, password: password);

    try {
      final response = await _authService.login(request);

      if (!response.success) {
        return ApiResponse.error(response.message ?? "Error desconocido");
      }

      _storage.write(key: 'token', value: response.data?.token);

      return response;
    } catch (e) {
      return ApiResponse.error("Error: $e");
    }
  }

  Future<ApiResponse<AuthResponse>> register({
    required String phoneNumber,
    required String username,
    required String address,
    required String password,
  }) async {
    if (phoneNumber.isEmpty || password.isEmpty) {
      return ApiResponse.error("Por favor, completas los campos");
    }

    final request = RegisterRequest(
      username: username,
      phoneNumber: phoneNumber,
      address: address,
      password: password,
    );

    try {
      final response = await _authService.register(request);

      if (!response.success) {
        return ApiResponse.error(response.message ?? "Error desconocido");
      }

      _storage.write(key: 'token', value: response.data?.token);

      return response;
    } catch (e) {
      return ApiResponse.error("Error: $e");
    }
  }
}
