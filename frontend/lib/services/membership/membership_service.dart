import 'package:frontend/common/dto/response.dart';
import 'package:frontend/common/network/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MembershipService {
  final ApiClient _client = ApiClient();
  final storage = FlutterSecureStorage();
  final String baseUrl = "/memberships";
  

  Future<ResponseDTO> getMyMembership() async {

    final token = await storage.read(key: 'token');

    return await _client.get(
      '$baseUrl/me',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }
}
