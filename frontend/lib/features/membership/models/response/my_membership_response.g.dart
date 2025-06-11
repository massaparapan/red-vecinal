// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_membership_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyMembershipResponse _$MyMembershipResponseFromJson(
        Map<String, dynamic> json) =>
    MyMembershipResponse(
      status: json['status'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$MyMembershipResponseToJson(
        MyMembershipResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'role': instance.role,
    };
