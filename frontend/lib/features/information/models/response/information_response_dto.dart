import 'package:json_annotation/json_annotation.dart';

part 'information_response_dto.g.dart';

@JsonSerializable()
class InformationResponseDto {
  final int id;
  final String title;
  final String content;

  InformationResponseDto({
    required this.id,
    required this.title,
    required this.content,
  });

  factory InformationResponseDto.fromJson(Map<String, dynamic> json) =>
      _$InformationResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InformationResponseDtoToJson(this);
}
