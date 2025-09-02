// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
  id: json['id'] as String,
  status: $enumDecode(_$OrderStatusEnumMap, json['status']),
  fulfillmentStatus: $enumDecode(
    _$FulfillmentStatusEnumMap,
    json['fulfillment_status'],
  ),
  paymentStatus: $enumDecode(_$PaymentStatusEnumMap, json['payment_status']),
  displayId: (json['display_id'] as num).toInt(),
  cartId: json['cart_id'] as String?,
  customerId: json['customer_id'] as String?,
  email: json['email'] as String,
  billingAddressId: json['billing_address_id'] as String?,
  shippingAddressId: json['shipping_address_id'] as String?,
  regionId: json['region_id'] as String,
  currencyCode: json['currency_code'] as String,
  taxRate: (json['tax_rate'] as num?)?.toDouble(),
  total: (json['total'] as num).toInt(),
  subtotal: (json['subtotal'] as num).toInt(),
  taxTotal: (json['tax_total'] as num).toInt(),
  shippingTotal: (json['shipping_total'] as num).toInt(),
  discountTotal: (json['discount_total'] as num).toInt(),
  giftCardTotal: (json['gift_card_total'] as num).toInt(),
  giftCardTaxTotal: (json['gift_card_tax_total'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'id': instance.id,
  'status': _$OrderStatusEnumMap[instance.status]!,
  'fulfillment_status': _$FulfillmentStatusEnumMap[instance.fulfillmentStatus]!,
  'payment_status': _$PaymentStatusEnumMap[instance.paymentStatus]!,
  'display_id': instance.displayId,
  'cart_id': instance.cartId,
  'customer_id': instance.customerId,
  'email': instance.email,
  'billing_address_id': instance.billingAddressId,
  'shipping_address_id': instance.shippingAddressId,
  'region_id': instance.regionId,
  'currency_code': instance.currencyCode,
  'tax_rate': instance.taxRate,
  'total': instance.total,
  'subtotal': instance.subtotal,
  'tax_total': instance.taxTotal,
  'shipping_total': instance.shippingTotal,
  'discount_total': instance.discountTotal,
  'gift_card_total': instance.giftCardTotal,
  'gift_card_tax_total': instance.giftCardTaxTotal,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'metadata': instance.metadata,
};

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.completed: 'completed',
  OrderStatus.archived: 'archived',
  OrderStatus.canceled: 'canceled',
  OrderStatus.requiresAction: 'requires_action',
};

const _$FulfillmentStatusEnumMap = {
  FulfillmentStatus.notFulfilled: 'not_fulfilled',
  FulfillmentStatus.partiallyFulfilled: 'partially_fulfilled',
  FulfillmentStatus.fulfilled: 'fulfilled',
  FulfillmentStatus.partiallyShipped: 'partially_shipped',
  FulfillmentStatus.shipped: 'shipped',
  FulfillmentStatus.partiallyReturned: 'partially_returned',
  FulfillmentStatus.returned: 'returned',
  FulfillmentStatus.canceled: 'canceled',
  FulfillmentStatus.requiresAction: 'requires_action',
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.notPaid: 'not_paid',
  PaymentStatus.awaiting: 'awaiting',
  PaymentStatus.captured: 'captured',
  PaymentStatus.partiallyRefunded: 'partially_refunded',
  PaymentStatus.refunded: 'refunded',
  PaymentStatus.canceled: 'canceled',
  PaymentStatus.requiresAction: 'requires_action',
};
