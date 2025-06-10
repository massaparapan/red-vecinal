import 'package:json_annotation/json_annotation.dart';

part 'community_member_response.g.dart';

@JsonSerializable()
class CommunityMemberResponse {
  final String id;
  final String username;
  final String role;

  CommunityMemberResponse({
    required this.id,
    required this.username,
    required this.role,
  });

  factory CommunityMemberResponse.fromJson(Map<String, dynamic> json) => _$CommunityMemberResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CommunityMemberResponseToJson(this);
}