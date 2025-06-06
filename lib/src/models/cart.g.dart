// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
  id: json['id'] as String,
  customerId: json['customerId'] as String?,
  email: json['email'] as String?,
  billingAddressId: json['billingAddressId'] as String?,
  shippingAddressId: json['shippingAddressId'] as String?,
  regionId: json['regionId'] as String,
  currencyCode: json['currencyCode'] as String,
  taxRate: (json['taxRate'] as num?)?.toDouble(),
  type:
      $enumDecodeNullable(_$CartTypeEnumMap, json['type']) ??
      CartType.defaultCart,
  completedAt:
      json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
  paymentAuthorizedAt:
      json['paymentAuthorizedAt'] == null
          ? null
          : DateTime.parse(json['paymentAuthorizedAt'] as String),
  idempotencyKey: json['idempotencyKey'] as String?,
  context: json['context'] as Map<String, dynamic>?,
  total: (json['total'] as num).toInt(),
  subtotal: (json['subtotal'] as num).toInt(),
  taxTotal: (json['taxTotal'] as num).toInt(),
  shippingTotal: (json['shippingTotal'] as num).toInt(),
  discountTotal: (json['discountTotal'] as num).toInt(),
  giftCardTotal: (json['giftCardTotal'] as num).toInt(),
  giftCardTaxTotal: (json['giftCardTaxTotal'] as num).toInt(),
  itemCount: (json['itemCount'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
  'id': instance.id,
  'customerId': instance.customerId,
  'email': instance.email,
  'billingAddressId': instance.billingAddressId,
  'shippingAddressId': instance.shippingAddressId,
  'regionId': instance.regionId,
  'currencyCode': instance.currencyCode,
  'taxRate': instance.taxRate,
  'type': _$CartTypeEnumMap[instance.type]!,
  'completedAt': instance.completedAt?.toIso8601String(),
  'paymentAuthorizedAt': instance.paymentAuthorizedAt?.toIso8601String(),
  'idempotencyKey': instance.idempotencyKey,
  'context': instance.context,
  'total': instance.total,
  'subtotal': instance.subtotal,
  'taxTotal': instance.taxTotal,
  'shippingTotal': instance.shippingTotal,
  'discountTotal': instance.discountTotal,
  'giftCardTotal': instance.giftCardTotal,
  'giftCardTaxTotal': instance.giftCardTaxTotal,
  'itemCount': instance.itemCount,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
  'metadata': instance.metadata,
};

const _$CartTypeEnumMap = {
  CartType.defaultCart: 'default',
  CartType.swap: 'swap',
  CartType.draftOrder: 'draft_order',
  CartType.paymentLink: 'payment_link',
  CartType.claim: 'claim',
};
