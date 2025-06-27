import 'package:dio/dio.dart';
import 'package:frontend/core/network/api_client.dart';
import 'package:frontend/features/otp/models/response/otp_verify_response.dart';
import 'package:retrofit/http.dart';

part 'otp_service.g.dart';

@RestApi(baseUrl:"/api/otp")
abstract class OtpService {
  factory OtpService(Dio dio, {String baseUrl}) = _OtpService;
  factory OtpService.withDefaults() => OtpService(ApiClient.instance);

  @POST("/send")
  Future<void> sendOtp (@Query("phoneNumber") String phoneNumber);

  @POST("/verify")
  Future<OtpVerifyResponse> verifyOtp (@Body() otpVerifyRequest);
}
