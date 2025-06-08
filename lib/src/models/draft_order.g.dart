// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DraftOrder _$DraftOrderFromJson(Map<String, dynamic> json) => DraftOrder(
  id: json['id'] as String,
  status: $enumDecode(_$DraftOrderStatusEnumMap, json['status']),
  displayId: json['displayId'] as String?,
  cartId: json['cartId'] as String?,
  orderId: json['orderId'] as String?,
  regionId: json['regionId'] as String?,
  customerId: json['customerId'] as String?,
  salesChannelId: json['salesChannelId'] as String?,
  email: json['email'] as String,
  currencyCode: json['currencyCode'] as String?,
  shippingAddressId: json['shippingAddressId'] as String?,
  billingAddressId: json['billingAddressId'] as String?,
  subtotal: (json['subtotal'] as num?)?.toInt(),
  taxTotal: (json['taxTotal'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
  completedAt:
      json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
  noNotificationOrder: json['noNotificationOrder'] as bool?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$DraftOrderToJson(DraftOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$DraftOrderStatusEnumMap[instance.status]!,
      'displayId': instance.displayId,
      'cartId': instance.cartId,
      'orderId': instance.orderId,
      'regionId': instance.regionId,
      'customerId': instance.customerId,
      'salesChannelId': instance.salesChannelId,
      'email': instance.email,
      'currencyCode': instance.currencyCode,
      'shippingAddressId': instance.shippingAddressId,
      'billingAddressId': instance.billingAddressId,
      'subtotal': instance.subtotal,
      'taxTotal': instance.taxTotal,
      'total': instance.total,
      'completedAt': instance.completedAt?.toIso8601String(),
      'noNotificationOrder': instance.noNotificationOrder,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

const _$DraftOrderStatusEnumMap = {
  DraftOrderStatus.open: 'open',
  DraftOrderStatus.completed: 'completed',
};

CreateDraftOrderRequest _$CreateDraftOrderRequestFromJson(
  Map<String, dynamic> json,
) => CreateDraftOrderRequest(
  email: json['email'] as String,
  regionId: json['regionId'] as String?,
  customerId: json['customerId'] as String?,
  salesChannelId: json['salesChannelId'] as String?,
  shippingAddress: json['shippingAddress'] as Map<String, dynamic>?,
  billingAddress: json['billingAddress'] as Map<String, dynamic>?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) =>
                CreateDraftOrderItemRequest.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  discounts:
      (json['discounts'] as List<dynamic>?)
          ?.map(
            (e) => CreateDraftOrderDiscountRequest.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
  noNotificationOrder: json['noNotificationOrder'] as bool?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateDraftOrderRequestToJson(
  CreateDraftOrderRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'regionId': instance.regionId,
  'customerId': instance.customerId,
  'salesChannelId': instance.salesChannelId,
  'shippingAddress': instance.shippingAddress,
  'billingAddress': instance.billingAddress,
  'items': instance.items,
  'discounts': instance.discounts,
  'noNotificationOrder': instance.noNotificationOrder,
  'metadata': instance.metadata,
};

CreateDraftOrderItemRequest _$CreateDraftOrderItemRequestFromJson(
  Map<String, dynamic> json,
) => CreateDraftOrderItemRequest(
  variantId: json['variantId'] as String,
  quantity: (json['quantity'] as num).toInt(),
  unitPrice: (json['unitPrice'] as num?)?.toInt(),
  title: json['title'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateDraftOrderItemRequestToJson(
  CreateDraftOrderItemRequest instance,
) => <String, dynamic>{
  'variantId': instance.variantId,
  'quantity': instance.quantity,
  'unitPrice': instance.unitPrice,
  'title': instance.title,
  'metadata': instance.metadata,
};

CreateDraftOrderDiscountRequest _$CreateDraftOrderDiscountRequestFromJson(
  Map<String, dynamic> json,
) => CreateDraftOrderDiscountRequest(code: json['code'] as String);

Map<String, dynamic> _$CreateDraftOrderDiscountRequestToJson(
  CreateDraftOrderDiscountRequest instance,
) => <String, dynamic>{'code': instance.code};

UpdateDraftOrderRequest _$UpdateDraftOrderRequestFromJson(
  Map<String, dynamic> json,
) => UpdateDraftOrderRequest(
  regionId: json['regionId'] as String?,
  customerId: json['customerId'] as String?,
  email: json['email'] as String?,
  shippingAddress: json['shippingAddress'] as Map<String, dynamic>?,
  billingAddress: json['billingAddress'] as Map<String, dynamic>?,
  noNotificationOrder: json['noNotificationOrder'] as bool?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UpdateDraftOrderRequestToJson(
  UpdateDraftOrderRequest instance,
) => <String, dynamic>{
  'regionId': instance.regionId,
  'customerId': instance.customerId,
  'email': instance.email,
  'shippingAddress': instance.shippingAddress,
  'billingAddress': instance.billingAddress,
  'noNotificationOrder': instance.noNotificationOrder,
  'metadata': instance.metadata,
};

CompleteDraftOrderRequest _$CompleteDraftOrderRequestFromJson(
  Map<String, dynamic> json,
) => CompleteDraftOrderRequest(
  noNotificationOrder: json['noNotificationOrder'] as bool?,
);

Map<String, dynamic> _$CompleteDraftOrderRequestToJson(
  CompleteDraftOrderRequest instance,
) => <String, dynamic>{'noNotificationOrder': instance.noNotificationOrder};

RegisterPaymentRequest _$RegisterPaymentRequestFromJson(
  Map<String, dynamic> json,
) => RegisterPaymentRequest(amount: (json['amount'] as num).toInt());

Map<String, dynamic> _$RegisterPaymentRequestToJson(
  RegisterPaymentRequest instance,
) => <String, dynamic>{'amount': instance.amount};

DraftOrderResponse _$DraftOrderResponseFromJson(Map<String, dynamic> json) =>
    DraftOrderResponse(
      draftOrder: DraftOrder.fromJson(
        json['draftOrder'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$DraftOrderResponseToJson(DraftOrderResponse instance) =>
    <String, dynamic>{'draftOrder': instance.draftOrder};

DraftOrdersResponse _$DraftOrdersResponseFromJson(Map<String, dynamic> json) =>
    DraftOrdersResponse(
      draftOrders:
          (json['draftOrders'] as List<dynamic>)
              .map((e) => DraftOrder.fromJson(e as Map<String, dynamic>))
              .toList(),
      count: (json['count'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$DraftOrdersResponseToJson(
  DraftOrdersResponse instance,
) => <String, dynamic>{
  'draftOrders': instance.draftOrders,
  'count': instance.count,
  'offset': instance.offset,
  'limit': instance.limit,
};
