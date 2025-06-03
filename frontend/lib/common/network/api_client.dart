import 'dart:convert';
import 'package:frontend/common/dto/response.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl = 'http://10.0.2.2:8080/api';
  Future<ResponseDTO> post(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    Object? body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + endpoint).replace(queryParameters: queryParams),
        headers: headers ?? {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final jsonResponse = jsonDecode(response.body);

      return ResponseDTO.fromJson(jsonResponse);
    } catch (e) {
      return ResponseDTO(
        success: false,
        message: 'Error de red: ${e.toString()}',
        data: null,
      );
    }
  }

  Future<ResponseDTO> get(
  String endpoint, {
  Map<String, String>? headers,
  Map<String, String>? queryParams, 
}) async {
  try {
    final uri = Uri.parse(baseUrl + endpoint).replace(queryParameters: queryParams);
    final response = await http.get(
      uri,
      headers: headers ?? {'Content-Type': 'application/json'},
    );

    final jsonResponse = jsonDecode(response.body);

    return ResponseDTO.fromJson(jsonResponse);
  } catch (e) {
    return ResponseDTO(
      success: false,
      message: 'Error de red: ${e.toString()}',
      data: null,
    );
  }
}
}
