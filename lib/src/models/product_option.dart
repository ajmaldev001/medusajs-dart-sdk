import 'package:json_annotation/json_annotation.dart';

part 'product_option.g.dart';

/// Represents a product option (like Color, Size)
@JsonSerializable()
class ProductOption {
  /// Unique identifier for the option
  final String id;

  /// Option title (e.g., "Color", "Size")
  final String title;

  /// Product ID this option belongs to
  final String productId;

  /// Option values
  final List<ProductOptionValue>? values;

  /// Option metadata
  final Map<String, dynamic>? metadata;

  /// When the option was created
  final DateTime createdAt;

  /// When the option was last updated
  final DateTime updatedAt;

  /// When the option was deleted (if soft deleted)
  final DateTime? deletedAt;

  const ProductOption({
    required this.id,
    required this.title,
    required this.productId,
    this.values,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ProductOption.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionFromJson(json);
  Map<String, dynamic> toJson() => _$ProductOptionToJson(this);
}

/// Represents a product option value (like "Red", "Large")
@JsonSerializable()
class ProductOptionValue {
  /// Unique identifier for the option value
  final String id;

  /// Option value (e.g., "Red", "Large")
  final String value;

  /// Option ID this value belongs to
  final String optionId;

  /// Value metadata
  final Map<String, dynamic>? metadata;

  /// When the value was created
  final DateTime createdAt;

  /// When the value was last updated
  final DateTime updatedAt;

  /// When the value was deleted (if soft deleted)
  final DateTime? deletedAt;

  const ProductOptionValue({
    required this.id,
    required this.value,
    required this.optionId,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ProductOptionValue.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionValueFromJson(json);
  Map<String, dynamic> toJson() => _$ProductOptionValueToJson(this);
}
