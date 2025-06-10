import 'package:json_annotation/json_annotation.dart';

part 'create_community_request.g.dart';

@JsonSerializable()
class CreateCommunityRequest {
  String name;
  String description;
  double lat;
  double lon;

  CreateCommunityRequest({
    required this.name,
    required this.description,
    required this.lat,
    required this.lon,
  });

  factory CreateCommunityRequest.fromJson(Map<String, dynamic> json) => _$CreateCommunityRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateCommunityRequestToJson(this);
}
