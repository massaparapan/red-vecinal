// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_announcement_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAnnouncementRequest _$CreateAnnouncementRequestFromJson(
        Map<String, dynamic> json) =>
    CreateAnnouncementRequest(
      content: json['content'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$CreateAnnouncementRequestToJson(
        CreateAnnouncementRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
      'type': instance.type,
    };
