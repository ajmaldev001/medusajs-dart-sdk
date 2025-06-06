// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryItem _$InventoryItemFromJson(Map<String, dynamic> json) =>
    InventoryItem(
      id: json['id'] as String,
      sku: json['sku'] as String?,
      originCountry: json['originCountry'] as String?,
      hsCode: json['hsCode'] as String?,
      requiresShipping: json['requiresShipping'] as bool,
      midCode: json['midCode'] as String?,
      material: json['material'] as String?,
      weight: (json['weight'] as num?)?.toInt(),
      length: (json['length'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      thumbnail: json['thumbnail'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
      deletedAt:
          json['deletedAt'] == null
              ? null
              : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$InventoryItemToJson(InventoryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'originCountry': instance.originCountry,
      'hsCode': instance.hsCode,
      'requiresShipping': instance.requiresShipping,
      'midCode': instance.midCode,
      'material': instance.material,
      'weight': instance.weight,
      'length': instance.length,
      'height': instance.height,
      'width': instance.width,
      'title': instance.title,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

InventoryLevel _$InventoryLevelFromJson(Map<String, dynamic> json) =>
    InventoryLevel(
      id: json['id'] as String,
      inventoryItemId: json['inventoryItemId'] as String,
      locationId: json['locationId'] as String,
      stockedQuantity: (json['stockedQuantity'] as num).toInt(),
      reservedQuantity: (json['reservedQuantity'] as num).toInt(),
      incomingQuantity: (json['incomingQuantity'] as num).toInt(),
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
      deletedAt:
          json['deletedAt'] == null
              ? null
              : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$InventoryLevelToJson(InventoryLevel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inventoryItemId': instance.inventoryItemId,
      'locationId': instance.locationId,
      'stockedQuantity': instance.stockedQuantity,
      'reservedQuantity': instance.reservedQuantity,
      'incomingQuantity': instance.incomingQuantity,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation(
  id: json['id'] as String,
  inventoryItemId: json['inventoryItemId'] as String,
  locationId: json['locationId'] as String,
  quantity: (json['quantity'] as num).toInt(),
  lineItemId: json['lineItemId'] as String?,
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
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
      'lineItemId': instance.lineItemId,
      'description': instance.description,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };
