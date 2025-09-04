// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InformationCreateRequest _$InformationCreateRequestFromJson(
        Map<String, dynamic> json) =>
    InformationCreateRequest(
      title: json['title'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$InformationCreateRequestToJson(
        InformationCreateRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
    };
