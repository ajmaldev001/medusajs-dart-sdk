import 'package:json_annotation/json_annotation.dart';

part 'shipping.g.dart';

/// Represents a shipping option in the Medusa system
@JsonSerializable()
class ShippingOption {
  /// Unique identifier for the shipping option
  final String id;

  /// Shipping option name
  final String name;

  /// Region ID this shipping option belongs to
  final String regionId;

  /// Profile ID for the shipping option
  final String profileId;

  /// Provider ID for the shipping option
  final String providerId;

  /// Price type (flat_rate, calculated)
  final PriceType priceType;

  /// Amount in the smallest currency unit
  final int? amount;

  /// Whether the shipping option is return option
  final bool isReturn;

  /// Whether the shipping option is admin only
  final bool? adminOnly;

  /// Requirements for this shipping option
  final List<ShippingOptionRequirement>? requirements;

  /// Data associated with the shipping option
  final Map<String, dynamic>? data;

  /// Metadata associated with the shipping option
  final Map<String, dynamic>? metadata;

  /// Timestamp of creation
  final DateTime? createdAt;

  /// Timestamp of last update
  final DateTime? updatedAt;

  /// Timestamp of deletion (soft delete)
  final DateTime? deletedAt;

  const ShippingOption({
    required this.id,
    required this.name,
    required this.regionId,
    required this.profileId,
    required this.providerId,
    required this.priceType,
    this.amount,
    required this.isReturn,
    this.adminOnly,
    this.requirements,
    this.data,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ShippingOption.fromJson(Map<String, dynamic> json) =>
      _$ShippingOptionFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingOptionToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShippingOption &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ShippingOption(id: $id, name: $name)';
}

/// Represents a shipping option requirement
@JsonSerializable()
class ShippingOptionRequirement {
  /// Unique identifier for the requirement
  final String id;

  /// Shipping option ID this requirement belongs to
  final String shippingOptionId;

  /// Type of requirement (min_subtotal, max_subtotal)
  final RequirementType type;

  /// Amount for the requirement
  final int amount;

  /// Timestamp of deletion (soft delete)
  final DateTime? deletedAt;

  const ShippingOptionRequirement({
    required this.id,
    required this.shippingOptionId,
    required this.type,
    required this.amount,
    this.deletedAt,
  });

  factory ShippingOptionRequirement.fromJson(Map<String, dynamic> json) =>
      _$ShippingOptionRequirementFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingOptionRequirementToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShippingOptionRequirement &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'ShippingOptionRequirement(id: $id, type: $type, amount: $amount)';
}

/// Represents a shipping method (selected shipping option)
@JsonSerializable()
class ShippingMethod {
  /// Unique identifier for the shipping method
  final String id;

  /// Shipping option ID this method is based on
  final String shippingOptionId;

  /// Cart ID this method belongs to
  final String? cartId;

  /// Order ID this method belongs to
  final String? orderId;

  /// Swap ID this method belongs to
  final String? swapId;

  /// Return ID this method belongs to
  final String? returnId;

  /// Claim ID this method belongs to
  final String? claimId;

  /// Price in the smallest currency unit
  final int price;

  /// Data associated with the shipping method
  final Map<String, dynamic>? data;

  /// Timestamp of creation
  final DateTime? createdAt;

  /// Timestamp of last update
  final DateTime? updatedAt;

  const ShippingMethod({
    required this.id,
    required this.shippingOptionId,
    this.cartId,
    this.orderId,
    this.swapId,
    this.returnId,
    this.claimId,
    required this.price,
    this.data,
    this.createdAt,
    this.updatedAt,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) =>
      _$ShippingMethodFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingMethodToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShippingMethod &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ShippingMethod(id: $id, price: $price)';
}

/// Price type for shipping options
enum PriceType {
  @JsonValue('flat_rate')
  flatRate,
  @JsonValue('calculated')
  calculated,
}

/// Requirement type for shipping option requirements
enum RequirementType {
  @JsonValue('min_subtotal')
  minSubtotal,
  @JsonValue('max_subtotal')
  maxSubtotal,
}
