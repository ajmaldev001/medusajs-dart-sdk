import 'package:json_annotation/json_annotation.dart';
import 'common.dart';

part 'cart.g.dart';

/// Represents a shopping cart in the Medusa system
@JsonSerializable()
class Cart {
  /// Unique identifier for the cart
  final String id;

  /// Customer ID (if cart belongs to a registered customer)
  final String? customerId;

  /// Customer email
  final String? email;

  /// Billing address ID
  final String? billingAddressId;

  /// Shipping address ID
  final String? shippingAddressId;

  /// Region ID
  final String regionId;

  /// Currency code
  final String currencyCode;

  /// Tax rate applied to the cart
  final double? taxRate;

  /// Cart type
  final CartType type;

  /// Completion status of the cart
  final DateTime? completedAt;

  /// Payment authorized at timestamp
  final DateTime? paymentAuthorizedAt;

  /// Idempotency key for the cart
  final String? idempotencyKey;

  /// Context for the cart
  final Map<String, dynamic>? context;

  /// Total amount (including tax)
  final int total;

  /// Subtotal amount (before tax and shipping)
  final int subtotal;

  /// Tax amount
  final int taxTotal;

  /// Shipping amount
  final int shippingTotal;

  /// Discount amount
  final int discountTotal;

  /// Gift card amount
  final int giftCardTotal;

  /// Gift card tax amount
  final int giftCardTaxTotal;

  /// Item count in the cart
  final int itemCount;

  /// When the cart was created
  final DateTime createdAt;

  /// When the cart was last updated
  final DateTime updatedAt;

  /// When the cart was deleted (if soft deleted)
  final DateTime? deletedAt;

  /// Cart metadata
  final Map<String, dynamic>? metadata;

  const Cart({
    required this.id,
    this.customerId,
    this.email,
    this.billingAddressId,
    this.shippingAddressId,
    required this.regionId,
    required this.currencyCode,
    this.taxRate,
    this.type = CartType.defaultCart,
    this.completedAt,
    this.paymentAuthorizedAt,
    this.idempotencyKey,
    this.context,
    required this.total,
    required this.subtotal,
    required this.taxTotal,
    required this.shippingTotal,
    required this.discountTotal,
    required this.giftCardTotal,
    required this.giftCardTaxTotal,
    required this.itemCount,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.metadata,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);

  /// Check if cart is completed
  bool get isCompleted => completedAt != null;

  /// Check if cart is empty
  bool get isEmpty => itemCount == 0;

  /// Check if cart has items
  bool get hasItems => itemCount > 0;

  /// Check if payment is authorized
  bool get isPaymentAuthorized => paymentAuthorizedAt != null;

  /// Check if cart belongs to a customer
  bool get hasCustomer => customerId != null;

  /// Check if cart has shipping address
  bool get hasShippingAddress => shippingAddressId != null;

  /// Check if cart has billing address
  bool get hasBillingAddress => billingAddressId != null;

  /// Get cart total formatted
  String get formattedTotal {
    return '\$${(total / 100).toStringAsFixed(2)}';
  }

  /// Get cart subtotal formatted
  String get formattedSubtotal {
    return '\$${(subtotal / 100).toStringAsFixed(2)}';
  }

  /// Get tax amount formatted
  String get formattedTaxTotal {
    return '\$${(taxTotal / 100).toStringAsFixed(2)}';
  }

  /// Get shipping amount formatted
  String get formattedShippingTotal {
    return '\$${(shippingTotal / 100).toStringAsFixed(2)}';
  }

  /// Get discount amount formatted
  String get formattedDiscountTotal {
    return '\$${(discountTotal / 100).toStringAsFixed(2)}';
  }
}
