// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyProfileResponse _$MyProfileResponseFromJson(Map<String, dynamic> json) =>
    MyProfileResponse(
      username: json['username'] as String,
      phoneNumber: json['phoneNumber'] as String,
      description: json['description'] as String,
      nameOfCommunity: json['nameOfCommunity'] as String,
    );

Map<String, dynamic> _$MyProfileResponseToJson(MyProfileResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'description': instance.description,
      'nameOfCommunity': instance.nameOfCommunity,
    };
