// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation(
  id: json['id'] as String,
  inventoryItemId: json['inventoryItemId'] as String,
  locationId: json['locationId'] as String,
  quantity: (json['quantity'] as num).toInt(),
  orderId: json['orderId'] as String?,
  lineItemId: json['lineItemId'] as String?,
  description: json['description'] as String?,
  type: $enumDecodeNullable(_$ReservationTypeEnumMap, json['type']),
  externalId: json['externalId'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inventoryItemId': instance.inventoryItemId,
      'locationId': instance.locationId,
      'quantity': instance.quantity,
      'orderId': instance.orderId,
      'lineItemId': instance.lineItemId,
      'description': instance.description,
      'type': _$ReservationTypeEnumMap[instance.type],
      'externalId': instance.externalId,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

const _$ReservationTypeEnumMap = {
  ReservationType.order: 'order',
  ReservationType.exchange: 'exchange',
  ReservationType.returnType: 'return',
  ReservationType.draftOrder: 'draft_order',
  ReservationType.other: 'other',
};

CreateReservationRequest _$CreateReservationRequestFromJson(
  Map<String, dynamic> json,
) => CreateReservationRequest(
  inventoryItemId: json['inventoryItemId'] as String,
  locationId: json['locationId'] as String,
  quantity: (json['quantity'] as num).toInt(),
  orderId: json['orderId'] as String?,
  lineItemId: json['lineItemId'] as String?,
  description: json['description'] as String?,
  type: $enumDecodeNullable(_$ReservationTypeEnumMap, json['type']),
  externalId: json['externalId'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateReservationRequestToJson(
  CreateReservationRequest instance,
) => <String, dynamic>{
  'inventoryItemId': instance.inventoryItemId,
  'locationId': instance.locationId,
  'quantity': instance.quantity,
  'orderId': instance.orderId,
  'lineItemId': instance.lineItemId,
  'description': instance.description,
  'type': _$ReservationTypeEnumMap[instance.type],
  'externalId': instance.externalId,
  'metadata': instance.metadata,
};

UpdateReservationRequest _$UpdateReservationRequestFromJson(
  Map<String, dynamic> json,
) => UpdateReservationRequest(
  locationId: json['locationId'] as String?,
  quantity: (json['quantity'] as num?)?.toInt(),
  description: json['description'] as String?,
  externalId: json['externalId'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UpdateReservationRequestToJson(
  UpdateReservationRequest instance,
) => <String, dynamic>{
  'locationId': instance.locationId,
  'quantity': instance.quantity,
  'description': instance.description,
  'externalId': instance.externalId,
  'metadata': instance.metadata,
};

ReservationResponse _$ReservationResponseFromJson(Map<String, dynamic> json) =>
    ReservationResponse(
      reservation: Reservation.fromJson(
        json['reservation'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ReservationResponseToJson(
  ReservationResponse instance,
) => <String, dynamic>{'reservation': instance.reservation};

ReservationsResponse _$ReservationsResponseFromJson(
  Map<String, dynamic> json,
) => ReservationsResponse(
  reservations:
      (json['reservations'] as List<dynamic>)
          .map((e) => Reservation.fromJson(e as Map<String, dynamic>))
          .toList(),
  count: (json['count'] as num).toInt(),
  offset: (json['offset'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
);

Map<String, dynamic> _$ReservationsResponseToJson(
  ReservationsResponse instance,
) => <String, dynamic>{
  'reservations': instance.reservations,
  'count': instance.count,
  'offset': instance.offset,
  'limit': instance.limit,
};
