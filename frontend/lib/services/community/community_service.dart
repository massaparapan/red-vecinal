import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CommunityService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/communities';

  static Future<bool> createCommunity({
    required String name,
    required String description,
    required double lat,
    required double lon,
  }) async {

    final url = Uri.parse('$baseUrl/create');
    final body = jsonEncode({
      'name': name,
      'description': description,
      'lat': lat,
      'lon': lon,
    });

    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    if (token == null) {
      print('Error: No token found');
      return false;
    }
    print('Error: ${token}');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Error: ${response.body}');
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getCloseCommunities({
  required double lat,
  required double lon,
  }) async {
    final url = Uri.parse(
      'http://10.0.2.2:8080/api/communities/close?lat=$lat&lon=$lon',
    );

    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    print('📡 GET: $url');

    final response = await http.get(url,
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    print('📥 STATUS: ${response.statusCode}');
    print('📥 BODY: ${response.body}');

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print('📦 JSON decodificado: $decoded');

      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      return [];
    }
  }
}
