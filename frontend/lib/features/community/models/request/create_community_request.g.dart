// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_community_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCommunityRequest _$CreateCommunityRequestFromJson(
        Map<String, dynamic> json) =>
    CreateCommunityRequest(
      name: json['name'] as String,
      description: json['description'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );

Map<String, dynamic> _$CreateCommunityRequestToJson(
        CreateCommunityRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'lat': instance.lat,
      'lon': instance.lon,
    };
