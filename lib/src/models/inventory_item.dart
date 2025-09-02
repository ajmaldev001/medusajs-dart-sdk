import 'package:json_annotation/json_annotation.dart';

part 'inventory_item.g.dart';

/// Represents an inventory item
@JsonSerializable(fieldRename: FieldRename.snake)
class InventoryItem {
  /// Unique identifier for the inventory item
  final String id;

  /// Inventory item SKU
  final String? sku;

  /// Inventory item origin country
  final String? originCountry;

  /// Inventory item harmonized system code
  final String? hsCode;

  /// Inventory item mid code
  final String? midCode;

  /// Inventory item material
  final String? material;

  /// Inventory item weight
  final int? weight;

  /// Inventory item length
  final int? length;

  /// Inventory item height
  final int? height;

  /// Inventory item width
  final int? width;

  /// Whether this item requires shipping
  final bool requiresShipping;

  /// Inventory item title
  final String? title;

  /// Inventory item description
  final String? description;

  /// Inventory item thumbnail
  final String? thumbnail;

  /// Inventory item metadata
  final Map<String, dynamic>? metadata;

  /// When the inventory item was created
  final DateTime createdAt;

  /// When the inventory item was last updated
  final DateTime updatedAt;

  /// When the inventory item was deleted (if soft deleted)
  final DateTime? deletedAt;

  const InventoryItem({
    required this.id,
    this.sku,
    this.originCountry,
    this.hsCode,
    this.midCode,
    this.material,
    this.weight,
    this.length,
    this.height,
    this.width,
    this.requiresShipping = true,
    this.title,
    this.description,
    this.thumbnail,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);
  Map<String, dynamic> toJson() => _$InventoryItemToJson(this);

  /// Check if item has dimensions
  bool get hasDimensions => length != null && height != null && width != null;

  /// Check if item has weight
  bool get hasWeight => weight != null;
}

/// Request to create an inventory item
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateInventoryItemRequest {
  /// Inventory item SKU
  final String? sku;

  /// Inventory item origin country
  final String? originCountry;

  /// Inventory item harmonized system code
  final String? hsCode;

  /// Inventory item mid code
  final String? midCode;

  /// Inventory item material
  final String? material;

  /// Inventory item weight
  final int? weight;

  /// Inventory item length
  final int? length;

  /// Inventory item height
  final int? height;

  /// Inventory item width
  final int? width;

  /// Whether this item requires shipping
  final bool? requiresShipping;

  /// Inventory item title
  final String? title;

  /// Inventory item description
  final String? description;

  /// Inventory item thumbnail
  final String? thumbnail;

  /// Inventory item metadata
  final Map<String, dynamic>? metadata;

  const CreateInventoryItemRequest({
    this.sku,
    this.originCountry,
    this.hsCode,
    this.midCode,
    this.material,
    this.weight,
    this.length,
    this.height,
    this.width,
    this.requiresShipping,
    this.title,
    this.description,
    this.thumbnail,
    this.metadata,
  });

  factory CreateInventoryItemRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateInventoryItemRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateInventoryItemRequestToJson(this);
}

/// Request to update an inventory item
@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateInventoryItemRequest {
  /// Inventory item SKU
  final String? sku;

  /// Inventory item origin country
  final String? originCountry;

  /// Inventory item harmonized system code
  final String? hsCode;

  /// Inventory item mid code
  final String? midCode;

  /// Inventory item material
  final String? material;

  /// Inventory item weight
  final int? weight;

  /// Inventory item length
  final int? length;

  /// Inventory item height
  final int? height;

  /// Inventory item width
  final int? width;

  /// Whether this item requires shipping
  final bool? requiresShipping;

  /// Inventory item title
  final String? title;

  /// Inventory item description
  final String? description;

  /// Inventory item thumbnail
  final String? thumbnail;

  /// Inventory item metadata
  final Map<String, dynamic>? metadata;

  const UpdateInventoryItemRequest({
    this.sku,
    this.originCountry,
    this.hsCode,
    this.midCode,
    this.material,
    this.weight,
    this.length,
    this.height,
    this.width,
    this.requiresShipping,
    this.title,
    this.description,
    this.thumbnail,
    this.metadata,
  });

  factory UpdateInventoryItemRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateInventoryItemRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateInventoryItemRequestToJson(this);
}
