// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnReason _$ReturnReasonFromJson(Map<String, dynamic> json) => ReturnReason(
  id: json['id'] as String,
  value: json['value'] as String,
  label: json['label'] as String,
  description: json['description'] as String?,
  parentReturnReasonId: json['parentReturnReasonId'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$ReturnReasonToJson(ReturnReason instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'label': instance.label,
      'description': instance.description,
      'parentReturnReasonId': instance.parentReturnReasonId,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

ReturnItem _$ReturnItemFromJson(Map<String, dynamic> json) => ReturnItem(
  id: json['id'] as String,
  returnId: json['returnId'] as String,
  orderItemId: json['orderItemId'] as String,
  quantity: (json['quantity'] as num).toInt(),
  isDamaged: json['isDamaged'] as bool,
  note: json['note'] as String?,
  reasonId: json['reasonId'] as String?,
  reason:
      json['reason'] == null
          ? null
          : ReturnReason.fromJson(json['reason'] as Map<String, dynamic>),
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$ReturnItemToJson(ReturnItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'returnId': instance.returnId,
      'orderItemId': instance.orderItemId,
      'quantity': instance.quantity,
      'isDamaged': instance.isDamaged,
      'note': instance.note,
      'reasonId': instance.reasonId,
      'reason': instance.reason,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

ReturnShippingMethod _$ReturnShippingMethodFromJson(
  Map<String, dynamic> json,
) => ReturnShippingMethod(
  id: json['id'] as String,
  returnId: json['returnId'] as String,
  shippingOptionId: json['shippingOptionId'] as String?,
  price: (json['price'] as num?)?.toInt(),
  data: json['data'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ReturnShippingMethodToJson(
  ReturnShippingMethod instance,
) => <String, dynamic>{
  'id': instance.id,
  'returnId': instance.returnId,
  'shippingOptionId': instance.shippingOptionId,
  'price': instance.price,
  'data': instance.data,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

Return _$ReturnFromJson(Map<String, dynamic> json) => Return(
  id: json['id'] as String,
  status: $enumDecode(_$ReturnStatusEnumMap, json['status']),
  orderId: json['orderId'] as String?,
  exchangeId: json['exchangeId'] as String?,
  claimId: json['claimId'] as String?,
  locationId: json['locationId'] as String?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => ReturnItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  shippingMethod:
      json['shippingMethod'] == null
          ? null
          : ReturnShippingMethod.fromJson(
            json['shippingMethod'] as Map<String, dynamic>,
          ),
  shippingData: json['shippingData'] as Map<String, dynamic>?,
  refundAmount: (json['refundAmount'] as num?)?.toInt(),
  receivedAt:
      json['receivedAt'] == null
          ? null
          : DateTime.parse(json['receivedAt'] as String),
  note: json['note'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$ReturnToJson(Return instance) => <String, dynamic>{
  'id': instance.id,
  'status': _$ReturnStatusEnumMap[instance.status]!,
  'orderId': instance.orderId,
  'exchangeId': instance.exchangeId,
  'claimId': instance.claimId,
  'locationId': instance.locationId,
  'items': instance.items,
  'shippingMethod': instance.shippingMethod,
  'shippingData': instance.shippingData,
  'refundAmount': instance.refundAmount,
  'receivedAt': instance.receivedAt?.toIso8601String(),
  'note': instance.note,
  'metadata': instance.metadata,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
};

const _$ReturnStatusEnumMap = {
  ReturnStatus.requested: 'requested',
  ReturnStatus.received: 'received',
  ReturnStatus.requiresAction: 'requires_action',
  ReturnStatus.canceled: 'canceled',
};

CreateReturnRequest _$CreateReturnRequestFromJson(Map<String, dynamic> json) =>
    CreateReturnRequest(
      orderId: json['orderId'] as String,
      items:
          (json['items'] as List<dynamic>)
              .map(
                (e) =>
                    CreateReturnItemRequest.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      locationId: json['locationId'] as String?,
      note: json['note'] as String?,
      receiveNow: json['receiveNow'] as bool?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CreateReturnRequestToJson(
  CreateReturnRequest instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'items': instance.items,
  'locationId': instance.locationId,
  'note': instance.note,
  'receiveNow': instance.receiveNow,
  'metadata': instance.metadata,
};

CreateReturnItemRequest _$CreateReturnItemRequestFromJson(
  Map<String, dynamic> json,
) => CreateReturnItemRequest(
  orderItemId: json['orderItemId'] as String,
  quantity: (json['quantity'] as num).toInt(),
  reasonId: json['reasonId'] as String?,
  note: json['note'] as String?,
  isDamaged: json['isDamaged'] as bool?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateReturnItemRequestToJson(
  CreateReturnItemRequest instance,
) => <String, dynamic>{
  'orderItemId': instance.orderItemId,
  'quantity': instance.quantity,
  'reasonId': instance.reasonId,
  'note': instance.note,
  'isDamaged': instance.isDamaged,
  'metadata': instance.metadata,
};

UpdateReturnRequest _$UpdateReturnRequestFromJson(Map<String, dynamic> json) =>
    UpdateReturnRequest(
      note: json['note'] as String?,
      receivedAt:
          json['receivedAt'] == null
              ? null
              : DateTime.parse(json['receivedAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UpdateReturnRequestToJson(
  UpdateReturnRequest instance,
) => <String, dynamic>{
  'note': instance.note,
  'receivedAt': instance.receivedAt?.toIso8601String(),
  'metadata': instance.metadata,
};

ReceiveReturnRequest _$ReceiveReturnRequestFromJson(
  Map<String, dynamic> json,
) => ReceiveReturnRequest(
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) => ReceiveReturnItemRequest.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  note: json['note'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ReceiveReturnRequestToJson(
  ReceiveReturnRequest instance,
) => <String, dynamic>{
  'items': instance.items,
  'note': instance.note,
  'metadata': instance.metadata,
};

ReceiveReturnItemRequest _$ReceiveReturnItemRequestFromJson(
  Map<String, dynamic> json,
) => ReceiveReturnItemRequest(
  returnItemId: json['returnItemId'] as String,
  quantity: (json['quantity'] as num).toInt(),
  isDamaged: json['isDamaged'] as bool?,
  note: json['note'] as String?,
);

Map<String, dynamic> _$ReceiveReturnItemRequestToJson(
  ReceiveReturnItemRequest instance,
) => <String, dynamic>{
  'returnItemId': instance.returnItemId,
  'quantity': instance.quantity,
  'isDamaged': instance.isDamaged,
  'note': instance.note,
};

ReturnResponse _$ReturnResponseFromJson(Map<String, dynamic> json) =>
    ReturnResponse(
      returnOrder: Return.fromJson(json['returnOrder'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReturnResponseToJson(ReturnResponse instance) =>
    <String, dynamic>{'returnOrder': instance.returnOrder};

ReturnsResponse _$ReturnsResponseFromJson(Map<String, dynamic> json) =>
    ReturnsResponse(
      returns:
          (json['returns'] as List<dynamic>)
              .map((e) => Return.fromJson(e as Map<String, dynamic>))
              .toList(),
      count: (json['count'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$ReturnsResponseToJson(ReturnsResponse instance) =>
    <String, dynamic>{
      'returns': instance.returns,
      'count': instance.count,
      'offset': instance.offset,
      'limit': instance.limit,
    };

ReturnReasonsResponse _$ReturnReasonsResponseFromJson(
  Map<String, dynamic> json,
) => ReturnReasonsResponse(
  returnReasons:
      (json['returnReasons'] as List<dynamic>)
          .map((e) => ReturnReason.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ReturnReasonsResponseToJson(
  ReturnReasonsResponse instance,
) => <String, dynamic>{'returnReasons': instance.returnReasons};
