import 'package:frontend/common/dto/response.dart';
import 'package:frontend/common/network/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  final ApiClient _client = ApiClient();
  final String baseUrl = "/users";

  Future<ResponseDTO> consultPhoneNumber(String phoneNumber) async {
    if (phoneNumber == "") {
      return ResponseDTO(success: false, message: 'Por favor completar los campos');
    }

    if (!await verifyPhoneNumber(phoneNumber)) {
      return ResponseDTO(success: false, message: 'Formato no adecuado');
    }

    final result = await _client.get(
      '$baseUrl/consult-phoneNumber',
      queryParams: {'phoneNumber': phoneNumber},
    );
    return result;
  }

  Future<bool> verifyPhoneNumber(String phoneNumber) async {
    final regex = RegExp(r'^\+56\s?[1-9]\d{7,8}$');
    if (regex.hasMatch(phoneNumber)) {
      return true;
    }
    return false;
  }

  Future<ResponseDTO> resetPassword(String phoneNumber, String newPassword)async {

    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    if (token == null) {
      return ResponseDTO(success: false, message: 'No se encontró el token de autenticación');
    }

    final result = await _client.patch(
      '$baseUrl/reset-password',
      body: {'phoneNumber': phoneNumber, 'newPassword': newPassword },
      headers: {'Content-Type': 'application/json', 'Reset-Token': token},
    );

    return result;
  }
}
