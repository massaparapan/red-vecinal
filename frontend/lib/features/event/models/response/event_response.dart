import 'package:json_annotation/json_annotation.dart';
import 'package:frontend/features/user/models/response/user_response.dart';

part 'event_response.g.dart';

@JsonSerializable()
class EventResponse {
  final String id;
  final String title;
  final String description;
  final String date; 
  @JsonKey(name: 'createdBy')
  final UserResponse createdBy;

  EventResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.createdBy,
  });

  factory EventResponse.fromJson(Map<String, dynamic> json) =>
      _$EventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventResponseToJson(this);
}