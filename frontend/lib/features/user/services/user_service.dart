import 'package:dio/dio.dart';
import 'package:frontend/core/network/api_client.dart';
import 'package:frontend/features/auth/models/response/phone_verification_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:frontend/features/user/models/request/update_profile_request.dart';
import 'package:frontend/features/user/models/response/my_profile_response.dart';
import 'package:frontend/features/user/models/response/other_profile_response.dart';
import 'package:frontend/features/auth/models/request/reset_password_request.dart';

part 'user_service.g.dart';

@RestApi(baseUrl: "/api/users")
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;
  factory UserService.withDefaults() => UserService(ApiClient.instance);

  @GET("/consult-phoneNumber")
  Future<PhoneVerificationResponse> consultPhoneNumber(
    @Query('phoneNumber') String phoneNumber,
  );

  @PATCH("/reset-password")
  Future<void> resetPassword(
    @Body() ResetPasswordRequest resetPasswordRequest,
    @Header("Reset-Token") String resetToken,
  );

  @GET("/profile/me")
  Future<MyProfileResponse> getMyProfile();

  @GET("/profile/{id}")
  Future<OtherProfileResponse> getUserProfile(@Path("id") int id);

  @PATCH("/profile/me")
  Future<void> updateMyProfile(
    @Body() UpdateProfileRequest updateProfileRequest,
  );
}
