
import 'package:json_annotation/json_annotation.dart';

part 'other_profile_response.g.dart';

@JsonSerializable()
class OtherProfileResponse {
  final String username;
  final String description;
  final String nameOfCommunity;

  OtherProfileResponse({
    required this.username,
    required this.description,
    required this.nameOfCommunity,
  });

  factory OtherProfileResponse.fromJson(Map<String, dynamic> json) => _$OtherProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OtherProfileResponseToJson(this);
}
