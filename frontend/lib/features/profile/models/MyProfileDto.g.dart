// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MyProfileDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyProfileDto _$MyProfileDtoFromJson(Map<String, dynamic> json) => MyProfileDto(
      username: json['username'] as String,
      phoneNumber: json['phoneNumber'] as String,
      description: json['description'] as String,
      nameOfCommunity: json['nameOfCommunity'] as String,
    );

Map<String, dynamic> _$MyProfileDtoToJson(MyProfileDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'description': instance.description,
      'nameOfCommunity': instance.nameOfCommunity,
    };
