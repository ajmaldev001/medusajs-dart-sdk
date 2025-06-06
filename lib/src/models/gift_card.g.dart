// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiftCard _$GiftCardFromJson(Map<String, dynamic> json) => GiftCard(
  id: json['id'] as String,
  code: json['code'] as String,
  value: (json['value'] as num).toInt(),
  balance: (json['balance'] as num).toInt(),
  regionId: json['regionId'] as String?,
  orderId: json['orderId'] as String?,
  isDisabled: json['isDisabled'] as bool? ?? false,
  endsAt:
      json['endsAt'] == null ? null : DateTime.parse(json['endsAt'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$GiftCardToJson(GiftCard instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'value': instance.value,
  'balance': instance.balance,
  'regionId': instance.regionId,
  'orderId': instance.orderId,
  'isDisabled': instance.isDisabled,
  'endsAt': instance.endsAt?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
  'metadata': instance.metadata,
};
