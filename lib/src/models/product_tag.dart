import 'package:json_annotation/json_annotation.dart';

part 'product_tag.g.dart';

/// Represents a product tag
@JsonSerializable(fieldRename: FieldRename.snake)
class ProductTag {
  /// Unique identifier for the tag
  final String id;

  /// Tag value
  final String value;

  /// Tag metadata
  final Map<String, dynamic>? metadata;

  /// When the tag was created
  final DateTime createdAt;

  /// When the tag was last updated
  final DateTime updatedAt;

  /// When the tag was deleted (if soft deleted)
  final DateTime? deletedAt;

  const ProductTag({
    required this.id,
    required this.value,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ProductTag.fromJson(Map<String, dynamic> json) =>
      _$ProductTagFromJson(json);
  Map<String, dynamic> toJson() => _$ProductTagToJson(this);
}

/// Request to create a product tag
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateProductTagRequest {
  /// Tag value
  final String value;

  /// Tag metadata
  final Map<String, dynamic>? metadata;

  const CreateProductTagRequest({required this.value, this.metadata});

  factory CreateProductTagRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateProductTagRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateProductTagRequestToJson(this);
}

/// Request to update a product tag
@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateProductTagRequest {
  /// Tag value
  final String? value;

  /// Tag metadata
  final Map<String, dynamic>? metadata;

  const UpdateProductTagRequest({this.value, this.metadata});

  factory UpdateProductTagRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProductTagRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProductTagRequestToJson(this);
}
