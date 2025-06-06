import 'package:frontend/common/dto/response.dart';
import 'package:frontend/common/network/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/screens/membership/members_screen/members_screen.dart';

class MembershipService {
  final ApiClient _client = ApiClient();
  final storage = FlutterSecureStorage();
  final String baseUrl = "/memberships";

  Future<ResponseDTO> getRoleAndStatus() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    if (token == null) {
      return ResponseDTO(
        success: false,
        message: 'No se encontró el token de autenticación',
      );
    }

    final result = await _client.get(
      '$baseUrl/me',
      headers: {'Authorization': 'Bearer $token'},
    );

    if (result.success && result.data is Map<String, dynamic>) {
      final data = result.data as Map<String, dynamic>;
      final role = data['role'] as String?;
      final status = data['status'] as String?;
      if (role != null && status != null) {
        await storage.write(key: 'status', value: status);
        await storage.write(key: 'role', value: role);
      }
    }
    return result;
  }

  Future<List<Member>> getMembers() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    if (token == null) {
      throw Exception('No se encontró el token de autenticación');
    }

    final result = await _client.get(
      '$baseUrl/my-community/members',
      headers: {'Authorization': 'Bearer $token'},
    );

    if (!result.success) {
      throw Exception(result.message ?? 'Error al obtener los miembros');
    }

    if (result.data is List) {
      final Object? jsonList = result.data;
      return (jsonList as List).map((json) => Member.fromJson(json)).toList();
    } else {
      throw Exception('Formato de datos inesperado');
    }
  }
}
