import 'package:json_annotation/json_annotation.dart';

part 'user_request.g.dart';

@JsonSerializable()
class UserRequest {
  final String username;
  final String phoneNumber;
  final String? description;
  final String? imageProfileUrl;

  UserRequest({
    required this.username,
    required this.phoneNumber,
    required this.description,
    this.imageProfileUrl,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json) => _$UserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestToJson(this);
}
