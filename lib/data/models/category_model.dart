import 'package:json_annotation/json_annotation.dart';
part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: '_id')
  final String id;
  final String designation;
  final String description;
  final String logo;

  const CategoryModel({
    required this.id,
    required this.designation,
    required this.description,
    required this.logo,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  CategoryModel copyWith({
    String? id,
    String? designation,
    String? description,
    String? logo,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      designation: designation ?? this.designation,
      description: description ?? this.description,
      logo: logo ?? this.logo,
    );
  }
}