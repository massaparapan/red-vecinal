import 'package:json_annotation/json_annotation.dart';

part 'event_create_request.g.dart';

@JsonSerializable()
class EventCreateRequest {
  final String title;
  final String description;
  final String date; 

  EventCreateRequest({
    required this.title,
    required this.description,
    required this.date,
  });

  factory EventCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$EventCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EventCreateRequestToJson(this);
}