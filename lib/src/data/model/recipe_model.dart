import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class RModel {
  RModel(): super();

  @JsonKey(name: 'Search')
  List<Search> list = List.empty();

  factory RModel.fromJson(Map<String, dynamic> json) => _$RModelFromJson(json);
  Map<String, dynamic> toJson() => _$RModelToJson(this);
}

@JsonSerializable()
class Search {
  @JsonKey(name: 'Title')
  String title;
  @JsonKey(name: 'Poster')
  final String poster;

  Search({required this.title, required this.poster});

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);

  Map<String, dynamic> toJson() => _$SearchToJson(this);
}
