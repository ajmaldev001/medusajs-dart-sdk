// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVariant _$ProductVariantFromJson(
  Map<String, dynamic> json,
) => ProductVariant(
  id: json['id'] as String,
  title: json['title'] as String,
  sku: json['sku'] as String?,
  barcode: json['barcode'] as String?,
  ean: json['ean'] as String?,
  upc: json['upc'] as String?,
  allowBackorder: json['allowBackorder'] as bool? ?? false,
  manageInventory: json['manageInventory'] as bool? ?? true,
  hsCode: (json['hsCode'] as num?)?.toInt(),
  weight: (json['weight'] as num?)?.toInt(),
  length: (json['length'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
  width: (json['width'] as num?)?.toInt(),
  originCountry: json['originCountry'] as String?,
  material: json['material'] as String?,
  options: json['options'] as Map<String, dynamic>?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  productId: json['productId'] as String,
  calculatedPrice:
      (json['calculatedPrice'] as List<dynamic>?)
          ?.map((e) => ProductVariantPrice.fromJson(e as Map<String, dynamic>))
          .toList(),
  originalPrice:
      (json['originalPrice'] as List<dynamic>?)
          ?.map((e) => ProductVariantPrice.fromJson(e as Map<String, dynamic>))
          .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$ProductVariantToJson(ProductVariant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sku': instance.sku,
      'barcode': instance.barcode,
      'ean': instance.ean,
      'upc': instance.upc,
      'allowBackorder': instance.allowBackorder,
      'manageInventory': instance.manageInventory,
      'hsCode': instance.hsCode,
      'weight': instance.weight,
      'length': instance.length,
      'height': instance.height,
      'width': instance.width,
      'originCountry': instance.originCountry,
      'material': instance.material,
      'options': instance.options,
      'metadata': instance.metadata,
      'productId': instance.productId,
      'calculatedPrice': instance.calculatedPrice,
      'originalPrice': instance.originalPrice,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

ProductVariantPrice _$ProductVariantPriceFromJson(Map<String, dynamic> json) =>
    ProductVariantPrice(
      id: json['id'] as String,
      currencyCode: json['currencyCode'] as String,
      amount: (json['amount'] as num).toInt(),
      minQuantity: (json['minQuantity'] as num?)?.toInt(),
      maxQuantity: (json['maxQuantity'] as num?)?.toInt(),
      priceListId: json['priceListId'] as String?,
    );

Map<String, dynamic> _$ProductVariantPriceToJson(
  ProductVariantPrice instance,
) => <String, dynamic>{
  'id': instance.id,
  'currencyCode': instance.currencyCode,
  'amount': instance.amount,
  'minQuantity': instance.minQuantity,
  'maxQuantity': instance.maxQuantity,
  'priceListId': instance.priceListId,
};

CreateProductVariantRequest _$CreateProductVariantRequestFromJson(
  Map<String, dynamic> json,
) => CreateProductVariantRequest(
  title: json['title'] as String,
  sku: json['sku'] as String?,
  barcode: json['barcode'] as String?,
  ean: json['ean'] as String?,
  upc: json['upc'] as String?,
  allowBackorder: json['allowBackorder'] as bool?,
  manageInventory: json['manageInventory'] as bool?,
  hsCode: (json['hsCode'] as num?)?.toInt(),
  weight: (json['weight'] as num?)?.toInt(),
  length: (json['length'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
  width: (json['width'] as num?)?.toInt(),
  originCountry: json['originCountry'] as String?,
  material: json['material'] as String?,
  options: json['options'] as Map<String, dynamic>?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  prices:
      (json['prices'] as List<dynamic>?)
          ?.map(
            (e) => CreateProductVariantPriceRequest.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
);

Map<String, dynamic> _$CreateProductVariantRequestToJson(
  CreateProductVariantRequest instance,
) => <String, dynamic>{
  'title': instance.title,
  'sku': instance.sku,
  'barcode': instance.barcode,
  'ean': instance.ean,
  'upc': instance.upc,
  'allowBackorder': instance.allowBackorder,
  'manageInventory': instance.manageInventory,
  'hsCode': instance.hsCode,
  'weight': instance.weight,
  'length': instance.length,
  'height': instance.height,
  'width': instance.width,
  'originCountry': instance.originCountry,
  'material': instance.material,
  'options': instance.options,
  'metadata': instance.metadata,
  'prices': instance.prices,
};

CreateProductVariantPriceRequest _$CreateProductVariantPriceRequestFromJson(
  Map<String, dynamic> json,
) => CreateProductVariantPriceRequest(
  currencyCode: json['currencyCode'] as String,
  amount: (json['amount'] as num).toInt(),
  minQuantity: (json['minQuantity'] as num?)?.toInt(),
  maxQuantity: (json['maxQuantity'] as num?)?.toInt(),
  priceListId: json['priceListId'] as String?,
);

Map<String, dynamic> _$CreateProductVariantPriceRequestToJson(
  CreateProductVariantPriceRequest instance,
) => <String, dynamic>{
  'currencyCode': instance.currencyCode,
  'amount': instance.amount,
  'minQuantity': instance.minQuantity,
  'maxQuantity': instance.maxQuantity,
  'priceListId': instance.priceListId,
};

UpdateProductVariantRequest _$UpdateProductVariantRequestFromJson(
  Map<String, dynamic> json,
) => UpdateProductVariantRequest(
  title: json['title'] as String?,
  sku: json['sku'] as String?,
  barcode: json['barcode'] as String?,
  ean: json['ean'] as String?,
  upc: json['upc'] as String?,
  allowBackorder: json['allowBackorder'] as bool?,
  manageInventory: json['manageInventory'] as bool?,
  hsCode: (json['hsCode'] as num?)?.toInt(),
  weight: (json['weight'] as num?)?.toInt(),
  length: (json['length'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
  width: (json['width'] as num?)?.toInt(),
  originCountry: json['originCountry'] as String?,
  material: json['material'] as String?,
  options: json['options'] as Map<String, dynamic>?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UpdateProductVariantRequestToJson(
  UpdateProductVariantRequest instance,
) => <String, dynamic>{
  'title': instance.title,
  'sku': instance.sku,
  'barcode': instance.barcode,
  'ean': instance.ean,
  'upc': instance.upc,
  'allowBackorder': instance.allowBackorder,
  'manageInventory': instance.manageInventory,
  'hsCode': instance.hsCode,
  'weight': instance.weight,
  'length': instance.length,
  'height': instance.height,
  'width': instance.width,
  'originCountry': instance.originCountry,
  'material': instance.material,
  'options': instance.options,
  'metadata': instance.metadata,
};
