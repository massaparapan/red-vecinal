import 'package:dio/dio.dart';
import 'package:frontend/core/network/auth_interceptor.dart';

class ApiClient {
  static final Dio _dio = _createDio();
  static Dio get instance => _dio;

  static Dio _createDio() {
    final options = BaseOptions(
      baseUrl: 'http://localhost:8080',
      headers: {'Content-Type': 'application/json'},
    );

    final dio = Dio(options);
    dio.interceptors.add(AuthInterceptor());
    return dio;
  }
}
