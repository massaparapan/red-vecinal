// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRequest _$UserRequestFromJson(Map<String, dynamic> json) => UserRequest(
      username: json['username'] as String,
      phoneNumber: json['phoneNumber'] as String,
      description: json['description'] as String?,
      imageProfileUrl: json['imageProfileUrl'] as String?,
    );

Map<String, dynamic> _$UserRequestToJson(UserRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'description': instance.description,
      'imageProfileUrl': instance.imageProfileUrl,
    };
