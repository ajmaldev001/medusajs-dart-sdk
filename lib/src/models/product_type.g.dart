// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductType _$ProductTypeFromJson(Map<String, dynamic> json) => ProductType(
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

Map<String, dynamic> _$ProductTypeToJson(ProductType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

CreateProductTypeRequest _$CreateProductTypeRequestFromJson(
  Map<String, dynamic> json,
) => CreateProductTypeRequest(
  value: json['value'] as String,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateProductTypeRequestToJson(
  CreateProductTypeRequest instance,
) => <String, dynamic>{'value': instance.value, 'metadata': instance.metadata};

UpdateProductTypeRequest _$UpdateProductTypeRequestFromJson(
  Map<String, dynamic> json,
) => UpdateProductTypeRequest(
  value: json['value'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UpdateProductTypeRequestToJson(
  UpdateProductTypeRequest instance,
) => <String, dynamic>{'value': instance.value, 'metadata': instance.metadata};
