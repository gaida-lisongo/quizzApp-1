import 'package:json_annotation/json_annotation.dart';
import 'recharge_model.dart';
import 'score_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  final String id;
  final String pseudo;

  @JsonKey(name: 'secure', includeToJson: false)
  final String secure;

  final String email;
  final double solde;
  final int pieces;
  final int bonus;

  final List<RechargeModel> recharges;
  final List<ScoreModel> scores;

  const UserModel({
    required this.id,
    required this.pseudo,
    required this.secure,
    required this.email,
    this.solde = 0.0,
    this.pieces = 0,
    this.bonus = 0,
    this.recharges = const [],
    this.scores = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? id,
    String? pseudo,
    String? secure,
    String? email,
    double? solde,
    int? pieces,
    int? bonus,
    List<RechargeModel>? recharges,
    List<ScoreModel>? scores,
  }) {
    return UserModel(
      id: id ?? this.id,
      pseudo: pseudo ?? this.pseudo,
      secure: secure ?? this.secure,
      email: email ?? this.email,
      solde: solde ?? this.solde,
      pieces: pieces ?? this.pieces,
      bonus: bonus ?? this.bonus,
      recharges: recharges ?? this.recharges,
      scores: scores ?? this.scores,
    );
  }
}