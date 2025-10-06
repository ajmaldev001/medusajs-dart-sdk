// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditLine _$CreditLineFromJson(Map<String, dynamic> json) => CreditLine(
  id: json['id'] as String,
  cartId: json['cart_id'] as String,
  amount: (json['amount'] as num).toDouble(),
  reference: json['reference'] as String?,
  referenceId: json['reference_id'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$CreditLineToJson(CreditLine instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cart_id': instance.cartId,
      'amount': instance.amount,
      'reference': instance.reference,
      'reference_id': instance.referenceId,
      'metadata': instance.metadata,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
