// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherProfileResponse _$OtherProfileResponseFromJson(
        Map<String, dynamic> json) =>
    OtherProfileResponse(
      username: json['username'] as String,
      description: json['description'] as String,
      nameOfCommunity: json['nameOfCommunity'] as String,
    );

Map<String, dynamic> _$OtherProfileResponseToJson(
        OtherProfileResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
      'description': instance.description,
      'nameOfCommunity': instance.nameOfCommunity,
    };
