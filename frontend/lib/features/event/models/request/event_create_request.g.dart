// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventCreateRequest _$EventCreateRequestFromJson(Map<String, dynamic> json) =>
    EventCreateRequest(
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$EventCreateRequestToJson(EventCreateRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'date': instance.date,
    };
