// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  handle: json['handle'] as String,
  isActive: json['is_active'] as bool?,
  isInternal: json['is_internal'] as bool?,
  parentCategoryId: json['parent_category_id'] as String?,
  rank: (json['rank'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'handle': instance.handle,
  'is_active': instance.isActive,
  'is_internal': instance.isInternal,
  'parent_category_id': instance.parentCategoryId,
  'rank': instance.rank,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'metadata': instance.metadata,
};
