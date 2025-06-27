import 'package:json_annotation/json_annotation.dart';

part 'otp_verify_request.g.dart';

@JsonSerializable()
class OtpVerifyRequest {
  String phoneNumber;
  String code;

  OtpVerifyRequest({
    required this.phoneNumber,
    required this.code,
  });

  factory OtpVerifyRequest.fromJson(Map<String, dynamic> json) => _$OtpVerifyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$OtpVerifyRequestToJson(this);
}