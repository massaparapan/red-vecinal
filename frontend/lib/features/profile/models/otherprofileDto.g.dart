// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otherprofileDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherProfileDto _$OtherProfileDtoFromJson(Map<String, dynamic> json) =>
    OtherProfileDto(
      username: json['username'] as String,
      description: json['description'] as String,
      nameOfCommunity: json['nameOfCommunity'] as String,
    );

Map<String, dynamic> _$OtherProfileDtoToJson(OtherProfileDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'description': instance.description,
      'nameOfCommunity': instance.nameOfCommunity,
    };
