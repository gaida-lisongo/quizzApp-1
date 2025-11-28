import 'package:json_annotation/json_annotation.dart';
part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  @JsonKey(name: '_id')
  final String id;
  final String enonce;
  final String categorieId;
  final List<String> choix;

  const QuestionModel({
    required this.id,
    required this.enonce,
    required this.categorieId,
    required this.choix,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);

  QuestionModel copyWith({
    String? id,
    String? enonce,
    String? categorieId,
    List<String>? choix,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      enonce: enonce ?? this.enonce,
      categorieId: categorieId ?? this.categorieId,
      choix: choix ?? this.choix,
    );
  }
}