// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InformationResponse _$InformationResponseFromJson(Map<String, dynamic> json) =>
    InformationResponse(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$InformationResponseToJson(
        InformationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
    };
