// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimItem _$ClaimItemFromJson(Map<String, dynamic> json) => ClaimItem(
  id: json['id'] as String,
  itemId: json['itemId'] as String,
  variantId: json['variantId'] as String,
  claimOrderId: json['claimOrderId'] as String,
  quantity: (json['quantity'] as num).toInt(),
  reason: json['reason'] as String?,
  note: json['note'] as String?,
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$ClaimItemToJson(ClaimItem instance) => <String, dynamic>{
  'id': instance.id,
  'itemId': instance.itemId,
  'variantId': instance.variantId,
  'claimOrderId': instance.claimOrderId,
  'quantity': instance.quantity,
  'reason': instance.reason,
  'note': instance.note,
  'images': instance.images,
  'metadata': instance.metadata,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
};

AdditionalClaimItem _$AdditionalClaimItemFromJson(Map<String, dynamic> json) =>
    AdditionalClaimItem(
      id: json['id'] as String,
      variantId: json['variantId'] as String,
      claimOrderId: json['claimOrderId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt:
          json['deletedAt'] == null
              ? null
              : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$AdditionalClaimItemToJson(
  AdditionalClaimItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'variantId': instance.variantId,
  'claimOrderId': instance.claimOrderId,
  'quantity': instance.quantity,
  'metadata': instance.metadata,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
};

ClaimOrder _$ClaimOrderFromJson(Map<String, dynamic> json) => ClaimOrder(
  id: json['id'] as String,
  paymentStatus: $enumDecode(
    _$ClaimPaymentStatusEnumMap,
    json['paymentStatus'],
  ),
  fulfillmentStatus: $enumDecode(
    _$ClaimFulfillmentStatusEnumMap,
    json['fulfillmentStatus'],
  ),
  type: $enumDecode(_$ClaimTypeEnumMap, json['type']),
  orderId: json['orderId'] as String,
  shippingAddressId: json['shippingAddressId'] as String?,
  claimItems:
      (json['claimItems'] as List<dynamic>?)
          ?.map((e) => ClaimItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  additionalItems:
      (json['additionalItems'] as List<dynamic>?)
          ?.map((e) => AdditionalClaimItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  returnOrderId: json['returnOrderId'] as String?,
  refundAmount: (json['refundAmount'] as num?)?.toInt(),
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

Map<String, dynamic> _$ClaimOrderToJson(ClaimOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paymentStatus': _$ClaimPaymentStatusEnumMap[instance.paymentStatus]!,
      'fulfillmentStatus':
          _$ClaimFulfillmentStatusEnumMap[instance.fulfillmentStatus]!,
      'type': _$ClaimTypeEnumMap[instance.type]!,
      'orderId': instance.orderId,
      'shippingAddressId': instance.shippingAddressId,
      'claimItems': instance.claimItems,
      'additionalItems': instance.additionalItems,
      'returnOrderId': instance.returnOrderId,
      'refundAmount': instance.refundAmount,
      'canceledAt': instance.canceledAt?.toIso8601String(),
      'note': instance.note,
      'noNotification': instance.noNotification,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

const _$ClaimPaymentStatusEnumMap = {
  ClaimPaymentStatus.na: 'na',
  ClaimPaymentStatus.notRefunded: 'not_refunded',
  ClaimPaymentStatus.refunded: 'refunded',
};

const _$ClaimFulfillmentStatusEnumMap = {
  ClaimFulfillmentStatus.notFulfilled: 'not_fulfilled',
  ClaimFulfillmentStatus.partiallyFulfilled: 'partially_fulfilled',
  ClaimFulfillmentStatus.fulfilled: 'fulfilled',
  ClaimFulfillmentStatus.partiallyShipped: 'partially_shipped',
  ClaimFulfillmentStatus.shipped: 'shipped',
  ClaimFulfillmentStatus.partiallyReturned: 'partially_returned',
  ClaimFulfillmentStatus.returned: 'returned',
  ClaimFulfillmentStatus.canceled: 'canceled',
  ClaimFulfillmentStatus.requiresAction: 'requires_action',
};

const _$ClaimTypeEnumMap = {
  ClaimType.replace: 'replace',
  ClaimType.refund: 'refund',
};

CreateClaimRequest _$CreateClaimRequestFromJson(Map<String, dynamic> json) =>
    CreateClaimRequest(
      orderId: json['orderId'] as String,
      type: $enumDecode(_$ClaimTypeEnumMap, json['type']),
      claimItems:
          (json['claimItems'] as List<dynamic>)
              .map(
                (e) =>
                    CreateClaimItemRequest.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      additionalItems:
          (json['additionalItems'] as List<dynamic>?)
              ?.map(
                (e) => CreateAdditionalClaimItemRequest.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
      shippingAddressId: json['shippingAddressId'] as String?,
      returnShipping: json['returnShipping'] as bool?,
      noNotification: json['noNotification'] as bool?,
      note: json['note'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CreateClaimRequestToJson(CreateClaimRequest instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'type': _$ClaimTypeEnumMap[instance.type]!,
      'claimItems': instance.claimItems,
      'additionalItems': instance.additionalItems,
      'shippingAddressId': instance.shippingAddressId,
      'returnShipping': instance.returnShipping,
      'noNotification': instance.noNotification,
      'note': instance.note,
      'metadata': instance.metadata,
    };

CreateClaimItemRequest _$CreateClaimItemRequestFromJson(
  Map<String, dynamic> json,
) => CreateClaimItemRequest(
  itemId: json['itemId'] as String,
  quantity: (json['quantity'] as num).toInt(),
  reason: json['reason'] as String?,
  note: json['note'] as String?,
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateClaimItemRequestToJson(
  CreateClaimItemRequest instance,
) => <String, dynamic>{
  'itemId': instance.itemId,
  'quantity': instance.quantity,
  'reason': instance.reason,
  'note': instance.note,
  'images': instance.images,
  'metadata': instance.metadata,
};

CreateAdditionalClaimItemRequest _$CreateAdditionalClaimItemRequestFromJson(
  Map<String, dynamic> json,
) => CreateAdditionalClaimItemRequest(
  variantId: json['variantId'] as String,
  quantity: (json['quantity'] as num).toInt(),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateAdditionalClaimItemRequestToJson(
  CreateAdditionalClaimItemRequest instance,
) => <String, dynamic>{
  'variantId': instance.variantId,
  'quantity': instance.quantity,
  'metadata': instance.metadata,
};

UpdateClaimRequest _$UpdateClaimRequestFromJson(Map<String, dynamic> json) =>
    UpdateClaimRequest(
      note: json['note'] as String?,
      noNotification: json['noNotification'] as bool?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UpdateClaimRequestToJson(UpdateClaimRequest instance) =>
    <String, dynamic>{
      'note': instance.note,
      'noNotification': instance.noNotification,
      'metadata': instance.metadata,
    };

CancelClaimRequest _$CancelClaimRequestFromJson(Map<String, dynamic> json) =>
    CancelClaimRequest(noNotification: json['noNotification'] as bool?);

Map<String, dynamic> _$CancelClaimRequestToJson(CancelClaimRequest instance) =>
    <String, dynamic>{'noNotification': instance.noNotification};

ClaimResponse _$ClaimResponseFromJson(Map<String, dynamic> json) =>
    ClaimResponse(
      claim: ClaimOrder.fromJson(json['claim'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClaimResponseToJson(ClaimResponse instance) =>
    <String, dynamic>{'claim': instance.claim};

ClaimsResponse _$ClaimsResponseFromJson(Map<String, dynamic> json) =>
    ClaimsResponse(
      claims:
          (json['claims'] as List<dynamic>)
              .map((e) => ClaimOrder.fromJson(e as Map<String, dynamic>))
              .toList(),
      count: (json['count'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$ClaimsResponseToJson(ClaimsResponse instance) =>
    <String, dynamic>{
      'claims': instance.claims,
      'count': instance.count,
      'offset': instance.offset,
      'limit': instance.limit,
    };
