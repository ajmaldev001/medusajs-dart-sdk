import 'package:json_annotation/json_annotation.dart';

part 'fulfillment.g.dart';

/// Fulfillment status
enum FulfillmentStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('packed')
  packed,
  @JsonValue('shipped')
  shipped,
  @JsonValue('delivered')
  delivered,
  @JsonValue('canceled')
  canceled,
}

/// Represents a fulfillment
@JsonSerializable(fieldRename: FieldRename.snake)
class Fulfillment {
  /// Unique identifier for the fulfillment
  final String id;

  /// Fulfillment location ID
  final String? locationId;

  /// Whether fulfillment is packed by user
  final bool packedAt;

  /// Whether fulfillment is shipped
  final bool shippedAt;

  /// Whether fulfillment is delivered
  final bool deliveredAt;

  /// Whether fulfillment is canceled
  final bool canceledAt;

  /// Data for the fulfillment provider
  final Map<String, dynamic>? data;

  /// Provider ID for the fulfillment
  final String providerId;

  /// Shipping option ID
  final String shippingOptionId;

  /// Fulfillment metadata
  final Map<String, dynamic>? metadata;

  /// When the fulfillment was created
  final DateTime createdAt;

  /// When the fulfillment was last updated
  final DateTime updatedAt;

  /// When the fulfillment was deleted (if soft deleted)
  final DateTime? deletedAt;

  const Fulfillment({
    required this.id,
    this.locationId,
    this.packedAt = false,
    this.shippedAt = false,
    this.deliveredAt = false,
    this.canceledAt = false,
    this.data,
    required this.providerId,
    required this.shippingOptionId,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Fulfillment.fromJson(Map<String, dynamic> json) =>
      _$FulfillmentFromJson(json);
  Map<String, dynamic> toJson() => _$FulfillmentToJson(this);

  /// Get current status based on flags
  FulfillmentStatus get status {
    if (canceledAt) return FulfillmentStatus.canceled;
    if (deliveredAt) return FulfillmentStatus.delivered;
    if (shippedAt) return FulfillmentStatus.shipped;
    if (packedAt) return FulfillmentStatus.packed;
    return FulfillmentStatus.pending;
  }
}

/// Represents a shipping option
@JsonSerializable(fieldRename: FieldRename.snake)
class ShippingOption {
  /// Unique identifier for the shipping option
  final String id;

  /// Shipping option name
  final String name;

  /// Price type for the shipping option
  final String priceType;

  /// Service zone ID
  final String? serviceZoneId;

  /// Shipping profile ID
  final String? shippingProfileId;

  /// Provider ID
  final String? providerId;

  /// Data for the shipping provider
  final Map<String, dynamic>? data;

  /// Shipping option metadata
  final Map<String, dynamic>? metadata;

  /// When the shipping option was created
  final DateTime createdAt;

  /// When the shipping option was last updated
  final DateTime updatedAt;

  /// When the shipping option was deleted (if soft deleted)
  final DateTime? deletedAt;

  const ShippingOption({
    required this.id,
    required this.name,
    required this.priceType,
    this.serviceZoneId,
    this.shippingProfileId,
    this.providerId,
    this.data,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ShippingOption.fromJson(Map<String, dynamic> json) =>
      _$ShippingOptionFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingOptionToJson(this);
}

/// Represents a shipping profile
@JsonSerializable(fieldRename: FieldRename.snake)
class ShippingProfile {
  /// Unique identifier for the shipping profile
  final String id;

  /// Shipping profile name
  final String name;

  /// Shipping profile type
  final String type;

  /// Shipping profile metadata
  final Map<String, dynamic>? metadata;

  /// When the shipping profile was created
  final DateTime createdAt;

  /// When the shipping profile was last updated
  final DateTime updatedAt;

  /// When the shipping profile was deleted (if soft deleted)
  final DateTime? deletedAt;

  const ShippingProfile({
    required this.id,
    required this.name,
    required this.type,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ShippingProfile.fromJson(Map<String, dynamic> json) =>
      _$ShippingProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingProfileToJson(this);
}
