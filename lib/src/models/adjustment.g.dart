// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adjustment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Adjustment _$AdjustmentFromJson(Map<String, dynamic> json) => Adjustment(
  id: json['id'] as String?,
  description: json['description'] as String?,
  amount: (json['amount'] as num?)?.toInt(),
  type: json['type'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$AdjustmentToJson(Adjustment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'amount': instance.amount,
      'type': instance.type,
      'metadata': instance.metadata,
    };
