import 'dart:convert';
import 'package:http/http.dart' as http;

class CommunityService {
  static const String baseUrl = 'http://localhost:8080/api/community';

  static Future<bool> createCommunity({
    required String name,
    required String description,
    required double lat,
    required double lon,
    required int membersCount,
    required String creationDate,
  }) async {
    final url = Uri.parse('$baseUrl/create');
    final body = jsonEncode({
      'name': name,
      'description': description,
      'lat': lat,
      'lon': lon,
      'membersCount': membersCount,
      'creationDate': creationDate,
    });

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 201) {
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
      'http://localhost:8080/api/community/close?lat=$lat&lon=$lon',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      return [];
    }
  }
}
