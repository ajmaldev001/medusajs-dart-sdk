// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant_option_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVariantOptionRequest _$ProductVariantOptionRequestFromJson(
  Map<String, dynamic> json,
) => ProductVariantOptionRequest(
  optionId: json['option_id'] as String,
  value: json['value'] as String,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ProductVariantOptionRequestToJson(
  ProductVariantOptionRequest instance,
) => <String, dynamic>{
  'option_id': instance.optionId,
  'value': instance.value,
  'metadata': instance.metadata,
};
