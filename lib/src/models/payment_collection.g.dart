// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentSession _$PaymentSessionFromJson(Map<String, dynamic> json) =>
    PaymentSession(
      id: json['id'] as String,
      paymentCollectionId: json['paymentCollectionId'] as String,
      providerId: json['providerId'] as String,
      currencyCode: json['currencyCode'] as String,
      amount: (json['amount'] as num).toInt(),
      status: $enumDecode(_$PaymentSessionStatusEnumMap, json['status']),
      data: json['data'] as Map<String, dynamic>?,
      isSelected: json['isSelected'] as bool,
      isInitiated: json['isInitiated'] as bool,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PaymentSessionToJson(PaymentSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paymentCollectionId': instance.paymentCollectionId,
      'providerId': instance.providerId,
      'currencyCode': instance.currencyCode,
      'amount': instance.amount,
      'status': _$PaymentSessionStatusEnumMap[instance.status]!,
      'data': instance.data,
      'isSelected': instance.isSelected,
      'isInitiated': instance.isInitiated,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$PaymentSessionStatusEnumMap = {
  PaymentSessionStatus.pending: 'pending',
  PaymentSessionStatus.authorized: 'authorized',
  PaymentSessionStatus.requiresMore: 'requires_more',
  PaymentSessionStatus.error: 'error',
  PaymentSessionStatus.canceled: 'canceled',
};

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
  id: json['id'] as String,
  amount: (json['amount'] as num).toInt(),
  currencyCode: json['currencyCode'] as String,
  providerId: json['providerId'] as String,
  cartId: json['cartId'] as String?,
  orderId: json['orderId'] as String?,
  orderEditId: json['orderEditId'] as String?,
  customerId: json['customerId'] as String?,
  data: json['data'] as Map<String, dynamic>?,
  capturedAt:
      json['capturedAt'] == null
          ? null
          : DateTime.parse(json['capturedAt'] as String),
  canceledAt:
      json['canceledAt'] == null
          ? null
          : DateTime.parse(json['canceledAt'] as String),
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'currencyCode': instance.currencyCode,
  'providerId': instance.providerId,
  'cartId': instance.cartId,
  'orderId': instance.orderId,
  'orderEditId': instance.orderEditId,
  'customerId': instance.customerId,
  'data': instance.data,
  'capturedAt': instance.capturedAt?.toIso8601String(),
  'canceledAt': instance.canceledAt?.toIso8601String(),
  'metadata': instance.metadata,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

PaymentCollection _$PaymentCollectionFromJson(Map<String, dynamic> json) =>
    PaymentCollection(
      id: json['id'] as String,
      type: $enumDecode(_$PaymentCollectionTypeEnumMap, json['type']),
      status: $enumDecode(_$PaymentCollectionStatusEnumMap, json['status']),
      description: json['description'] as String?,
      amount: (json['amount'] as num).toInt(),
      authorizedAmount: (json['authorizedAmount'] as num).toInt(),
      regionId: json['regionId'] as String,
      currencyCode: json['currencyCode'] as String,
      paymentSessions:
          (json['paymentSessions'] as List<dynamic>?)
              ?.map((e) => PaymentSession.fromJson(e as Map<String, dynamic>))
              .toList(),
      payments:
          (json['payments'] as List<dynamic>?)
              ?.map((e) => Payment.fromJson(e as Map<String, dynamic>))
              .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt:
          json['deletedAt'] == null
              ? null
              : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$PaymentCollectionToJson(PaymentCollection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$PaymentCollectionTypeEnumMap[instance.type]!,
      'status': _$PaymentCollectionStatusEnumMap[instance.status]!,
      'description': instance.description,
      'amount': instance.amount,
      'authorizedAmount': instance.authorizedAmount,
      'regionId': instance.regionId,
      'currencyCode': instance.currencyCode,
      'paymentSessions': instance.paymentSessions,
      'payments': instance.payments,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

const _$PaymentCollectionTypeEnumMap = {
  PaymentCollectionType.orderEdit: 'order_edit',
  PaymentCollectionType.subscription: 'subscription',
  PaymentCollectionType.custom: 'custom',
};

const _$PaymentCollectionStatusEnumMap = {
  PaymentCollectionStatus.notPaid: 'not_paid',
  PaymentCollectionStatus.awaiting: 'awaiting',
  PaymentCollectionStatus.authorized: 'authorized',
  PaymentCollectionStatus.partiallyAuthorized: 'partially_authorized',
  PaymentCollectionStatus.canceled: 'canceled',
};

CreatePaymentCollectionRequest _$CreatePaymentCollectionRequestFromJson(
  Map<String, dynamic> json,
) => CreatePaymentCollectionRequest(
  type: $enumDecode(_$PaymentCollectionTypeEnumMap, json['type']),
  description: json['description'] as String?,
  amount: (json['amount'] as num).toInt(),
  regionId: json['regionId'] as String,
  currencyCode: json['currencyCode'] as String,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreatePaymentCollectionRequestToJson(
  CreatePaymentCollectionRequest instance,
) => <String, dynamic>{
  'type': _$PaymentCollectionTypeEnumMap[instance.type]!,
  'description': instance.description,
  'amount': instance.amount,
  'regionId': instance.regionId,
  'currencyCode': instance.currencyCode,
  'metadata': instance.metadata,
};

UpdatePaymentCollectionRequest _$UpdatePaymentCollectionRequestFromJson(
  Map<String, dynamic> json,
) => UpdatePaymentCollectionRequest(
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UpdatePaymentCollectionRequestToJson(
  UpdatePaymentCollectionRequest instance,
) => <String, dynamic>{
  'description': instance.description,
  'metadata': instance.metadata,
};

SetPaymentSessionsRequest _$SetPaymentSessionsRequestFromJson(
  Map<String, dynamic> json,
) => SetPaymentSessionsRequest(
  providerIds:
      (json['providerIds'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$SetPaymentSessionsRequestToJson(
  SetPaymentSessionsRequest instance,
) => <String, dynamic>{'providerIds': instance.providerIds};

AuthorizePaymentSessionRequest _$AuthorizePaymentSessionRequestFromJson(
  Map<String, dynamic> json,
) => AuthorizePaymentSessionRequest(
  sessionId: json['sessionId'] as String,
  context: json['context'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$AuthorizePaymentSessionRequestToJson(
  AuthorizePaymentSessionRequest instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'context': instance.context,
};

PaymentCollectionResponse _$PaymentCollectionResponseFromJson(
  Map<String, dynamic> json,
) => PaymentCollectionResponse(
  paymentCollection: PaymentCollection.fromJson(
    json['paymentCollection'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PaymentCollectionResponseToJson(
  PaymentCollectionResponse instance,
) => <String, dynamic>{'paymentCollection': instance.paymentCollection};

PaymentCollectionsResponse _$PaymentCollectionsResponseFromJson(
  Map<String, dynamic> json,
) => PaymentCollectionsResponse(
  paymentCollections:
      (json['paymentCollections'] as List<dynamic>)
          .map((e) => PaymentCollection.fromJson(e as Map<String, dynamic>))
          .toList(),
  count: (json['count'] as num).toInt(),
  offset: (json['offset'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
);

Map<String, dynamic> _$PaymentCollectionsResponseToJson(
  PaymentCollectionsResponse instance,
) => <String, dynamic>{
  'paymentCollections': instance.paymentCollections,
  'count': instance.count,
  'offset': instance.offset,
  'limit': instance.limit,
};
