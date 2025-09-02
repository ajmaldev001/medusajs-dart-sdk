import 'package:json_annotation/json_annotation.dart';
import 'package:medusajs_dart_sdk/src/models/product_variant.dart';
import 'adjustment.dart';
import 'tax.dart';
import 'product.dart';

part 'line_item.g.dart';

/// Represents a line item in a cart or order
@JsonSerializable(fieldRename: FieldRename.snake)
class LineItem {
  final String id;
  final String title;
  final int quantity;
  final int unitPrice;
  final int? originalUnitPrice;
  final int? variantPrice;
  final int? subtotal;
  final int? discountTotal;
  final int? total;
  final int? originalTotal;
  final int? taxTotal;
  final int? rawDiscountTotal;
  final int? refundable;
  final bool? isGiftCard;
  final bool? shouldMerge;
  final bool? allowDiscounts;
  final bool? hasShipping;
  final bool? isReturn;
  final bool? isTaxInclusive;
  final String? cartId;
  final String? orderId;
  final String? swapId;
  final String? claimOrderId;
  final String? titleOverride;
  final String? description;
  final String? thumbnail;
  final String? variantId;
  final String? productId;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;
  final ProductVariant? variant;
  final List<Adjustment>? adjustments;
  final List<TaxLine>? taxLines;

  const LineItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.unitPrice,
    this.originalUnitPrice,
    this.variantPrice,
    this.subtotal,
    this.discountTotal,
    this.total,
    this.originalTotal,
    this.taxTotal,
    this.rawDiscountTotal,
    this.refundable,
    this.isGiftCard,
    this.shouldMerge,
    this.allowDiscounts,
    this.hasShipping,
    this.isReturn,
    this.isTaxInclusive,
    this.cartId,
    this.orderId,
    this.swapId,
    this.claimOrderId,
    this.titleOverride,
    this.description,
    this.thumbnail,
    this.variantId,
    this.productId,
    this.adjustments,
    this.taxLines,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.variant,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) =>
      _$LineItemFromJson(json);
  Map<String, dynamic> toJson() => _$LineItemToJson(this);
}
