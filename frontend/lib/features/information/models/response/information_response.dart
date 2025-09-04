import 'package:json_annotation/json_annotation.dart';

part 'information_response.g.dart';

@JsonSerializable()
class InformationResponse {
  final int id;
  final String title;
  final String content;

  InformationResponse({
    required this.id,
    required this.title,
    required this.content,
  });

  factory InformationResponse.fromJson(Map<String, dynamic> json) =>
      _$InformationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InformationResponseToJson(this);
}
