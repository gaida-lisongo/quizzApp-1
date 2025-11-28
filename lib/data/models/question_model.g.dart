// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: json['_id'] as String,
      enonce: json['enonce'] as String,
      categorieId: json['categorieId'] as String,
      choix: (json['choix'] as List<dynamic>).map((e) => e as String).toList(),
      correctAnswer: json['correctAnswer'] as String,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'enonce': instance.enonce,
      'categorieId': instance.categorieId,
      'choix': instance.choix,
      'correctAnswer': instance.correctAnswer,
    };
