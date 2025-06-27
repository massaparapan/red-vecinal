
import 'package:json_annotation/json_annotation.dart';

part 'otherprofileDto.g.dart';

@JsonSerializable()
class OtherProfileDto {
  final String username;
  final String description;
  final String nameOfCommunity;

  OtherProfileDto({
    required this.username,
    required this.description,
    required this.nameOfCommunity,
  });

  factory OtherProfileDto.fromJson(Map<String, dynamic> json) => _$OtherProfileDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OtherProfileDtoToJson(this);
}
