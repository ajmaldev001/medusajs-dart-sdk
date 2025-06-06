import 'package:json_annotation/json_annotation.dart';

part 'line_item.g.dart';

/// Represents a line item in a cart or order
@JsonSerializable()
class LineItem {
  /// Unique identifier for the line item
  final String id;

  /// Cart ID this line item belongs to
  final String? cartId;

  /// Order ID this line item belongs to
  final String? orderId;

  /// Swap ID this line item belongs to
  final String? swapId;

  /// Claim order ID this line item belongs to
  final String? claimOrderId;

  /// Product variant ID
  final String? variantId;

  /// Product title
  final String title;

  /// Product description
  final String? description;

  /// Product thumbnail URL
  final String? thumbnail;

  /// Whether the line item is a return
  final bool isReturn;

  /// Whether the line item requires shipping
  final bool requiresShipping;

  /// Quantity of the item
  final int quantity;

  /// Fulfilled quantity
  final int? fulfilledQuantity;

  /// Returned quantity
  final int? returnedQuantity;

  /// Shipped quantity
  final int? shippedQuantity;

  /// Unit price
  final int unitPrice;

  /// Whether tax is included in the price
  final bool? taxIncludedInPrice;

  /// Total amount for this line item
  final int total;

  /// Subtotal amount
  final int subtotal;

  /// Tax total
  final int taxTotal;

  /// Discount total
  final int discountTotal;

  /// Gift card total
  final int giftCardTotal;

  /// Original total
  final int originalTotal;

  /// Original tax total
  final int originalTaxTotal;

  /// Original item total
  final int originalItemTotal;

  /// Original item subtotal
  final int originalItemSubtotal;

  /// Original item tax total
  final int originalItemTaxTotal;

  /// Original item discount total
  final int originalItemDiscountTotal;

  /// Original item gift card total
  final int originalItemGiftCardTotal;

  /// Line item metadata
  final Map<String, dynamic>? metadata;

  /// When the line item was created
  final DateTime createdAt;

  /// When the line item was last updated
  final DateTime updatedAt;

  const LineItem({
    required this.id,
    this.cartId,
    this.orderId,
    this.swapId,
    this.claimOrderId,
    this.variantId,
    required this.title,
    this.description,
    this.thumbnail,
    this.isReturn = false,
    this.requiresShipping = true,
    required this.quantity,
    this.fulfilledQuantity,
    this.returnedQuantity,
    this.shippedQuantity,
    required this.unitPrice,
    this.taxIncludedInPrice,
    required this.total,
    required this.subtotal,
    required this.taxTotal,
    required this.discountTotal,
    required this.giftCardTotal,
    required this.originalTotal,
    required this.originalTaxTotal,
    required this.originalItemTotal,
    required this.originalItemSubtotal,
    required this.originalItemTaxTotal,
    required this.originalItemDiscountTotal,
    required this.originalItemGiftCardTotal,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) =>
      _$LineItemFromJson(json);
  Map<String, dynamic> toJson() => _$LineItemToJson(this);

  /// Get the total price for this line item (quantity * unit price)
  int get lineTotal => quantity * unitPrice;

  /// Check if this line item can be fulfilled
  bool get canFulfill => (fulfilledQuantity ?? 0) < quantity && !isReturn;

  /// Check if this line item can be returned
  bool get canReturn => (returnedQuantity ?? 0) < quantity && !isReturn;

  /// Get remaining quantity to fulfill
  int get remainingToFulfill => quantity - (fulfilledQuantity ?? 0);

  /// Get remaining quantity that can be returned
  int get remainingToReturn => quantity - (returnedQuantity ?? 0);
}
