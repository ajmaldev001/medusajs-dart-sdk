// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
  id: json['id'] as String,
  customerId: json['customer_id'] as String?,
  email: json['email'] as String?,
  billingAddressId: json['billing_address_id'] as String?,
  shippingAddressId: json['shipping_address_id'] as String?,
  regionId: json['region_id'] as String,
  currencyCode: json['currency_code'] as String,
  taxRate: (json['tax_rate'] as num?)?.toDouble(),
  type:
      $enumDecodeNullable(_$CartTypeEnumMap, json['type']) ??
      CartType.defaultCart,
  completedAt:
      json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
  paymentAuthorizedAt:
      json['payment_authorized_at'] == null
          ? null
          : DateTime.parse(json['payment_authorized_at'] as String),
  idempotencyKey: json['idempotency_key'] as String?,
  context: json['context'] as Map<String, dynamic>?,
  total: (json['total'] as num?)?.toDouble() ?? 0.0,
  subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
  taxTotal: (json['tax_total'] as num?)?.toDouble() ?? 0.0,
  shippingTotal: (json['shipping_total'] as num?)?.toDouble() ?? 0.0,
  discountTotal: (json['discount_total'] as num?)?.toDouble() ?? 0.0,
  giftCardTotal: (json['gift_card_total'] as num?)?.toInt(),
  giftCardTaxTotal: (json['gift_card_tax_total'] as num?)?.toInt(),
  itemCount: (json['item_count'] as num?)?.toInt(),
  salesChannelId: json['sales_channel_id'] as String?,
  discountSubtotal: (json['discount_subtotal'] as num?)?.toInt(),
  discountTaxTotal: (json['discount_tax_total'] as num?)?.toInt(),
  originalTotal: (json['original_total'] as num?)?.toInt(),
  originalTaxTotal: (json['original_tax_total'] as num?)?.toInt(),
  itemTotal: (json['item_total'] as num?)?.toInt(),
  itemSubtotal: (json['item_subtotal'] as num?)?.toInt(),
  itemTaxTotal: (json['item_tax_total'] as num?)?.toInt(),
  originalItemTotal: (json['original_item_total'] as num?)?.toInt(),
  originalItemSubtotal: (json['original_item_subtotal'] as num?)?.toInt(),
  originalItemTaxTotal: (json['original_item_tax_total'] as num?)?.toInt(),
  shippingSubtotal: (json['shipping_subtotal'] as num?)?.toInt(),
  shippingTaxTotal: (json['shipping_tax_total'] as num?)?.toInt(),
  originalShippingTaxTotal:
      (json['original_shipping_tax_total'] as num?)?.toInt(),
  originalShippingSubtotal:
      (json['original_shipping_subtotal'] as num?)?.toInt(),
  originalShippingTotal: (json['original_shipping_total'] as num?)?.toInt(),
  creditLineSubtotal: (json['credit_line_subtotal'] as num?)?.toInt(),
  creditLineTaxTotal: (json['credit_line_tax_total'] as num?)?.toInt(),
  creditLineTotal: (json['credit_line_total'] as num?)?.toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  deletedAt:
      json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
  'id': instance.id,
  'customer_id': instance.customerId,
  'email': instance.email,
  'billing_address_id': instance.billingAddressId,
  'shipping_address_id': instance.shippingAddressId,
  'region_id': instance.regionId,
  'currency_code': instance.currencyCode,
  'tax_rate': instance.taxRate,
  'type': _$CartTypeEnumMap[instance.type]!,
  'completed_at': instance.completedAt?.toIso8601String(),
  'payment_authorized_at': instance.paymentAuthorizedAt?.toIso8601String(),
  'idempotency_key': instance.idempotencyKey,
  'context': instance.context,
  'total': instance.total,
  'subtotal': instance.subtotal,
  'tax_total': instance.taxTotal,
  'shipping_total': instance.shippingTotal,
  'discount_total': instance.discountTotal,
  'gift_card_total': instance.giftCardTotal,
  'gift_card_tax_total': instance.giftCardTaxTotal,
  'item_count': instance.itemCount,
  'sales_channel_id': instance.salesChannelId,
  'discount_subtotal': instance.discountSubtotal,
  'discount_tax_total': instance.discountTaxTotal,
  'original_total': instance.originalTotal,
  'original_tax_total': instance.originalTaxTotal,
  'item_total': instance.itemTotal,
  'item_subtotal': instance.itemSubtotal,
  'item_tax_total': instance.itemTaxTotal,
  'original_item_total': instance.originalItemTotal,
  'original_item_subtotal': instance.originalItemSubtotal,
  'original_item_tax_total': instance.originalItemTaxTotal,
  'shipping_subtotal': instance.shippingSubtotal,
  'shipping_tax_total': instance.shippingTaxTotal,
  'original_shipping_tax_total': instance.originalShippingTaxTotal,
  'original_shipping_subtotal': instance.originalShippingSubtotal,
  'original_shipping_total': instance.originalShippingTotal,
  'credit_line_subtotal': instance.creditLineSubtotal,
  'credit_line_tax_total': instance.creditLineTaxTotal,
  'credit_line_total': instance.creditLineTotal,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'deleted_at': instance.deletedAt?.toIso8601String(),
  'metadata': instance.metadata,
};

const _$CartTypeEnumMap = {
  CartType.defaultCart: 'default',
  CartType.swap: 'swap',
  CartType.draftOrder: 'draft_order',
  CartType.paymentLink: 'payment_link',
  CartType.claim: 'claim',
};
