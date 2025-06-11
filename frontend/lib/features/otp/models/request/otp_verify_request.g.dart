// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verify_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpVerifyRequest _$OtpVerifyRequestFromJson(Map<String, dynamic> json) =>
    OtpVerifyRequest(
      phoneNumber: json['phoneNumber'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$OtpVerifyRequestToJson(OtpVerifyRequest instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'code': instance.code,
    };
