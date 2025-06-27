import 'package:json_annotation/json_annotation.dart';

part 'community_preview_response.g.dart';

@JsonSerializable()
class CommunityPreviewResponse {
  final int id;
  final String name;
  final String description;
  final DateTime creationDate;
  final String lat;
  final String lon;
  final int membersCount;

  CommunityPreviewResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.creationDate,
    required this.lat,
    required this.lon,
    required this.membersCount,
  });

  factory CommunityPreviewResponse.fromJson(Map<String, dynamic> json) => _$CommunityPreviewResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CommunityPreviewResponseToJson(this);
}
