// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InformationResponseDto _$InformationResponseDtoFromJson(
        Map<String, dynamic> json) =>
    InformationResponseDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$InformationResponseDtoToJson(
        InformationResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
    };
