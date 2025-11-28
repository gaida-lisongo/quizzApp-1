// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: json['_id'] as String,
      designation: json['designation'] as String,
      description: json['description'] as String,
      logo: json['logo'] as String,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'designation': instance.designation,
      'description': instance.description,
      'logo': instance.logo,
    };
