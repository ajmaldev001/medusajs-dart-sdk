import 'package:json_annotation/json_annotation.dart';
import 'common.dart';

part 'product_variant.g.dart';

/// Represents a product variant in the Medusa system
@JsonSerializable()
class ProductVariant {
  /// Unique identifier for the product variant
  final String id;

  /// Product variant title
  final String title;

  /// Product variant SKU
  final String? sku;

  /// Product variant barcode
  final String? barcode;

  /// Product variant EAN
  final String? ean;

  /// Product variant UPC
  final String? upc;

  /// Whether the variant allows backorders
  final bool allowBackorder;

  /// Whether inventory is managed for this variant
  final bool manageInventory;

  /// High stock count
  final int? hsCode;

  /// Product variant weight
  final int? weight;

  /// Product variant length
  final int? length;

  /// Product variant height
  final int? height;

  /// Product variant width
  final int? width;

  /// Product variant origin country
  final String? originCountry;

  /// Product variant material
  final String? material;

  /// Product variant options
  final Map<String, dynamic>? options;

  /// Product variant metadata
  final Map<String, dynamic>? metadata;

  /// Product ID this variant belongs to
  final String productId;

  /// Calculated prices for this variant
  final List<ProductVariantPrice>? calculatedPrice;

  /// Original prices for this variant
  final List<ProductVariantPrice>? originalPrice;

  /// When the variant was created
  final DateTime createdAt;

  /// When the variant was last updated
  final DateTime updatedAt;

  /// When the variant was deleted (if soft deleted)
  final DateTime? deletedAt;

  const ProductVariant({
    required this.id,
    required this.title,
    this.sku,
    this.barcode,
    this.ean,
    this.upc,
    this.allowBackorder = false,
    this.manageInventory = true,
    this.hsCode,
    this.weight,
    this.length,
    this.height,
    this.width,
    this.originCountry,
    this.material,
    this.options,
    this.metadata,
    required this.productId,
    this.calculatedPrice,
    this.originalPrice,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantFromJson(json);
  Map<String, dynamic> toJson() => _$ProductVariantToJson(this);

  /// Check if variant has dimensions
  bool get hasDimensions => length != null && height != null && width != null;

  /// Check if variant has weight
  bool get hasWeight => weight != null;

  /// Get variant dimensions as a formatted string
  String get formattedDimensions {
    if (!hasDimensions) return 'N/A';
    return '${length}x${width}x${height}';
  }

  /// Get variant weight formatted
  String get formattedWeight {
    if (!hasWeight) return 'N/A';
    return '${weight}g';
  }

  /// Get variant price for specific currency
  ProductVariantPrice? getPriceForCurrency(String currencyCode) {
    return calculatedPrice
        ?.where((p) => p.currencyCode == currencyCode)
        .firstOrNull;
  }
}

/// Product variant price
@JsonSerializable()
class ProductVariantPrice {
  /// Unique identifier for the price
  final String id;

  /// Currency code
  final String currencyCode;

  /// Price amount
  final int amount;

  /// Minimum quantity for this price
  final int? minQuantity;

  /// Maximum quantity for this price
  final int? maxQuantity;

  /// Price list ID if this price belongs to a price list
  final String? priceListId;

  const ProductVariantPrice({
    required this.id,
    required this.currencyCode,
    required this.amount,
    this.minQuantity,
    this.maxQuantity,
    this.priceListId,
  });

  factory ProductVariantPrice.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantPriceFromJson(json);
  Map<String, dynamic> toJson() => _$ProductVariantPriceToJson(this);

  /// Get formatted price
  String getFormattedPrice([int? decimalPlaces = 2]) {
    final price = amount / 100;
    return price.toStringAsFixed(decimalPlaces!);
  }
}

/// Request to create a product variant
@JsonSerializable()
class CreateProductVariantRequest {
  /// Product variant title
  final String title;

  /// Product variant SKU
  final String? sku;

  /// Product variant barcode
  final String? barcode;

  /// Product variant EAN
  final String? ean;

  /// Product variant UPC
  final String? upc;

  /// Whether the variant allows backorders
  final bool? allowBackorder;

  /// Whether inventory is managed for this variant
  final bool? manageInventory;

  /// High stock count
  final int? hsCode;

  /// Product variant weight
  final int? weight;

  /// Product variant length
  final int? length;

  /// Product variant height
  final int? height;

  /// Product variant width
  final int? width;

  /// Product variant origin country
  final String? originCountry;

  /// Product variant material
  final String? material;

  /// Product variant options
  final Map<String, dynamic>? options;

  /// Product variant metadata
  final Map<String, dynamic>? metadata;

  /// Prices for this variant
  final List<CreateProductVariantPriceRequest>? prices;

  const CreateProductVariantRequest({
    required this.title,
    this.sku,
    this.barcode,
    this.ean,
    this.upc,
    this.allowBackorder,
    this.manageInventory,
    this.hsCode,
    this.weight,
    this.length,
    this.height,
    this.width,
    this.originCountry,
    this.material,
    this.options,
    this.metadata,
    this.prices,
  });

  factory CreateProductVariantRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateProductVariantRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateProductVariantRequestToJson(this);
}

/// Request to create a product variant price
@JsonSerializable()
class CreateProductVariantPriceRequest {
  /// Currency code
  final String currencyCode;

  /// Price amount
  final int amount;

  /// Minimum quantity for this price
  final int? minQuantity;

  /// Maximum quantity for this price
  final int? maxQuantity;

  /// Price list ID if this price belongs to a price list
  final String? priceListId;

  const CreateProductVariantPriceRequest({
    required this.currencyCode,
    required this.amount,
    this.minQuantity,
    this.maxQuantity,
    this.priceListId,
  });

  factory CreateProductVariantPriceRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$CreateProductVariantPriceRequestFromJson(json);
  Map<String, dynamic> toJson() =>
      _$CreateProductVariantPriceRequestToJson(this);
}

/// Request to update a product variant
@JsonSerializable()
class UpdateProductVariantRequest {
  /// Product variant title
  final String? title;

  /// Product variant SKU
  final String? sku;

  /// Product variant barcode
  final String? barcode;

  /// Product variant EAN
  final String? ean;

  /// Product variant UPC
  final String? upc;

  /// Whether the variant allows backorders
  final bool? allowBackorder;

  /// Whether inventory is managed for this variant
  final bool? manageInventory;

  /// High stock count
  final int? hsCode;

  /// Product variant weight
  final int? weight;

  /// Product variant length
  final int? length;

  /// Product variant height
  final int? height;

  /// Product variant width
  final int? width;

  /// Product variant origin country
  final String? originCountry;

  /// Product variant material
  final String? material;

  /// Product variant options
  final Map<String, dynamic>? options;

  /// Product variant metadata
  final Map<String, dynamic>? metadata;

  const UpdateProductVariantRequest({
    this.title,
    this.sku,
    this.barcode,
    this.ean,
    this.upc,
    this.allowBackorder,
    this.manageInventory,
    this.hsCode,
    this.weight,
    this.length,
    this.height,
    this.width,
    this.originCountry,
    this.material,
    this.options,
    this.metadata,
  });

  factory UpdateProductVariantRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProductVariantRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProductVariantRequestToJson(this);
}
