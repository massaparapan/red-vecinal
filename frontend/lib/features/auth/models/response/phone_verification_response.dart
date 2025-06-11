import 'package:json_annotation/json_annotation.dart';

part 'phone_verification_response.g.dart';


@JsonSerializable()
class PhoneVerificationResponse {
  bool exists;

  PhoneVerificationResponse({required this.exists});

  factory PhoneVerificationResponse.fromJson(Map<String, dynamic> json) => _$PhoneVerificationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneVerificationResponseToJson(this);
}