// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeItem _$ExchangeItemFromJson(Map<String, dynamic> json) => ExchangeItem(
  id: json['id'] as String,
  exchangeId: json['exchangeId'] as String,
  orderItemId: json['orderItemId'] as String,
  quantity: (json['quantity'] as num).toInt(),
  note: json['note'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ExchangeItemToJson(ExchangeItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exchangeId': instance.exchangeId,
      'orderItemId': instance.orderItemId,
      'quantity': instance.quantity,
      'note': instance.note,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

AdditionalExchangeItem _$AdditionalExchangeItemFromJson(
  Map<String, dynamic> json,
) => AdditionalExchangeItem(
  id: json['id'] as String,
  exchangeId: json['exchangeId'] as String,
  variantId: json['variantId'] as String,
  quantity: (json['quantity'] as num).toInt(),
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$AdditionalExchangeItemToJson(
  AdditionalExchangeItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'exchangeId': instance.exchangeId,
  'variantId': instance.variantId,
  'quantity': instance.quantity,
  'metadata': instance.metadata,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

Exchange _$ExchangeFromJson(Map<String, dynamic> json) => Exchange(
  id: json['id'] as String,
  status: $enumDecode(_$ExchangeStatusEnumMap, json['status']),
  paymentStatus: $enumDecode(
    _$ExchangePaymentStatusEnumMap,
    json['paymentStatus'],
  ),
  fulfillmentStatus: $enumDecode(
    _$ExchangeFulfillmentStatusEnumMap,
    json['fulfillmentStatus'],
  ),
  orderId: json['orderId'] as String,
  exchangeItems:
      (json['exchangeItems'] as List<dynamic>?)
          ?.map((e) => ExchangeItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  additionalItems:
      (json['additionalItems'] as List<dynamic>?)
          ?.map(
            (e) => AdditionalExchangeItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  returnId: json['returnId'] as String?,
  cartId: json['cartId'] as String?,
  differenceDue: (json['differenceDue'] as num?)?.toInt(),
  shippingAddressId: json['shippingAddressId'] as String?,
  allowBackorder: json['allowBackorder'] as bool?,
  completedAt:
      json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
  canceledAt:
      json['canceledAt'] == null
          ? null
          : DateTime.parse(json['canceledAt'] as String),
  note: json['note'] as String?,
  noNotification: json['noNotification'] as bool?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$ExchangeToJson(Exchange instance) => <String, dynamic>{
  'id': instance.id,
  'status': _$ExchangeStatusEnumMap[instance.status]!,
  'paymentStatus': _$ExchangePaymentStatusEnumMap[instance.paymentStatus]!,
  'fulfillmentStatus':
      _$ExchangeFulfillmentStatusEnumMap[instance.fulfillmentStatus]!,
  'orderId': instance.orderId,
  'exchangeItems': instance.exchangeItems,
  'additionalItems': instance.additionalItems,
  'returnId': instance.returnId,
  'cartId': instance.cartId,
  'differenceDue': instance.differenceDue,
  'shippingAddressId': instance.shippingAddressId,
  'allowBackorder': instance.allowBackorder,
  'completedAt': instance.completedAt?.toIso8601String(),
  'canceledAt': instance.canceledAt?.toIso8601String(),
  'note': instance.note,
  'noNotification': instance.noNotification,
  'metadata': instance.metadata,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
};

const _$ExchangeStatusEnumMap = {
  ExchangeStatus.draft: 'draft',
  ExchangeStatus.requested: 'requested',
  ExchangeStatus.received: 'received',
  ExchangeStatus.completed: 'completed',
  ExchangeStatus.canceled: 'canceled',
};

const _$ExchangePaymentStatusEnumMap = {
  ExchangePaymentStatus.notPaid: 'not_paid',
  ExchangePaymentStatus.paid: 'paid',
  ExchangePaymentStatus.refunded: 'refunded',
  ExchangePaymentStatus.partiallyRefunded: 'partially_refunded',
};

const _$ExchangeFulfillmentStatusEnumMap = {
  ExchangeFulfillmentStatus.notFulfilled: 'not_fulfilled',
  ExchangeFulfillmentStatus.fulfilled: 'fulfilled',
  ExchangeFulfillmentStatus.shipped: 'shipped',
  ExchangeFulfillmentStatus.partiallyShipped: 'partially_shipped',
  ExchangeFulfillmentStatus.canceled: 'canceled',
  ExchangeFulfillmentStatus.requiresAction: 'requires_action',
};

CreateExchangeRequest _$CreateExchangeRequestFromJson(
  Map<String, dynamic> json,
) => CreateExchangeRequest(
  orderId: json['orderId'] as String,
  exchangeItems:
      (json['exchangeItems'] as List<dynamic>)
          .map(
            (e) =>
                CreateExchangeItemRequest.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  additionalItems:
      (json['additionalItems'] as List<dynamic>?)
          ?.map(
            (e) => CreateAdditionalExchangeItemRequest.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
  shippingAddressId: json['shippingAddressId'] as String?,
  allowBackorder: json['allowBackorder'] as bool?,
  noNotification: json['noNotification'] as bool?,
  note: json['note'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateExchangeRequestToJson(
  CreateExchangeRequest instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'exchangeItems': instance.exchangeItems,
  'additionalItems': instance.additionalItems,
  'shippingAddressId': instance.shippingAddressId,
  'allowBackorder': instance.allowBackorder,
  'noNotification': instance.noNotification,
  'note': instance.note,
  'metadata': instance.metadata,
};

CreateExchangeItemRequest _$CreateExchangeItemRequestFromJson(
  Map<String, dynamic> json,
) => CreateExchangeItemRequest(
  orderItemId: json['orderItemId'] as String,
  quantity: (json['quantity'] as num).toInt(),
  note: json['note'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateExchangeItemRequestToJson(
  CreateExchangeItemRequest instance,
) => <String, dynamic>{
  'orderItemId': instance.orderItemId,
  'quantity': instance.quantity,
  'note': instance.note,
  'metadata': instance.metadata,
};

CreateAdditionalExchangeItemRequest
_$CreateAdditionalExchangeItemRequestFromJson(Map<String, dynamic> json) =>
    CreateAdditionalExchangeItemRequest(
      variantId: json['variantId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CreateAdditionalExchangeItemRequestToJson(
  CreateAdditionalExchangeItemRequest instance,
) => <String, dynamic>{
  'variantId': instance.variantId,
  'quantity': instance.quantity,
  'metadata': instance.metadata,
};

UpdateExchangeRequest _$UpdateExchangeRequestFromJson(
  Map<String, dynamic> json,
) => UpdateExchangeRequest(
  note: json['note'] as String?,
  noNotification: json['noNotification'] as bool?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UpdateExchangeRequestToJson(
  UpdateExchangeRequest instance,
) => <String, dynamic>{
  'note': instance.note,
  'noNotification': instance.noNotification,
  'metadata': instance.metadata,
};

CancelExchangeRequest _$CancelExchangeRequestFromJson(
  Map<String, dynamic> json,
) => CancelExchangeRequest(noNotification: json['noNotification'] as bool?);

Map<String, dynamic> _$CancelExchangeRequestToJson(
  CancelExchangeRequest instance,
) => <String, dynamic>{'noNotification': instance.noNotification};

ProcessExchangePaymentRequest _$ProcessExchangePaymentRequestFromJson(
  Map<String, dynamic> json,
) => ProcessExchangePaymentRequest(amount: (json['amount'] as num).toInt());

Map<String, dynamic> _$ProcessExchangePaymentRequestToJson(
  ProcessExchangePaymentRequest instance,
) => <String, dynamic>{'amount': instance.amount};

ExchangeResponse _$ExchangeResponseFromJson(Map<String, dynamic> json) =>
    ExchangeResponse(
      exchange: Exchange.fromJson(json['exchange'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExchangeResponseToJson(ExchangeResponse instance) =>
    <String, dynamic>{'exchange': instance.exchange};

ExchangesResponse _$ExchangesResponseFromJson(Map<String, dynamic> json) =>
    ExchangesResponse(
      exchanges:
          (json['exchanges'] as List<dynamic>)
              .map((e) => Exchange.fromJson(e as Map<String, dynamic>))
              .toList(),
      count: (json['count'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$ExchangesResponseToJson(ExchangesResponse instance) =>
    <String, dynamic>{
      'exchanges': instance.exchanges,
      'count': instance.count,
      'offset': instance.offset,
      'limit': instance.limit,
    };
