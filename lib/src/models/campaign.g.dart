// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Campaign _$CampaignFromJson(Map<String, dynamic> json) => Campaign(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  currencyCode: json['currencyCode'] as String?,
  status: $enumDecode(_$CampaignStatusEnumMap, json['status']),
  budget:
      json['budget'] == null
          ? null
          : CampaignBudget.fromJson(json['budget'] as Map<String, dynamic>),
  startsAt:
      json['startsAt'] == null
          ? null
          : DateTime.parse(json['startsAt'] as String),
  endsAt:
      json['endsAt'] == null ? null : DateTime.parse(json['endsAt'] as String),
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$CampaignToJson(Campaign instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'currencyCode': instance.currencyCode,
  'status': _$CampaignStatusEnumMap[instance.status]!,
  'budget': instance.budget,
  'startsAt': instance.startsAt?.toIso8601String(),
  'endsAt': instance.endsAt?.toIso8601String(),
  'metadata': instance.metadata,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
};

const _$CampaignStatusEnumMap = {
  CampaignStatus.active: 'active',
  CampaignStatus.inactive: 'inactive',
  CampaignStatus.draft: 'draft',
};

CampaignBudget _$CampaignBudgetFromJson(Map<String, dynamic> json) =>
    CampaignBudget(
      type: $enumDecode(_$CampaignBudgetTypeEnumMap, json['type']),
      limit: (json['limit'] as num?)?.toInt(),
      used: (json['used'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CampaignBudgetToJson(CampaignBudget instance) =>
    <String, dynamic>{
      'type': _$CampaignBudgetTypeEnumMap[instance.type]!,
      'limit': instance.limit,
      'used': instance.used,
    };

const _$CampaignBudgetTypeEnumMap = {
  CampaignBudgetType.spend: 'spend',
  CampaignBudgetType.usage: 'usage',
};

CreateCampaignRequest _$CreateCampaignRequestFromJson(
  Map<String, dynamic> json,
) => CreateCampaignRequest(
  name: json['name'] as String,
  description: json['description'] as String?,
  currencyCode: json['currencyCode'] as String?,
  status: $enumDecodeNullable(_$CampaignStatusEnumMap, json['status']),
  budget:
      json['budget'] == null
          ? null
          : CampaignBudget.fromJson(json['budget'] as Map<String, dynamic>),
  startsAt:
      json['startsAt'] == null
          ? null
          : DateTime.parse(json['startsAt'] as String),
  endsAt:
      json['endsAt'] == null ? null : DateTime.parse(json['endsAt'] as String),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateCampaignRequestToJson(
  CreateCampaignRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'currencyCode': instance.currencyCode,
  'status': _$CampaignStatusEnumMap[instance.status],
  'budget': instance.budget,
  'startsAt': instance.startsAt?.toIso8601String(),
  'endsAt': instance.endsAt?.toIso8601String(),
  'metadata': instance.metadata,
};

UpdateCampaignRequest _$UpdateCampaignRequestFromJson(
  Map<String, dynamic> json,
) => UpdateCampaignRequest(
  name: json['name'] as String?,
  description: json['description'] as String?,
  currencyCode: json['currencyCode'] as String?,
  status: $enumDecodeNullable(_$CampaignStatusEnumMap, json['status']),
  budget:
      json['budget'] == null
          ? null
          : CampaignBudget.fromJson(json['budget'] as Map<String, dynamic>),
  startsAt:
      json['startsAt'] == null
          ? null
          : DateTime.parse(json['startsAt'] as String),
  endsAt:
      json['endsAt'] == null ? null : DateTime.parse(json['endsAt'] as String),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UpdateCampaignRequestToJson(
  UpdateCampaignRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'currencyCode': instance.currencyCode,
  'status': _$CampaignStatusEnumMap[instance.status],
  'budget': instance.budget,
  'startsAt': instance.startsAt?.toIso8601String(),
  'endsAt': instance.endsAt?.toIso8601String(),
  'metadata': instance.metadata,
};
