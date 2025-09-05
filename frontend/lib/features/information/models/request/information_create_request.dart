import 'package:json_annotation/json_annotation.dart';

part 'information_create_request.g.dart';

@JsonSerializable()
class InformationCreateRequest {
  final String title;
  final String content;

  InformationCreateRequest({
    required this.title,
    required this.content,
  });

  factory InformationCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$InformationCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$InformationCreateRequestToJson(this);
}
