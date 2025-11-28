import 'package:json_annotation/json_annotation.dart';

part 'recharge_model.g.dart';

@JsonSerializable()
class RechargeModel {
  @JsonKey(name: '_id')
  final String id;
  final double amount;
  final String phone;
  final String currency;

  @JsonKey(name: 'orderNumber')
  final String orderNumber;
  final String status;

  const RechargeModel({
    required this.id,
    required this.amount,
    required this.phone,
    required this.currency,
    required this.orderNumber,
    required this.status,
  });

  factory RechargeModel.fromJson(Map<String, dynamic> json) =>
      _$RechargeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RechargeModelToJson(this);

  RechargeModel copyWith({
    String? id,
    double? amount,
    String? phone,
    String? currency,
    String? orderNumber,
    String? status,
  }) {
    return RechargeModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      phone: phone ?? this.phone,
      currency: currency ?? this.currency,
      orderNumber: orderNumber ?? this.orderNumber,
      status: status ?? this.status,
    );
  }
}