import 'package:json_annotation/json_annotation.dart';

part 'discount.g.dart';

/// Represents a discount in the Medusa system
@JsonSerializable()
class Discount {
  /// Unique identifier for the discount
  final String id;

  /// Discount code
  final String code;

  /// Whether the discount is dynamic
  final bool isDynamic;

  /// Discount rule ID
  final String? ruleId;

  /// Whether the discount is disabled
  final bool isDisabled;

  /// Parent discount ID (for dynamic discounts)
  final String? parentDiscountId;

  /// Usage limit for the discount
  final int? usageLimit;

  /// Usage count
  final int usageCount;

  /// When the discount starts being valid
  final DateTime? startsAt;

  /// When the discount expires
  final DateTime? endsAt;

  /// When the discount was created
  final DateTime createdAt;

  /// When the discount was last updated
  final DateTime updatedAt;

  /// When the discount was deleted (if soft deleted)
  final DateTime? deletedAt;

  /// Discount metadata
  final Map<String, dynamic>? metadata;

  const Discount({
    required this.id,
    required this.code,
    this.isDynamic = false,
    this.ruleId,
    this.isDisabled = false,
    this.parentDiscountId,
    this.usageLimit,
    this.usageCount = 0,
    this.startsAt,
    this.endsAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.metadata,
  });

  factory Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountToJson(this);

  /// Check if discount is currently valid
  bool get isValid {
    if (isDisabled) return false;

    final now = DateTime.now();
    if (startsAt != null && now.isBefore(startsAt!)) return false;
    if (endsAt != null && now.isAfter(endsAt!)) return false;
    if (usageLimit != null && usageCount >= usageLimit!) return false;

    return true;
  }

  /// Check if discount has expired
  bool get isExpired {
    if (endsAt == null) return false;
    return DateTime.now().isAfter(endsAt!);
  }

  /// Check if discount usage limit is reached
  bool get isUsageLimitReached {
    if (usageLimit == null) return false;
    return usageCount >= usageLimit!;
  }
}
