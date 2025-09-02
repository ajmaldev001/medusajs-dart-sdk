// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['id'] as String,
  title: json['title'] as String?,
  subtitle: json['subtitle'] as String?,
  description: json['description'] as String?,
  handle: json['handle'] as String?,
  isGiftcard: json['is_giftcard'] as bool? ?? false,
  status: $enumDecodeNullable(_$ProductStatusEnumMap, json['status']),
  thumbnail: json['thumbnail'] as String?,
  weight: (json['weight'] as num?)?.toInt(),
  length: (json['length'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
  width: (json['width'] as num?)?.toInt(),
  originCountry: json['origin_country'] as String?,
  hsCode: json['hs_code'] as String?,
  material: json['material'] as String?,
  midCode: json['mid_code'] as String?,
  discountable: json['discountable'] as bool? ?? true,
  externalId: json['external_id'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
          .toList(),
  variants:
      (json['variants'] as List<dynamic>?)
          ?.map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
          .toList(),
  options:
      (json['options'] as List<dynamic>?)
          ?.map((e) => ProductOption.fromJson(e as Map<String, dynamic>))
          .toList(),
  tags:
      (json['tags'] as List<dynamic>?)
          ?.map((e) => ProductTag.fromJson(e as Map<String, dynamic>))
          .toList(),
  type:
      json['type'] == null
          ? null
          : ProductType.fromJson(json['type'] as Map<String, dynamic>),
  collection:
      json['collection'] == null
          ? null
          : Collection.fromJson(json['collection'] as Map<String, dynamic>),
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
  salesChannels:
      (json['sales_channels'] as List<dynamic>?)
          ?.map((e) => SalesChannel.fromJson(e as Map<String, dynamic>))
          .toList(),
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  deletedAt:
      json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'description': instance.description,
  'handle': instance.handle,
  'is_giftcard': instance.isGiftcard,
  'status': _$ProductStatusEnumMap[instance.status],
  'thumbnail': instance.thumbnail,
  'weight': instance.weight,
  'length': instance.length,
  'height': instance.height,
  'width': instance.width,
  'origin_country': instance.originCountry,
  'hs_code': instance.hsCode,
  'material': instance.material,
  'mid_code': instance.midCode,
  'discountable': instance.discountable,
  'external_id': instance.externalId,
  'metadata': instance.metadata,
  'images': instance.images,
  'variants': instance.variants,
  'options': instance.options,
  'tags': instance.tags,
  'type': instance.type,
  'collection': instance.collection,
  'categories': instance.categories,
  'sales_channels': instance.salesChannels,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'deleted_at': instance.deletedAt?.toIso8601String(),
};

const _$ProductStatusEnumMap = {
  ProductStatus.draft: 'draft',
  ProductStatus.proposed: 'proposed',
  ProductStatus.published: 'published',
  ProductStatus.rejected: 'rejected',
};
