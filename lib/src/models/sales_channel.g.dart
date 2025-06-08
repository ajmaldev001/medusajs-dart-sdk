// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesChannel _$SalesChannelFromJson(Map<String, dynamic> json) => SalesChannel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  isDisabled: json['isDisabled'] as bool? ?? false,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$SalesChannelToJson(SalesChannel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isDisabled': instance.isDisabled,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

CreateSalesChannelRequest _$CreateSalesChannelRequestFromJson(
  Map<String, dynamic> json,
) => CreateSalesChannelRequest(
  name: json['name'] as String,
  description: json['description'] as String?,
  isDisabled: json['isDisabled'] as bool?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateSalesChannelRequestToJson(
  CreateSalesChannelRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'isDisabled': instance.isDisabled,
  'metadata': instance.metadata,
};

UpdateSalesChannelRequest _$UpdateSalesChannelRequestFromJson(
  Map<String, dynamic> json,
) => UpdateSalesChannelRequest(
  name: json['name'] as String?,
  description: json['description'] as String?,
  isDisabled: json['isDisabled'] as bool?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UpdateSalesChannelRequestToJson(
  UpdateSalesChannelRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'isDisabled': instance.isDisabled,
  'metadata': instance.metadata,
};
