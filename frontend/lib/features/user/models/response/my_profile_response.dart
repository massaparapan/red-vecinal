
import 'package:json_annotation/json_annotation.dart';

part 'my_profile_response.g.dart';

@JsonSerializable()
class MyProfileResponse {

  String username;
  final String phoneNumber;
  String? description;
  final String nameOfCommunity;

  MyProfileResponse({
    required this.username,
    required this.phoneNumber,
    String? description,
    required this.nameOfCommunity,
  }) : description = description ?? '';

  factory MyProfileResponse.fromJson(Map<String, dynamic> json) => _$MyProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MyProfileResponseToJson(this);

}