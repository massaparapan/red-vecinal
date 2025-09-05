import 'package:json_annotation/json_annotation.dart';

part 'create_announcement_request.g.dart';

@JsonSerializable()
class CreateAnnouncementRequest {
  final String content;
  final String type;

  CreateAnnouncementRequest({
    required this.content,
    required this.type,
  });

  factory CreateAnnouncementRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAnnouncementRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAnnouncementRequestToJson(this);
}
