import 'package:dio/dio.dart';
import 'package:frontend/core/network/api_client.dart';
import 'package:frontend/features/auth/models/response/phone_verification_response.dart';
import 'package:retrofit/retrofit.dart';

part 'user_service.g.dart';

@RestApi(baseUrl: "/api/users")
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;
  factory UserService.withDefaults() => UserService(ApiClient.instance);

  @GET("/consult-phoneNumber")
  Future<PhoneVerificationResponse> consultPhoneNumber(@Query('phoneNumber') String phoneNumber);

  @PATCH("/reset-password")
  Future<void >resetPassword(@Body() resetPasswordRequest, @Header("Reset-Token") String resetToken);
}
