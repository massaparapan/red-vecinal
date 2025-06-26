// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InformationCreateDto _$InformationCreateDtoFromJson(
        Map<String, dynamic> json) =>
    InformationCreateDto(
      title: json['title'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$InformationCreateDtoToJson(
        InformationCreateDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
    };
