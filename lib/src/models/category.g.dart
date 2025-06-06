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
  isActive: json['isActive'] as bool,
  isInternal: json['isInternal'] as bool,
  parentCategoryId: json['parentCategoryId'] as String?,
  rank: (json['rank'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'handle': instance.handle,
  'isActive': instance.isActive,
  'isInternal': instance.isInternal,
  'parentCategoryId': instance.parentCategoryId,
  'rank': instance.rank,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'metadata': instance.metadata,
};
