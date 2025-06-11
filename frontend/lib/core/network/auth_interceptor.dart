import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/shared/models/api_response.dart';

class AuthInterceptor extends Interceptor {
  static const _storage = FlutterSecureStorage();

  AuthInterceptor();

  final publicEndpoints = [
    '/login',
    '/register',
    '/otp/send',
    '/otp/verify',
    '/consult-phoneNumber',
    '/reset-password'
  ];

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    log("URL solicitud: ${options.uri}");

    final isPublic = publicEndpoints.any((endpoint) {
      return options.path.contains(endpoint);
    });

    if (!isPublic) {
      final token = await _storage.read(key: 'token');

      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
        log("🔐 Token agregado a headers");
      } else {
        log("⚠️ No se encontró token en el almacenamiento");
      }
    } else {
      log("🔓 Endpoint público, no se agrega token");
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    log('🟢 onResponse llamado');
    log('🔹 Datos originales de la respuesta: ${response.data}');

    final apiResponse = ApiResponse.fromJson(response.data);
    log('🔹 ApiResponse.data: ${apiResponse.data}');

    response.data = apiResponse.data;
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log('🔴 onError llamado');
    log('🔹 Datos de error recibidos: ${err.response?.data}');

    final response = ApiResponse.fromJson(err.response?.data);
    log('🔹 ApiResponse.message: ${response.message}');

    final error = DioException(
      requestOptions: err.requestOptions,
      message: response.message,
    );

    handler.next(error);
  }
}
