import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class RModel {
  @JsonKey(name: 'Title')
  String title;
  @JsonKey(name: 'Poster')
  final String poster;

  RModel({required this.title, required this.poster});

  factory RModel.fromJson(Map<String, dynamic> json) => _$RModelFromJson(json);

  Map<String, dynamic> toJson() => _$RModelToJson(this);
}
