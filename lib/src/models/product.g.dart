// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['id'] as String,
  title: json['title'] as String,
  subtitle: json['subtitle'] as String?,
  description: json['description'] as String?,
  handle: json['handle'] as String?,
  isGiftcard: json['isGiftcard'] as bool? ?? false,
  status:
      $enumDecodeNullable(_$ProductStatusEnumMap, json['status']) ??
      ProductStatus.draft,
  thumbnail: json['thumbnail'] as String?,
  weight: (json['weight'] as num?)?.toInt(),
  length: (json['length'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
  width: (json['width'] as num?)?.toInt(),
  originCountry: json['originCountry'] as String?,
  hsCode: json['hsCode'] as String?,
  material: json['material'] as String?,
  midCode: json['midCode'] as String?,
  discountable: json['discountable'] as bool? ?? true,
  externalId: json['externalId'] as String?,
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
      (json['salesChannels'] as List<dynamic>?)
          ?.map((e) => SalesChannel.fromJson(e as Map<String, dynamic>))
          .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'description': instance.description,
  'handle': instance.handle,
  'isGiftcard': instance.isGiftcard,
  'status': _$ProductStatusEnumMap[instance.status]!,
  'thumbnail': instance.thumbnail,
  'weight': instance.weight,
  'length': instance.length,
  'height': instance.height,
  'width': instance.width,
  'originCountry': instance.originCountry,
  'hsCode': instance.hsCode,
  'material': instance.material,
  'midCode': instance.midCode,
  'discountable': instance.discountable,
  'externalId': instance.externalId,
  'metadata': instance.metadata,
  'images': instance.images,
  'variants': instance.variants,
  'options': instance.options,
  'tags': instance.tags,
  'type': instance.type,
  'collection': instance.collection,
  'categories': instance.categories,
  'salesChannels': instance.salesChannels,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
};

const _$ProductStatusEnumMap = {
  ProductStatus.draft: 'draft',
  ProductStatus.proposed: 'proposed',
  ProductStatus.published: 'published',
  ProductStatus.rejected: 'rejected',
};
