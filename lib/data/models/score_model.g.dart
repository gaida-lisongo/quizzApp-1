// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreModel _$ScoreModelFromJson(Map<String, dynamic> json) => ScoreModel(
  id: json['_id'] as String,
  questionId: json['questionId'] as String,
  categorie: json['categorie'] as String,
  note: (json['note'] as num).toInt(),
  date: DateTime.parse(json['date'] as String),
  status: json['status'] as String,
);

Map<String, dynamic> _$ScoreModelToJson(ScoreModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'questionId': instance.questionId,
      'categorie': instance.categorie,
      'note': instance.note,
      'date': instance.date.toIso8601String(),
      'status': instance.status,
    };
