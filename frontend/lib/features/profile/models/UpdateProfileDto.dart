import 'package:json_annotation/json_annotation.dart';

part 'UpdateProfileDto.g.dart';

@JsonSerializable()
class UpdateProfileDto {
  final String username;
  final String description;

  UpdateProfileDto({
    required this.username,
    required this.description,
  });

  factory UpdateProfileDto.fromJson(Map<String, dynamic> json) => _$UpdateProfileDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProfileDtoToJson(this);
}
