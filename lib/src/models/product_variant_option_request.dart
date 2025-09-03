import 'package:json_annotation/json_annotation.dart';

part 'product_variant_option_request.g.dart';

/// Request model for creating or updating product variant options
@JsonSerializable(fieldRename: FieldRename.snake)
class ProductVariantOptionRequest {
  /// Option ID (required)
  final String optionId;

  /// Option value (e.g., "Red", "Large")
  final String value;

  /// Option metadata
  final Map<String, dynamic>? metadata;

  const ProductVariantOptionRequest({
    required this.optionId,
    required this.value,
    this.metadata,
  });

  factory ProductVariantOptionRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantOptionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariantOptionRequestToJson(this);
}
