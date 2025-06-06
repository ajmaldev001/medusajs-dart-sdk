import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

/// Represents a product category
@JsonSerializable()
class Category {
  /// Unique identifier for the category
  final String id;

  /// Name of the category
  final String name;

  /// Description of the category
  final String? description;

  /// Handle for the category (URL-friendly)
  final String handle;

  /// Whether the category is active
  final bool isActive;

  /// Whether the category is internal only
  final bool isInternal;

  /// Parent category ID
  final String? parentCategoryId;

  /// Rank for ordering categories
  final int rank;

  /// When the category was created
  final DateTime createdAt;

  /// When the category was last updated
  final DateTime updatedAt;

  /// Category metadata
  final Map<String, dynamic>? metadata;

  const Category({
    required this.id,
    required this.name,
    this.description,
    required this.handle,
    required this.isActive,
    required this.isInternal,
    this.parentCategoryId,
    required this.rank,
    required this.createdAt,
    required this.updatedAt,
    this.metadata,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
