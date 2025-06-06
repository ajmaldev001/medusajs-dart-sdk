import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

/// Represents payment information
@JsonSerializable()
class Payment {
  /// Unique identifier for the payment
  final String id;

  /// Swap ID if this payment is for a swap
  final String? swapId;

  /// Cart ID if this payment is for a cart
  final String? cartId;

  /// Order ID if this payment is for an order
  final String? orderId;

  /// Amount of the payment
  final int amount;

  /// Currency code for the payment
  final String currencyCode;

  /// Amount refunded
  final int amountRefunded;

  /// Provider ID for the payment
  final String providerId;

  /// Payment data from the provider
  final Map<String, dynamic> data;

  /// When the payment was captured
  final DateTime? capturedAt;

  /// When the payment was canceled
  final DateTime? canceledAt;

  /// When the payment was created
  final DateTime createdAt;

  /// When the payment was last updated
  final DateTime updatedAt;

  /// Payment metadata
  final Map<String, dynamic>? metadata;

  const Payment({
    required this.id,
    this.swapId,
    this.cartId,
    this.orderId,
    required this.amount,
    required this.currencyCode,
    required this.amountRefunded,
    required this.providerId,
    required this.data,
    this.capturedAt,
    this.canceledAt,
    required this.createdAt,
    required this.updatedAt,
    this.metadata,
  });

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  /// Check if payment is captured
  bool get isCaptured => capturedAt != null;

  /// Check if payment is canceled
  bool get isCanceled => canceledAt != null;

  /// Get the formatted amount
  String formattedAmount() {
    final value = amount / 100;

    switch (currencyCode.toUpperCase()) {
      case 'USD':
        return '\$${value.toStringAsFixed(2)}';
      case 'EUR':
        return '€${value.toStringAsFixed(2)}';
      case 'GBP':
        return '£${value.toStringAsFixed(2)}';
      default:
        return '${value.toStringAsFixed(2)} $currencyCode';
    }
  }
}
