import 'package:json_annotation/json_annotation.dart';
import 'common.dart';

part 'cart.g.dart';

/// Represents a shopping cart in the Medusa system
@JsonSerializable(fieldRename: FieldRename.snake)
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
  final double? total;

  /// Subtotal amount (before tax and shipping)
  final double? subtotal;

  /// Tax amount
  final double? taxTotal;

  /// Shipping amount
  final double? shippingTotal;

  /// Discount amount
  final double? discountTotal;

  /// Gift card amount
  final int? giftCardTotal;

  /// Gift card tax amount
  final int? giftCardTaxTotal;

  /// Item count in the cart
  final int? itemCount;

  /// Sales channel ID
  final String? salesChannelId;

  /// Additional totals for comprehensive cart information
  final int? discountSubtotal;
  final int? discountTaxTotal;
  final int? originalTotal;
  final int? originalTaxTotal;
  final int? itemTotal;
  final int? itemSubtotal;
  final int? itemTaxTotal;
  final int? originalItemTotal;
  final int? originalItemSubtotal;
  final int? originalItemTaxTotal;
  final int? shippingSubtotal;
  final int? shippingTaxTotal;
  final int? originalShippingTaxTotal;
  final int? originalShippingSubtotal;
  final int? originalShippingTotal;
  final int? creditLineSubtotal;
  final int? creditLineTaxTotal;
  final int? creditLineTotal;

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
    this.total = 0.0,
    this.subtotal = 0.0,
    this.taxTotal = 0.0,
    this.shippingTotal = 0.0,
    this.discountTotal = 0.0,
    this.giftCardTotal,
    this.giftCardTaxTotal,
    this.itemCount,
    this.salesChannelId,
    this.discountSubtotal,
    this.discountTaxTotal,
    this.originalTotal,
    this.originalTaxTotal,
    this.itemTotal,
    this.itemSubtotal,
    this.itemTaxTotal,
    this.originalItemTotal,
    this.originalItemSubtotal,
    this.originalItemTaxTotal,
    this.shippingSubtotal,
    this.shippingTaxTotal,
    this.originalShippingTaxTotal,
    this.originalShippingSubtotal,
    this.originalShippingTotal,
    this.creditLineSubtotal,
    this.creditLineTaxTotal,
    this.creditLineTotal,
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
  bool get isEmpty => (itemCount ?? 0) == 0;

  /// Check if cart has items
  bool get hasItems => (itemCount ?? 0) > 0;

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
    return '\$${(total ?? 0).toStringAsFixed(2)}';
  }

  /// Get cart subtotal formatted
  String get formattedSubtotal {
    return '\$${(subtotal ?? 0).toStringAsFixed(2)}';
  }

  /// Get tax amount formatted
  String get formattedTaxTotal {
    return '\$${(taxTotal ?? 0).toStringAsFixed(2)}';
  }

  /// Get shipping amount formatted
  String get formattedShippingTotal {
    return '\$${(shippingTotal ?? 0).toStringAsFixed(2)}';
  }

  /// Get discount amount formatted
  String get formattedDiscountTotal {
    return '\$${(discountTotal ?? 0).toStringAsFixed(2)}';
  }
}
