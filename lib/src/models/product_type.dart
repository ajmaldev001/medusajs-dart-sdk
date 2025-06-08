import 'package:json_annotation/json_annotation.dart';

part 'product_type.g.dart';

/// Represents a product type
@JsonSerializable()
class ProductType {
  /// Unique identifier for the type
  final String id;

  /// Type value
  final String value;

  /// Type metadata
  final Map<String, dynamic>? metadata;

  /// When the type was created
  final DateTime createdAt;

  /// When the type was last updated
  final DateTime updatedAt;

  /// When the type was deleted (if soft deleted)
  final DateTime? deletedAt;

  const ProductType({
    required this.id,
    required this.value,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ProductType.fromJson(Map<String, dynamic> json) =>
      _$ProductTypeFromJson(json);
  Map<String, dynamic> toJson() => _$ProductTypeToJson(this);
}

/// Request to create a product type
@JsonSerializable()
class CreateProductTypeRequest {
  /// Type value
  final String value;

  /// Type metadata
  final Map<String, dynamic>? metadata;

  const CreateProductTypeRequest({required this.value, this.metadata});

  factory CreateProductTypeRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateProductTypeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateProductTypeRequestToJson(this);
}

/// Request to update a product type
@JsonSerializable()
class UpdateProductTypeRequest {
  /// Type value
  final String? value;

  /// Type metadata
  final Map<String, dynamic>? metadata;

  const UpdateProductTypeRequest({this.value, this.metadata});

  factory UpdateProductTypeRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProductTypeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProductTypeRequestToJson(this);
}
