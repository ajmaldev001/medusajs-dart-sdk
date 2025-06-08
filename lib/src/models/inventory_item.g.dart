// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryItem _$InventoryItemFromJson(Map<String, dynamic> json) =>
    InventoryItem(
      id: json['id'] as String,
      sku: json['sku'] as String?,
      originCountry: json['originCountry'] as String?,
      hsCode: json['hsCode'] as String?,
      midCode: json['midCode'] as String?,
      material: json['material'] as String?,
      weight: (json['weight'] as num?)?.toInt(),
      length: (json['length'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      requiresShipping: json['requiresShipping'] as bool? ?? true,
      title: json['title'] as String?,
      description: json['description'] as String?,
      thumbnail: json['thumbnail'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
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
      'midCode': instance.midCode,
      'material': instance.material,
      'weight': instance.weight,
      'length': instance.length,
      'height': instance.height,
      'width': instance.width,
      'requiresShipping': instance.requiresShipping,
      'title': instance.title,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

CreateInventoryItemRequest _$CreateInventoryItemRequestFromJson(
  Map<String, dynamic> json,
) => CreateInventoryItemRequest(
  sku: json['sku'] as String?,
  originCountry: json['originCountry'] as String?,
  hsCode: json['hsCode'] as String?,
  midCode: json['midCode'] as String?,
  material: json['material'] as String?,
  weight: (json['weight'] as num?)?.toInt(),
  length: (json['length'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
  width: (json['width'] as num?)?.toInt(),
  requiresShipping: json['requiresShipping'] as bool?,
  title: json['title'] as String?,
  description: json['description'] as String?,
  thumbnail: json['thumbnail'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateInventoryItemRequestToJson(
  CreateInventoryItemRequest instance,
) => <String, dynamic>{
  'sku': instance.sku,
  'originCountry': instance.originCountry,
  'hsCode': instance.hsCode,
  'midCode': instance.midCode,
  'material': instance.material,
  'weight': instance.weight,
  'length': instance.length,
  'height': instance.height,
  'width': instance.width,
  'requiresShipping': instance.requiresShipping,
  'title': instance.title,
  'description': instance.description,
  'thumbnail': instance.thumbnail,
  'metadata': instance.metadata,
};

UpdateInventoryItemRequest _$UpdateInventoryItemRequestFromJson(
  Map<String, dynamic> json,
) => UpdateInventoryItemRequest(
  sku: json['sku'] as String?,
  originCountry: json['originCountry'] as String?,
  hsCode: json['hsCode'] as String?,
  midCode: json['midCode'] as String?,
  material: json['material'] as String?,
  weight: (json['weight'] as num?)?.toInt(),
  length: (json['length'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
  width: (json['width'] as num?)?.toInt(),
  requiresShipping: json['requiresShipping'] as bool?,
  title: json['title'] as String?,
  description: json['description'] as String?,
  thumbnail: json['thumbnail'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UpdateInventoryItemRequestToJson(
  UpdateInventoryItemRequest instance,
) => <String, dynamic>{
  'sku': instance.sku,
  'originCountry': instance.originCountry,
  'hsCode': instance.hsCode,
  'midCode': instance.midCode,
  'material': instance.material,
  'weight': instance.weight,
  'length': instance.length,
  'height': instance.height,
  'width': instance.width,
  'requiresShipping': instance.requiresShipping,
  'title': instance.title,
  'description': instance.description,
  'thumbnail': instance.thumbnail,
  'metadata': instance.metadata,
};
