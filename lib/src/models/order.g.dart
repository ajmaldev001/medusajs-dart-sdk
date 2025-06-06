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
    json['fulfillmentStatus'],
  ),
  paymentStatus: $enumDecode(_$PaymentStatusEnumMap, json['paymentStatus']),
  displayId: (json['displayId'] as num).toInt(),
  cartId: json['cartId'] as String?,
  customerId: json['customerId'] as String?,
  email: json['email'] as String,
  billingAddressId: json['billingAddressId'] as String?,
  shippingAddressId: json['shippingAddressId'] as String?,
  regionId: json['regionId'] as String,
  currencyCode: json['currencyCode'] as String,
  taxRate: (json['taxRate'] as num?)?.toDouble(),
  total: (json['total'] as num).toInt(),
  subtotal: (json['subtotal'] as num).toInt(),
  taxTotal: (json['taxTotal'] as num).toInt(),
  shippingTotal: (json['shippingTotal'] as num).toInt(),
  discountTotal: (json['discountTotal'] as num).toInt(),
  giftCardTotal: (json['giftCardTotal'] as num).toInt(),
  giftCardTaxTotal: (json['giftCardTaxTotal'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'id': instance.id,
  'status': _$OrderStatusEnumMap[instance.status]!,
  'fulfillmentStatus': _$FulfillmentStatusEnumMap[instance.fulfillmentStatus]!,
  'paymentStatus': _$PaymentStatusEnumMap[instance.paymentStatus]!,
  'displayId': instance.displayId,
  'cartId': instance.cartId,
  'customerId': instance.customerId,
  'email': instance.email,
  'billingAddressId': instance.billingAddressId,
  'shippingAddressId': instance.shippingAddressId,
  'regionId': instance.regionId,
  'currencyCode': instance.currencyCode,
  'taxRate': instance.taxRate,
  'total': instance.total,
  'subtotal': instance.subtotal,
  'taxTotal': instance.taxTotal,
  'shippingTotal': instance.shippingTotal,
  'discountTotal': instance.discountTotal,
  'giftCardTotal': instance.giftCardTotal,
  'giftCardTaxTotal': instance.giftCardTaxTotal,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
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
