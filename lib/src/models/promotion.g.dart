// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionRule _$PromotionRuleFromJson(Map<String, dynamic> json) =>
    PromotionRule(
      id: json['id'] as String,
      description: json['description'] as String?,
      attribute: $enumDecode(_$RuleAttributeEnumMap, json['attribute']),
      operator: $enumDecode(_$RuleOperatorEnumMap, json['operator']),
      values:
          (json['values'] as List<dynamic>).map((e) => e as String).toList(),
      promotionId: json['promotionId'] as String?,
      ruleType: $enumDecodeNullable(_$RuleTypeEnumMap, json['ruleType']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt:
          json['deletedAt'] == null
              ? null
              : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$PromotionRuleToJson(PromotionRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'attribute': _$RuleAttributeEnumMap[instance.attribute]!,
      'operator': _$RuleOperatorEnumMap[instance.operator]!,
      'values': instance.values,
      'promotionId': instance.promotionId,
      'ruleType': _$RuleTypeEnumMap[instance.ruleType],
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

const _$RuleAttributeEnumMap = {
  RuleAttribute.customerGroupId: 'customer_group_id',
  RuleAttribute.salesChannelId: 'sales_channel_id',
  RuleAttribute.productId: 'product_id',
  RuleAttribute.productTypeId: 'product_type_id',
  RuleAttribute.productCollectionId: 'product_collection_id',
  RuleAttribute.productTagId: 'product_tag_id',
  RuleAttribute.customerId: 'customer_id',
  RuleAttribute.currencyCode: 'currency_code',
};

const _$RuleOperatorEnumMap = {
  RuleOperator.gte: 'gte',
  RuleOperator.lte: 'lte',
  RuleOperator.gt: 'gt',
  RuleOperator.lt: 'lt',
  RuleOperator.eq: 'eq',
  RuleOperator.ne: 'ne',
  RuleOperator.inOperator: 'in',
  RuleOperator.nin: 'nin',
};

const _$RuleTypeEnumMap = {
  RuleType.rules: 'rules',
  RuleType.targetRules: 'target-rules',
  RuleType.buyRules: 'buy-rules',
};

CampaignBudget _$CampaignBudgetFromJson(Map<String, dynamic> json) =>
    CampaignBudget(
      id: json['id'] as String,
      type: json['type'] as String,
      limit: (json['limit'] as num?)?.toInt(),
      used: (json['used'] as num).toInt(),
      currencyCode: json['currencyCode'] as String?,
      campaignId: json['campaignId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt:
          json['deletedAt'] == null
              ? null
              : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$CampaignBudgetToJson(CampaignBudget instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'limit': instance.limit,
      'used': instance.used,
      'currencyCode': instance.currencyCode,
      'campaignId': instance.campaignId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

Promotion _$PromotionFromJson(Map<String, dynamic> json) => Promotion(
  id: json['id'] as String,
  code: json['code'] as String,
  campaignId: json['campaignId'] as String?,
  isAutomatic: json['isAutomatic'] as bool,
  type: $enumDecode(_$PromotionTypeEnumMap, json['type']),
  startsAt:
      json['startsAt'] == null
          ? null
          : DateTime.parse(json['startsAt'] as String),
  endsAt:
      json['endsAt'] == null ? null : DateTime.parse(json['endsAt'] as String),
  rules:
      (json['rules'] as List<dynamic>?)
          ?.map((e) => PromotionRule.fromJson(e as Map<String, dynamic>))
          .toList(),
  targetRules:
      (json['targetRules'] as List<dynamic>?)
          ?.map((e) => PromotionRule.fromJson(e as Map<String, dynamic>))
          .toList(),
  buyRules:
      (json['buyRules'] as List<dynamic>?)
          ?.map((e) => PromotionRule.fromJson(e as Map<String, dynamic>))
          .toList(),
  applicationMethod: $enumDecode(
    _$ApplicationMethodEnumMap,
    json['applicationMethod'],
  ),
  budget:
      json['budget'] == null
          ? null
          : CampaignBudget.fromJson(json['budget'] as Map<String, dynamic>),
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'campaignId': instance.campaignId,
  'isAutomatic': instance.isAutomatic,
  'type': _$PromotionTypeEnumMap[instance.type]!,
  'startsAt': instance.startsAt?.toIso8601String(),
  'endsAt': instance.endsAt?.toIso8601String(),
  'rules': instance.rules,
  'targetRules': instance.targetRules,
  'buyRules': instance.buyRules,
  'applicationMethod': _$ApplicationMethodEnumMap[instance.applicationMethod]!,
  'budget': instance.budget,
  'metadata': instance.metadata,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
};

const _$PromotionTypeEnumMap = {
  PromotionType.standard: 'standard',
  PromotionType.buyget: 'buyget',
};

const _$ApplicationMethodEnumMap = {
  ApplicationMethod.automatic: 'automatic',
  ApplicationMethod.code: 'code',
};

CreatePromotionRequest _$CreatePromotionRequestFromJson(
  Map<String, dynamic> json,
) => CreatePromotionRequest(
  code: json['code'] as String,
  campaignId: json['campaignId'] as String?,
  isAutomatic: json['isAutomatic'] as bool?,
  type: $enumDecode(_$PromotionTypeEnumMap, json['type']),
  startsAt:
      json['startsAt'] == null
          ? null
          : DateTime.parse(json['startsAt'] as String),
  endsAt:
      json['endsAt'] == null ? null : DateTime.parse(json['endsAt'] as String),
  applicationMethod: $enumDecode(
    _$ApplicationMethodEnumMap,
    json['applicationMethod'],
  ),
  rules:
      (json['rules'] as List<dynamic>?)
          ?.map((e) => PromotionRule.fromJson(e as Map<String, dynamic>))
          .toList(),
  targetRules:
      (json['targetRules'] as List<dynamic>?)
          ?.map((e) => PromotionRule.fromJson(e as Map<String, dynamic>))
          .toList(),
  buyRules:
      (json['buyRules'] as List<dynamic>?)
          ?.map((e) => PromotionRule.fromJson(e as Map<String, dynamic>))
          .toList(),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreatePromotionRequestToJson(
  CreatePromotionRequest instance,
) => <String, dynamic>{
  'code': instance.code,
  'campaignId': instance.campaignId,
  'isAutomatic': instance.isAutomatic,
  'type': _$PromotionTypeEnumMap[instance.type]!,
  'startsAt': instance.startsAt?.toIso8601String(),
  'endsAt': instance.endsAt?.toIso8601String(),
  'applicationMethod': _$ApplicationMethodEnumMap[instance.applicationMethod]!,
  'rules': instance.rules,
  'targetRules': instance.targetRules,
  'buyRules': instance.buyRules,
  'metadata': instance.metadata,
};

UpdatePromotionRequest _$UpdatePromotionRequestFromJson(
  Map<String, dynamic> json,
) => UpdatePromotionRequest(
  code: json['code'] as String?,
  isAutomatic: json['isAutomatic'] as bool?,
  startsAt:
      json['startsAt'] == null
          ? null
          : DateTime.parse(json['startsAt'] as String),
  endsAt:
      json['endsAt'] == null ? null : DateTime.parse(json['endsAt'] as String),
  rules:
      (json['rules'] as List<dynamic>?)
          ?.map((e) => PromotionRule.fromJson(e as Map<String, dynamic>))
          .toList(),
  targetRules:
      (json['targetRules'] as List<dynamic>?)
          ?.map((e) => PromotionRule.fromJson(e as Map<String, dynamic>))
          .toList(),
  buyRules:
      (json['buyRules'] as List<dynamic>?)
          ?.map((e) => PromotionRule.fromJson(e as Map<String, dynamic>))
          .toList(),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UpdatePromotionRequestToJson(
  UpdatePromotionRequest instance,
) => <String, dynamic>{
  'code': instance.code,
  'isAutomatic': instance.isAutomatic,
  'startsAt': instance.startsAt?.toIso8601String(),
  'endsAt': instance.endsAt?.toIso8601String(),
  'rules': instance.rules,
  'targetRules': instance.targetRules,
  'buyRules': instance.buyRules,
  'metadata': instance.metadata,
};

PromotionResponse _$PromotionResponseFromJson(Map<String, dynamic> json) =>
    PromotionResponse(
      promotion: Promotion.fromJson(json['promotion'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PromotionResponseToJson(PromotionResponse instance) =>
    <String, dynamic>{'promotion': instance.promotion};

PromotionsResponse _$PromotionsResponseFromJson(Map<String, dynamic> json) =>
    PromotionsResponse(
      promotions:
          (json['promotions'] as List<dynamic>)
              .map((e) => Promotion.fromJson(e as Map<String, dynamic>))
              .toList(),
      count: (json['count'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$PromotionsResponseToJson(PromotionsResponse instance) =>
    <String, dynamic>{
      'promotions': instance.promotions,
      'count': instance.count,
      'offset': instance.offset,
      'limit': instance.limit,
    };
