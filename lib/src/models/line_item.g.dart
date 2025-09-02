// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LineItem _$LineItemFromJson(Map<String, dynamic> json) => LineItem(
  id: json['id'] as String,
  title: json['title'] as String,
  quantity: (json['quantity'] as num).toInt(),
  unitPrice: (json['unit_price'] as num).toInt(),
  originalUnitPrice: (json['original_unit_price'] as num?)?.toInt(),
  variantPrice: (json['variant_price'] as num?)?.toInt(),
  subtotal: (json['subtotal'] as num?)?.toInt(),
  discountTotal: (json['discount_total'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
  originalTotal: (json['original_total'] as num?)?.toInt(),
  taxTotal: (json['tax_total'] as num?)?.toInt(),
  rawDiscountTotal: (json['raw_discount_total'] as num?)?.toInt(),
  refundable: (json['refundable'] as num?)?.toInt(),
  isGiftCard: json['is_gift_card'] as bool?,
  shouldMerge: json['should_merge'] as bool?,
  allowDiscounts: json['allow_discounts'] as bool?,
  hasShipping: json['has_shipping'] as bool?,
  isReturn: json['is_return'] as bool?,
  isTaxInclusive: json['is_tax_inclusive'] as bool?,
  cartId: json['cart_id'] as String?,
  orderId: json['order_id'] as String?,
  swapId: json['swap_id'] as String?,
  claimOrderId: json['claim_order_id'] as String?,
  titleOverride: json['title_override'] as String?,
  description: json['description'] as String?,
  thumbnail: json['thumbnail'] as String?,
  variantId: json['variant_id'] as String?,
  productId: json['product_id'] as String?,
  adjustments:
      (json['adjustments'] as List<dynamic>?)
          ?.map((e) => Adjustment.fromJson(e as Map<String, dynamic>))
          .toList(),
  taxLines:
      (json['tax_lines'] as List<dynamic>?)
          ?.map((e) => TaxLine.fromJson(e as Map<String, dynamic>))
          .toList(),
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  product:
      json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
  variant:
      json['variant'] == null
          ? null
          : ProductVariant.fromJson(json['variant'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LineItemToJson(LineItem instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'quantity': instance.quantity,
  'unit_price': instance.unitPrice,
  'original_unit_price': instance.originalUnitPrice,
  'variant_price': instance.variantPrice,
  'subtotal': instance.subtotal,
  'discount_total': instance.discountTotal,
  'total': instance.total,
  'original_total': instance.originalTotal,
  'tax_total': instance.taxTotal,
  'raw_discount_total': instance.rawDiscountTotal,
  'refundable': instance.refundable,
  'is_gift_card': instance.isGiftCard,
  'should_merge': instance.shouldMerge,
  'allow_discounts': instance.allowDiscounts,
  'has_shipping': instance.hasShipping,
  'is_return': instance.isReturn,
  'is_tax_inclusive': instance.isTaxInclusive,
  'cart_id': instance.cartId,
  'order_id': instance.orderId,
  'swap_id': instance.swapId,
  'claim_order_id': instance.claimOrderId,
  'title_override': instance.titleOverride,
  'description': instance.description,
  'thumbnail': instance.thumbnail,
  'variant_id': instance.variantId,
  'product_id': instance.productId,
  'metadata': instance.metadata,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'product': instance.product,
  'variant': instance.variant,
  'adjustments': instance.adjustments,
  'tax_lines': instance.taxLines,
};
