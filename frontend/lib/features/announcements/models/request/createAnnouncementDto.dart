import 'package:json_annotation/json_annotation.dart';

part 'createAnnouncementDto.g.dart';

@JsonSerializable()
class CreateAnnouncementDto {
  final String content;
  final String type;

  CreateAnnouncementDto({
    required this.content,
    required this.type,
  });

  factory CreateAnnouncementDto.fromJson(Map<String, dynamic> json) =>
      _$CreateAnnouncementDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAnnouncementDtoToJson(this);
}
