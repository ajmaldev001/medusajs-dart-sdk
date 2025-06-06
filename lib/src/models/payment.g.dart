// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
  id: json['id'] as String,
  swapId: json['swapId'] as String?,
  cartId: json['cartId'] as String?,
  orderId: json['orderId'] as String?,
  amount: (json['amount'] as num).toInt(),
  currencyCode: json['currencyCode'] as String,
  amountRefunded: (json['amountRefunded'] as num).toInt(),
  providerId: json['providerId'] as String,
  data: json['data'] as Map<String, dynamic>,
  capturedAt:
      json['capturedAt'] == null
          ? null
          : DateTime.parse(json['capturedAt'] as String),
  canceledAt:
      json['canceledAt'] == null
          ? null
          : DateTime.parse(json['canceledAt'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
  'id': instance.id,
  'swapId': instance.swapId,
  'cartId': instance.cartId,
  'orderId': instance.orderId,
  'amount': instance.amount,
  'currencyCode': instance.currencyCode,
  'amountRefunded': instance.amountRefunded,
  'providerId': instance.providerId,
  'data': instance.data,
  'capturedAt': instance.capturedAt?.toIso8601String(),
  'canceledAt': instance.canceledAt?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'metadata': instance.metadata,
};
