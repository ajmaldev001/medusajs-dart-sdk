import 'package:json_annotation/json_annotation.dart';

part 'product_image.g.dart';

/// Represents a product image
@JsonSerializable()
class ProductImage {
  /// Unique identifier for the image
  final String id;

  /// Image URL
  final String url;

  /// Alt text for the image
  final String? alt;

  /// Product ID this image belongs to
  final String productId;

  /// When the image was created
  final DateTime createdAt;

  /// When the image was last updated
  final DateTime updatedAt;

  const ProductImage({
    required this.id,
    required this.url,
    this.alt,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) =>
      _$ProductImageFromJson(json);
  Map<String, dynamic> toJson() => _$ProductImageToJson(this);
}
