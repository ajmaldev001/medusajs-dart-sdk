// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_edit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEditChange _$OrderEditChangeFromJson(Map<String, dynamic> json) =>
    OrderEditChange(
      id: json['id'] as String,
      orderEditId: json['orderEditId'] as String,
      type: $enumDecode(_$OrderEditChangeTypeEnumMap, json['type']),
      originalLineItemId: json['originalLineItemId'] as String?,
      lineItemId: json['lineItemId'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$OrderEditChangeToJson(OrderEditChange instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderEditId': instance.orderEditId,
      'type': _$OrderEditChangeTypeEnumMap[instance.type]!,
      'originalLineItemId': instance.originalLineItemId,
      'lineItemId': instance.lineItemId,
      'data': instance.data,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$OrderEditChangeTypeEnumMap = {
  OrderEditChangeType.itemAdd: 'item_add',
  OrderEditChangeType.itemRemove: 'item_remove',
  OrderEditChangeType.itemUpdate: 'item_update',
  OrderEditChangeType.shippingAdd: 'shipping_add',
  OrderEditChangeType.shippingRemove: 'shipping_remove',
};

OrderEdit _$OrderEditFromJson(Map<String, dynamic> json) => OrderEdit(
  id: json['id'] as String,
  orderId: json['orderId'] as String,
  status: $enumDecode(_$OrderEditStatusEnumMap, json['status']),
  internalNote: json['internalNote'] as String?,
  createdBy: json['createdBy'] as String?,
  requestedBy: json['requestedBy'] as String?,
  requestedAt:
      json['requestedAt'] == null
          ? null
          : DateTime.parse(json['requestedAt'] as String),
  confirmedBy: json['confirmedBy'] as String?,
  confirmedAt:
      json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
  declinedBy: json['declinedBy'] as String?,
  declinedAt:
      json['declinedAt'] == null
          ? null
          : DateTime.parse(json['declinedAt'] as String),
  declinedReason: json['declinedReason'] as String?,
  canceledBy: json['canceledBy'] as String?,
  canceledAt:
      json['canceledAt'] == null
          ? null
          : DateTime.parse(json['canceledAt'] as String),
  changes:
      (json['changes'] as List<dynamic>?)
          ?.map((e) => OrderEditChange.fromJson(e as Map<String, dynamic>))
          .toList(),
  subtotal: (json['subtotal'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
  differenceDue: (json['differenceDue'] as num?)?.toInt(),
  paymentCollectionId: json['paymentCollectionId'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$OrderEditToJson(OrderEdit instance) => <String, dynamic>{
  'id': instance.id,
  'orderId': instance.orderId,
  'status': _$OrderEditStatusEnumMap[instance.status]!,
  'internalNote': instance.internalNote,
  'createdBy': instance.createdBy,
  'requestedBy': instance.requestedBy,
  'requestedAt': instance.requestedAt?.toIso8601String(),
  'confirmedBy': instance.confirmedBy,
  'confirmedAt': instance.confirmedAt?.toIso8601String(),
  'declinedBy': instance.declinedBy,
  'declinedAt': instance.declinedAt?.toIso8601String(),
  'declinedReason': instance.declinedReason,
  'canceledBy': instance.canceledBy,
  'canceledAt': instance.canceledAt?.toIso8601String(),
  'changes': instance.changes,
  'subtotal': instance.subtotal,
  'total': instance.total,
  'differenceDue': instance.differenceDue,
  'paymentCollectionId': instance.paymentCollectionId,
  'metadata': instance.metadata,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$OrderEditStatusEnumMap = {
  OrderEditStatus.created: 'created',
  OrderEditStatus.requested: 'requested',
  OrderEditStatus.confirmed: 'confirmed',
  OrderEditStatus.declined: 'declined',
  OrderEditStatus.canceled: 'canceled',
};

CreateOrderEditRequest _$CreateOrderEditRequestFromJson(
  Map<String, dynamic> json,
) => CreateOrderEditRequest(
  orderId: json['orderId'] as String,
  internalNote: json['internalNote'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateOrderEditRequestToJson(
  CreateOrderEditRequest instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'internalNote': instance.internalNote,
  'metadata': instance.metadata,
};

UpdateOrderEditRequest _$UpdateOrderEditRequestFromJson(
  Map<String, dynamic> json,
) => UpdateOrderEditRequest(
  internalNote: json['internalNote'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UpdateOrderEditRequestToJson(
  UpdateOrderEditRequest instance,
) => <String, dynamic>{
  'internalNote': instance.internalNote,
  'metadata': instance.metadata,
};

AddOrderEditLineItemRequest _$AddOrderEditLineItemRequestFromJson(
  Map<String, dynamic> json,
) => AddOrderEditLineItemRequest(
  variantId: json['variantId'] as String,
  quantity: (json['quantity'] as num).toInt(),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$AddOrderEditLineItemRequestToJson(
  AddOrderEditLineItemRequest instance,
) => <String, dynamic>{
  'variantId': instance.variantId,
  'quantity': instance.quantity,
  'metadata': instance.metadata,
};

UpdateOrderEditLineItemRequest _$UpdateOrderEditLineItemRequestFromJson(
  Map<String, dynamic> json,
) => UpdateOrderEditLineItemRequest(
  quantity: (json['quantity'] as num).toInt(),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UpdateOrderEditLineItemRequestToJson(
  UpdateOrderEditLineItemRequest instance,
) => <String, dynamic>{
  'quantity': instance.quantity,
  'metadata': instance.metadata,
};

RequestOrderEditConfirmationRequest
_$RequestOrderEditConfirmationRequestFromJson(Map<String, dynamic> json) =>
    RequestOrderEditConfirmationRequest(
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$RequestOrderEditConfirmationRequestToJson(
  RequestOrderEditConfirmationRequest instance,
) => <String, dynamic>{'metadata': instance.metadata};

ConfirmOrderEditRequest _$ConfirmOrderEditRequestFromJson(
  Map<String, dynamic> json,
) => ConfirmOrderEditRequest(
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ConfirmOrderEditRequestToJson(
  ConfirmOrderEditRequest instance,
) => <String, dynamic>{'metadata': instance.metadata};

DeclineOrderEditRequest _$DeclineOrderEditRequestFromJson(
  Map<String, dynamic> json,
) => DeclineOrderEditRequest(
  reason: json['reason'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$DeclineOrderEditRequestToJson(
  DeclineOrderEditRequest instance,
) => <String, dynamic>{
  'reason': instance.reason,
  'metadata': instance.metadata,
};

CancelOrderEditRequest _$CancelOrderEditRequestFromJson(
  Map<String, dynamic> json,
) =>
    CancelOrderEditRequest(metadata: json['metadata'] as Map<String, dynamic>?);

Map<String, dynamic> _$CancelOrderEditRequestToJson(
  CancelOrderEditRequest instance,
) => <String, dynamic>{'metadata': instance.metadata};

OrderEditResponse _$OrderEditResponseFromJson(Map<String, dynamic> json) =>
    OrderEditResponse(
      orderEdit: OrderEdit.fromJson(json['orderEdit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderEditResponseToJson(OrderEditResponse instance) =>
    <String, dynamic>{'orderEdit': instance.orderEdit};

OrderEditsResponse _$OrderEditsResponseFromJson(Map<String, dynamic> json) =>
    OrderEditsResponse(
      orderEdits:
          (json['orderEdits'] as List<dynamic>)
              .map((e) => OrderEdit.fromJson(e as Map<String, dynamic>))
              .toList(),
      count: (json['count'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$OrderEditsResponseToJson(OrderEditsResponse instance) =>
    <String, dynamic>{
      'orderEdits': instance.orderEdits,
      'count': instance.count,
      'offset': instance.offset,
      'limit': instance.limit,
    };
