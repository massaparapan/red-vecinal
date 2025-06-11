import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'MyProfileDto.g.dart';

@JsonSerializable()
class MyProfileDto {

  String username;
  final String phoneNumber;
  String description;
  final String nameOfCommunity;

  MyProfileDto({
    required this.username,
    required this.phoneNumber,
    required this.description,
    required this.nameOfCommunity,
  });

  factory MyProfileDto.fromJson(Map<String, dynamic> json) => _$MyProfileDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MyProfileDtoToJson(this);

}