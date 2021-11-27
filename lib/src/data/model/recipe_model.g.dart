// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RModel _$RModelFromJson(Map<String, dynamic> json) => RModel()
  ..list = (json['Search'] as List<dynamic>)
      .map((e) => Search.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$RModelToJson(RModel instance) => <String, dynamic>{
      'Search': instance.list,
    };

Search _$SearchFromJson(Map<String, dynamic> json) => Search(
      title: json['Title'] as String,
      poster: json['Poster'] as String,
    );

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'Title': instance.title,
      'Poster': instance.poster,
    };
