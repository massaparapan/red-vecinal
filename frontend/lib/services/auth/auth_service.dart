import 'package:frontend/common/dto/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/common/network/api_client.dart';

class AuthService {
  final ApiClient _client = ApiClient();
  final String baseUrl = "/auth";

  Future<ResponseDTO> register(String phoneNumber, String username, String address, String password) async {
    final result = await _client.post(
      '$baseUrl/register',
      body: {'username': username,'phoneNumber': phoneNumber, 'password': password},
    );

    return result;
  }

  Future<ResponseDTO> login(String phoneNumber, String password) async {
    
    if (phoneNumber == "" || password == "") {
      return ResponseDTO(success: false, message: 'Por favor completar los campos');
    }

    final result = await _client.post(
      '$baseUrl/login',
      body: {'phoneNumber': phoneNumber, 'password': password},
    );

    return result;
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
}
