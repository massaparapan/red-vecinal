// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createAnnouncementDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAnnouncementDto _$CreateAnnouncementDtoFromJson(
        Map<String, dynamic> json) =>
    CreateAnnouncementDto(
      content: json['content'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$CreateAnnouncementDtoToJson(
        CreateAnnouncementDto instance) =>
    <String, dynamic>{
      'content': instance.content,
      'type': instance.type,
    };
