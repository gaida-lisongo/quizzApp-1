import 'package:json_annotation/json_annotation.dart';
part 'score_model.g.dart';

@JsonSerializable()
class ScoreModel {
  @JsonKey(name: '_id')
  final String id;
  final String questionId;
  final String categorie;
  final int note;
  final DateTime date;
  final String status;

  const ScoreModel({
    required this.id,
    required this.questionId,
    required this.categorie,
    required this.note,
    required this.date,
    required this.status,
  });

  factory ScoreModel.fromJson(Map<String, dynamic> json) =>
      _$ScoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreModelToJson(this);

  ScoreModel copyWith({
    String? id,
    String? questionId,
    String? categorie,
    int? note,
    DateTime? date,
    String? status,
  }) {
    return ScoreModel(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      categorie: categorie ?? this.categorie,
      note: note ?? this.note,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }
}