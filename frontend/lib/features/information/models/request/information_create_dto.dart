import 'package:json_annotation/json_annotation.dart';

part 'information_create_dto.g.dart';

@JsonSerializable()
class InformationCreateDto {
  final String title;
  final String content;

  InformationCreateDto({
    required this.title,
    required this.content,
  });

  factory InformationCreateDto.fromJson(Map<String, dynamic> json) =>
      _$InformationCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InformationCreateDtoToJson(this);
}
