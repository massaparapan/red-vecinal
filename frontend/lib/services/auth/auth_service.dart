import 'package:frontend/common/dto/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/common/network/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final ApiClient _client = ApiClient();
  final String baseUrl = "/auth";
  
  final storage = FlutterSecureStorage();

  Future<void> guardarToken(String token) async {
    await storage.write(key: 'token', value: token);
  }
  

  Future<ResponseDTO> register(String phoneNumber, String username, String address, String password) async {
    final result = await _client.post(
      '$baseUrl/register',

      body: {'username': username,'phoneNumber': phoneNumber, 'password': password},
    );

    if (result.success && result.data is Map<String, dynamic>) {
      final data = result.data as Map<String, dynamic>;
      final token = data['token'] as String?;

      if (token != null) {
        final storage = FlutterSecureStorage();
        await storage.write(key: 'token', value: token);
      }
    }

    return result;
  }

  Future<ResponseDTO> login(String phoneNumber, String password) async {

    final storage = FlutterSecureStorage();
    
    if (phoneNumber == "" || password == "") {
      return ResponseDTO(success: false, message: 'Por favor completar los campos');
    }

    final result = await _client.post(
      '$baseUrl/login',
      body: {'phoneNumber': phoneNumber, 'password': password},
    );

    print('Result success: ${result.success}');
    print('Result data: ${result.data}');
    print('Result message: ${result.message}');
    if (result.success && result.data is String) {
      final tokenRaw = result.data as String;

      final token = tokenRaw.split("token: ").last.trim();

      print('Token extraído: $token');
      await storage.write(key: 'token', value: token);
    }

    return result;
  }


}
