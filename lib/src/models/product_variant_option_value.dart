import 'package:json_annotation/json_annotation.dart';
import 'product_option.dart';

part 'product_variant_option_value.g.dart';

/// Represents a product variant option value
/// This is different from ProductOptionValue as it includes the nested option
@JsonSerializable(fieldRename: FieldRename.snake)
class ProductVariantOptionValue {
  /// Unique identifier for the option value
  final String id;

  /// Option value (e.g., "Red", "Large")
  final String value;

  /// Option ID this value belongs to
  final String optionId;

  /// The nested option data
  final ProductOption? option;

  /// Value metadata
  final Map<String, dynamic>? metadata;

  /// When the value was created
  final DateTime createdAt;

  /// When the value was last updated
  final DateTime updatedAt;

  /// When the value was deleted (if soft deleted)
  final DateTime? deletedAt;

  const ProductVariantOptionValue({
    required this.id,
    required this.value,
    required this.optionId,
    this.option,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ProductVariantOptionValue.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantOptionValueFromJson(json);
  Map<String, dynamic> toJson() => _$ProductVariantOptionValueToJson(this);
}
