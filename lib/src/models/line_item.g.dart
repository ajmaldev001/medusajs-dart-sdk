// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LineItem _$LineItemFromJson(Map<String, dynamic> json) => LineItem(
  id: json['id'] as String,
  cartId: json['cart_id'] as String?,
  orderId: json['order_id'] as String?,
  swapId: json['swap_id'] as String?,
  claimOrderId: json['claim_order_id'] as String?,
  variantId: json['variant_id'] as String?,
  title: json['title'] as String,
  description: json['description'] as String?,
  thumbnail: json['thumbnail'] as String?,
  isReturn: json['is_return'] as bool? ?? false,
  requiresShipping: json['requires_shipping'] as bool? ?? true,
  quantity: (json['quantity'] as num).toInt(),
  fulfilledQuantity: (json['fulfilled_quantity'] as num?)?.toInt(),
  returnedQuantity: (json['returned_quantity'] as num?)?.toInt(),
  shippedQuantity: (json['shipped_quantity'] as num?)?.toInt(),
  unitPrice: (json['unit_price'] as num).toInt(),
  taxIncludedInPrice: json['tax_included_in_price'] as bool?,
  total: (json['total'] as num).toInt(),
  subtotal: (json['subtotal'] as num).toInt(),
  taxTotal: (json['tax_total'] as num).toInt(),
  discountTotal: (json['discount_total'] as num).toInt(),
  giftCardTotal: (json['gift_card_total'] as num).toInt(),
  originalTotal: (json['original_total'] as num).toInt(),
  originalTaxTotal: (json['original_tax_total'] as num).toInt(),
  originalItemTotal: (json['original_item_total'] as num).toInt(),
  originalItemSubtotal: (json['original_item_subtotal'] as num).toInt(),
  originalItemTaxTotal: (json['original_item_tax_total'] as num).toInt(),
  originalItemDiscountTotal:
      (json['original_item_discount_total'] as num).toInt(),
  originalItemGiftCardTotal:
      (json['original_item_gift_card_total'] as num).toInt(),
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$LineItemToJson(LineItem instance) => <String, dynamic>{
  'id': instance.id,
  'cart_id': instance.cartId,
  'order_id': instance.orderId,
  'swap_id': instance.swapId,
  'claim_order_id': instance.claimOrderId,
  'variant_id': instance.variantId,
  'title': instance.title,
  'description': instance.description,
  'thumbnail': instance.thumbnail,
  'is_return': instance.isReturn,
  'requires_shipping': instance.requiresShipping,
  'quantity': instance.quantity,
  'fulfilled_quantity': instance.fulfilledQuantity,
  'returned_quantity': instance.returnedQuantity,
  'shipped_quantity': instance.shippedQuantity,
  'unit_price': instance.unitPrice,
  'tax_included_in_price': instance.taxIncludedInPrice,
  'total': instance.total,
  'subtotal': instance.subtotal,
  'tax_total': instance.taxTotal,
  'discount_total': instance.discountTotal,
  'gift_card_total': instance.giftCardTotal,
  'original_total': instance.originalTotal,
  'original_tax_total': instance.originalTaxTotal,
  'original_item_total': instance.originalItemTotal,
  'original_item_subtotal': instance.originalItemSubtotal,
  'original_item_tax_total': instance.originalItemTaxTotal,
  'original_item_discount_total': instance.originalItemDiscountTotal,
  'original_item_gift_card_total': instance.originalItemGiftCardTotal,
  'metadata': instance.metadata,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
