import 'package:json_annotation/json_annotation.dart';

part 'inventory.g.dart';

/// Represents an inventory item in the Medusa system
@JsonSerializable(fieldRename: FieldRename.snake)
class InventoryItem {
  /// Unique identifier for the inventory item
  final String id;

  /// SKU for the inventory item
  final String? sku;

  /// Origin country for the inventory item
  final String? originCountry;

  /// HS code for the inventory item
  final String? hsCode;

  /// Whether the inventory item requires shipping
  final bool requiresShipping;

  /// Mid code for the inventory item
  final String? midCode;

  /// Material composition of the inventory item
  final String? material;

  /// Weight of the inventory item
  final int? weight;

  /// Length of the inventory item
  final int? length;

  /// Height of the inventory item
  final int? height;

  /// Width of the inventory item
  final int? width;

  /// Title of the inventory item
  final String? title;

  /// Description of the inventory item
  final String? description;

  /// Thumbnail URL for the inventory item
  final String? thumbnail;

  /// Metadata associated with the inventory item
  final Map<String, dynamic>? metadata;

  /// Timestamp of creation
  final DateTime? createdAt;

  /// Timestamp of last update
  final DateTime? updatedAt;

  /// Timestamp of deletion (soft delete)
  final DateTime? deletedAt;

  const InventoryItem({
    required this.id,
    this.sku,
    this.originCountry,
    this.hsCode,
    required this.requiresShipping,
    this.midCode,
    this.material,
    this.weight,
    this.length,
    this.height,
    this.width,
    this.title,
    this.description,
    this.thumbnail,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);
  Map<String, dynamic> toJson() => _$InventoryItemToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'InventoryItem(id: $id, sku: $sku)';
}

/// Represents inventory level for a location
@JsonSerializable(fieldRename: FieldRename.snake)
class InventoryLevel {
  /// Unique identifier for the inventory level
  final String id;

  /// Inventory item ID
  final String inventoryItemId;

  /// Location ID
  final String locationId;

  /// Stocked quantity
  final int stockedQuantity;

  /// Reserved quantity
  final int reservedQuantity;

  /// Incoming quantity
  final int incomingQuantity;

  /// Metadata associated with the inventory level
  final Map<String, dynamic>? metadata;

  /// Timestamp of creation
  final DateTime? createdAt;

  /// Timestamp of last update
  final DateTime? updatedAt;

  /// Timestamp of deletion (soft delete)
  final DateTime? deletedAt;

  const InventoryLevel({
    required this.id,
    required this.inventoryItemId,
    required this.locationId,
    required this.stockedQuantity,
    required this.reservedQuantity,
    required this.incomingQuantity,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  /// Calculate available quantity
  int get availableQuantity => stockedQuantity - reservedQuantity;

  factory InventoryLevel.fromJson(Map<String, dynamic> json) =>
      _$InventoryLevelFromJson(json);
  Map<String, dynamic> toJson() => _$InventoryLevelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryLevel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'InventoryLevel(id: $id, stockedQuantity: $stockedQuantity, availableQuantity: $availableQuantity)';
}

/// Represents a reservation of inventory
@JsonSerializable(fieldRename: FieldRename.snake)
class Reservation {
  /// Unique identifier for the reservation
  final String id;

  /// Inventory item ID
  final String inventoryItemId;

  /// Location ID
  final String locationId;

  /// Quantity reserved
  final int quantity;

  /// Line item ID this reservation is for
  final String? lineItemId;

  /// Description of the reservation
  final String? description;

  /// Metadata associated with the reservation
  final Map<String, dynamic>? metadata;

  /// Timestamp of creation
  final DateTime? createdAt;

  /// Timestamp of last update
  final DateTime? updatedAt;

  /// Timestamp of deletion (soft delete)
  final DateTime? deletedAt;

  const Reservation({
    required this.id,
    required this.inventoryItemId,
    required this.locationId,
    required this.quantity,
    this.lineItemId,
    this.description,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);
  Map<String, dynamic> toJson() => _$ReservationToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Reservation &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Reservation(id: $id, quantity: $quantity)';
}
