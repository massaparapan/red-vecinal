import 'package:dio/dio.dart';
import 'package:frontend/core/network/api_client.dart';
import 'package:frontend/features/auth/models/response/auth_response.dart';
import 'package:frontend/features/auth/models/request/login_request.dart';
import 'package:frontend/features/auth/models/request/register_request.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: '/api/auth')
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;
  factory AuthService.withDefaults() => AuthService(ApiClient.instance);

  @POST('/login')
  Future<AuthResponse> login(@Body() LoginRequest request);

  @POST('/register')
  Future<AuthResponse> register(@Body() RegisterRequest request);
}
