// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductTag _$ProductTagFromJson(Map<String, dynamic> json) => ProductTag(
  id: json['id'] as String,
  value: json['value'] as String,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$ProductTagToJson(ProductTag instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

CreateProductTagRequest _$CreateProductTagRequestFromJson(
  Map<String, dynamic> json,
) => CreateProductTagRequest(
  value: json['value'] as String,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateProductTagRequestToJson(
  CreateProductTagRequest instance,
) => <String, dynamic>{'value': instance.value, 'metadata': instance.metadata};

UpdateProductTagRequest _$UpdateProductTagRequestFromJson(
  Map<String, dynamic> json,
) => UpdateProductTagRequest(
  value: json['value'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UpdateProductTagRequestToJson(
  UpdateProductTagRequest instance,
) => <String, dynamic>{'value': instance.value, 'metadata': instance.metadata};
