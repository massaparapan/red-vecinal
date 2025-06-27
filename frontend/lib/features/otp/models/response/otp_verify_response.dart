import 'package:json_annotation/json_annotation.dart';

part 'otp_verify_response.g.dart';

@JsonSerializable()
class OtpVerifyResponse {
  bool valid;
  String token;

  OtpVerifyResponse({
    required this.valid,
    required this.token,
  });

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) => _$OtpVerifyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OtpVerifyResponseToJson(this);
}