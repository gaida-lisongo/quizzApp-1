// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['_id'] as String,
  pseudo: json['pseudo'] as String,
  secure: json['secure'] as String,
  email: json['email'] as String,
  solde: (json['solde'] as num?)?.toDouble() ?? 0.0,
  pieces: (json['pieces'] as num?)?.toInt() ?? 0,
  bonus: (json['bonus'] as num?)?.toInt() ?? 0,
  recharges:
      (json['recharges'] as List<dynamic>?)
          ?.map((e) => RechargeModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  scores:
      (json['scores'] as List<dynamic>?)
          ?.map((e) => ScoreModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  '_id': instance.id,
  'pseudo': instance.pseudo,
  'email': instance.email,
  'solde': instance.solde,
  'pieces': instance.pieces,
  'bonus': instance.bonus,
  'recharges': instance.recharges,
  'scores': instance.scores,
};
