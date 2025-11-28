// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recharge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RechargeModel _$RechargeModelFromJson(Map<String, dynamic> json) =>
    RechargeModel(
      id: json['_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      phone: json['phone'] as String,
      currency: json['currency'] as String,
      orderNumber: json['orderNumber'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$RechargeModelToJson(RechargeModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'amount': instance.amount,
      'phone': instance.phone,
      'currency': instance.currency,
      'orderNumber': instance.orderNumber,
      'status': instance.status,
    };
