import 'package:json_annotation/json_annotation.dart';

part 'my_membership_response.g.dart';

@JsonSerializable()
class MyMembershipResponse {
  String? status;
  String? role;

  MyMembershipResponse({required this.status, required this.role});

  factory MyMembershipResponse.fromJson(Map<String, dynamic> json) =>
      _$MyMembershipResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MyMembershipResponseToJson(this);
}
