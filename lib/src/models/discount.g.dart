// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Discount _$DiscountFromJson(Map<String, dynamic> json) => Discount(
  id: json['id'] as String,
  code: json['code'] as String,
  isDynamic: json['isDynamic'] as bool? ?? false,
  ruleId: json['ruleId'] as String?,
  isDisabled: json['isDisabled'] as bool? ?? false,
  parentDiscountId: json['parentDiscountId'] as String?,
  usageLimit: (json['usageLimit'] as num?)?.toInt(),
  usageCount: (json['usageCount'] as num?)?.toInt() ?? 0,
  startsAt:
      json['startsAt'] == null
          ? null
          : DateTime.parse(json['startsAt'] as String),
  endsAt:
      json['endsAt'] == null ? null : DateTime.parse(json['endsAt'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$DiscountToJson(Discount instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'isDynamic': instance.isDynamic,
  'ruleId': instance.ruleId,
  'isDisabled': instance.isDisabled,
  'parentDiscountId': instance.parentDiscountId,
  'usageLimit': instance.usageLimit,
  'usageCount': instance.usageCount,
  'startsAt': instance.startsAt?.toIso8601String(),
  'endsAt': instance.endsAt?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
  'metadata': instance.metadata,
};
