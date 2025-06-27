import 'package:frontend/features/join-request/models/request/user_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'membership_request.g.dart';

@JsonSerializable()
class MembershipRequest{
  final int id;
  final String status;
  final String role;
  final UserRequest userDto;

  MembershipRequest({
    required this.id,
    required this.status,
    required this.role,
    required this.userDto,
  });

  factory MembershipRequest.fromJson(Map<String, dynamic> json) =>
      _$MembershipRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipRequestToJson(this);
}
