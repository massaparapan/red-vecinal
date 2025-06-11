// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_preview_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityPreviewResponse _$CommunityPreviewResponseFromJson(
        Map<String, dynamic> json) =>
    CommunityPreviewResponse(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      creationDate: DateTime.parse(json['creationDate'] as String),
      lat: json['lat'] as String,
      lon: json['lon'] as String,
      membersCount: (json['membersCount'] as num).toInt(),
    );

Map<String, dynamic> _$CommunityPreviewResponseToJson(
        CommunityPreviewResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'creationDate': instance.creationDate.toIso8601String(),
      'lat': instance.lat,
      'lon': instance.lon,
      'membersCount': instance.membersCount,
    };
