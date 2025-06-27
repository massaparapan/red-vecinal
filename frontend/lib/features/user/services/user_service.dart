import 'package:dio/dio.dart';
import 'package:frontend/core/network/api_client.dart';
import 'package:frontend/features/auth/models/response/phone_verification_response.dart';
import 'package:frontend/features/profile/models/otherprofileDto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:frontend/features/profile/models/UpdateProfileDto.dart';
import 'package:frontend/features/profile/models/MyProfileDto.dart';

part 'user_service.g.dart';

@RestApi(baseUrl: "/api/users")
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;
  factory UserService.withDefaults() => UserService(ApiClient.instance);

  @GET("/consult-phoneNumber")
  Future<PhoneVerificationResponse> consultPhoneNumber(@Query('phoneNumber') String phoneNumber);

  @PATCH("/reset-password")
  Future<void >resetPassword(@Body() resetPasswordRequest, @Header("Reset-Token") String resetToken);

  @GET("/profile/me")
  Future<MyProfileDto> getMyProfile();

  @GET("/profile/{id}")
  Future<OtherProfileDto> getUserProfile(@Path("id") int id);

  @PATCH("/profile/me")
  Future<void> updateMyProfile(@Body() UpdateProfileDto updateProfileDto);


}
