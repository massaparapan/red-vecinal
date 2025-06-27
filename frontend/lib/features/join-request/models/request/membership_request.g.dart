// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipRequest _$MembershipRequestFromJson(Map<String, dynamic> json) =>
    MembershipRequest(
      id: (json['id'] as num).toInt(),
      status: json['status'] as String,
      role: json['role'] as String,
      userDto: UserRequest.fromJson(json['userDto'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MembershipRequestToJson(MembershipRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'role': instance.role,
      'userDto': instance.userDto,
    };
