import 'package:json_annotation/json_annotation.dart';

part 'gift_card.g.dart';

/// Represents a gift card in the Medusa system
@JsonSerializable(fieldRename: FieldRename.snake)
class GiftCard {
  /// Unique identifier for the gift card
  final String id;

  /// Gift card code
  final String code;

  /// Gift card value
  final int value;

  /// Gift card balance
  final int balance;

  /// Region ID where the gift card can be used
  final String? regionId;

  /// Order ID where the gift card was purchased
  final String? orderId;

  /// Whether the gift card is disabled
  final bool isDisabled;

  /// When the gift card expires
  final DateTime? endsAt;

  /// When the gift card was created
  final DateTime createdAt;

  /// When the gift card was last updated
  final DateTime updatedAt;

  /// When the gift card was deleted (if soft deleted)
  final DateTime? deletedAt;

  /// Gift card metadata
  final Map<String, dynamic>? metadata;

  const GiftCard({
    required this.id,
    required this.code,
    required this.value,
    required this.balance,
    this.regionId,
    this.orderId,
    this.isDisabled = false,
    this.endsAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.metadata,
  });

  factory GiftCard.fromJson(Map<String, dynamic> json) =>
      _$GiftCardFromJson(json);
  Map<String, dynamic> toJson() => _$GiftCardToJson(this);

  /// Check if gift card is currently valid
  bool get isValid {
    if (isDisabled) return false;
    if (balance <= 0) return false;
    if (endsAt != null && DateTime.now().isAfter(endsAt!)) return false;
    return true;
  }

  /// Check if gift card has expired
  bool get isExpired {
    if (endsAt == null) return false;
    return DateTime.now().isAfter(endsAt!);
  }

  /// Check if gift card has been fully used
  bool get isFullyUsed {
    return balance <= 0;
  }

  /// Get the amount that has been used from this gift card
  int get usedAmount {
    return value - balance;
  }

  /// Get usage percentage (0.0 to 1.0)
  double get usagePercentage {
    if (value <= 0) return 0.0;
    return usedAmount / value;
  }
}
