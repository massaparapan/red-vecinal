// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_member_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityMemberResponse _$CommunityMemberResponseFromJson(
        Map<String, dynamic> json) =>
    CommunityMemberResponse(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$CommunityMemberResponseToJson(
        CommunityMemberResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'role': instance.role,
    };
