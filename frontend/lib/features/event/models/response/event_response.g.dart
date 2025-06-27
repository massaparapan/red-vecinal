// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventResponse _$EventResponseFromJson(Map<String, dynamic> json) =>
    EventResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
      createdBy:
          UserResponse.fromJson(json['createdBy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventResponseToJson(EventResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date,
      'createdBy': instance.createdBy,
    };
