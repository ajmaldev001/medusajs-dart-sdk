import 'package:json_annotation/json_annotation.dart';
import 'common.dart';

part 'order.g.dart';

/// Represents an order in the Medusa system
@JsonSerializable(fieldRename: FieldRename.snake)
class Order {
  /// Unique identifier for the order
  final String id;

  /// Order status
  final OrderStatus status;

  /// Fulfillment status
  final FulfillmentStatus fulfillmentStatus;

  /// Payment status
  final PaymentStatus paymentStatus;

  /// Order display ID (human-readable)
  final int displayId;

  /// Cart ID this order was created from
  final String? cartId;

  /// Customer ID
  final String? customerId;

  /// Customer email
  final String email;

  /// Billing address ID
  final String? billingAddressId;

  /// Shipping address ID
  final String? shippingAddressId;

  /// Region ID
  final String regionId;

  /// Currency code
  final String currencyCode;

  /// Tax rate applied to the order
  final double? taxRate;

  /// Order total amount (including tax)
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

  /// When the order was created
  final DateTime createdAt;

  /// When the order was last updated
  final DateTime updatedAt;

  /// Order metadata
  final Map<String, dynamic>? metadata;

  const Order({
    required this.id,
    required this.status,
    required this.fulfillmentStatus,
    required this.paymentStatus,
    required this.displayId,
    this.cartId,
    this.customerId,
    required this.email,
    this.billingAddressId,
    this.shippingAddressId,
    required this.regionId,
    required this.currencyCode,
    this.taxRate,
    required this.total,
    required this.subtotal,
    required this.taxTotal,
    required this.shippingTotal,
    required this.discountTotal,
    required this.giftCardTotal,
    required this.giftCardTaxTotal,
    required this.createdAt,
    required this.updatedAt,
    this.metadata,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  /// Check if order can be edited
  bool get canEdit {
    return status == OrderStatus.pending &&
        fulfillmentStatus == FulfillmentStatus.notFulfilled;
  }

  /// Check if order is completed
  bool get isCompleted {
    return status == OrderStatus.completed;
  }

  /// Check if order requires action
  bool get requiresAction {
    return status == OrderStatus.requiresAction;
  }

  /// Check if order is canceled
  bool get isCanceled {
    return status == OrderStatus.canceled;
  }

  /// Check if order is archived
  bool get isArchived {
    return status == OrderStatus.archived;
  }

  /// Check if order is fully fulfilled
  bool get isFullyFulfilled {
    return fulfillmentStatus == FulfillmentStatus.fulfilled;
  }

  /// Check if order is partially fulfilled
  bool get isPartiallyFulfilled {
    return fulfillmentStatus == FulfillmentStatus.partiallyFulfilled;
  }

  /// Check if order is fully paid
  bool get isFullyPaid {
    return paymentStatus == PaymentStatus.captured;
  }

  /// Check if order is partially refunded
  bool get isPartiallyRefunded {
    return paymentStatus == PaymentStatus.partiallyRefunded;
  }

  /// Check if order is fully refunded
  bool get isFullyRefunded {
    return paymentStatus == PaymentStatus.refunded;
  }

  /// Get order grand total formatted
  String get formattedTotal {
    return '\$${(total / 100).toStringAsFixed(2)}';
  }

  /// Get order subtotal formatted
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
}
