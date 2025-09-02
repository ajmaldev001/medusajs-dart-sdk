import 'package:json_annotation/json_annotation.dart';

part 'promotion.g.dart';

/// Promotion types
enum PromotionType {
  @JsonValue('standard')
  standard,
  @JsonValue('buyget')
  buyget,
}

/// Application method for promotions
enum ApplicationMethod {
  @JsonValue('automatic')
  automatic,
  @JsonValue('code')
  code,
}

/// Promotion rule types
enum RuleType {
  @JsonValue('rules')
  rules,
  @JsonValue('target-rules')
  targetRules,
  @JsonValue('buy-rules')
  buyRules,
}

/// Promotion rule operators
enum RuleOperator {
  @JsonValue('gte')
  gte,
  @JsonValue('lte')
  lte,
  @JsonValue('gt')
  gt,
  @JsonValue('lt')
  lt,
  @JsonValue('eq')
  eq,
  @JsonValue('ne')
  ne,
  @JsonValue('in')
  inOperator,
  @JsonValue('nin')
  nin,
}

/// Promotion rule attributes
enum RuleAttribute {
  @JsonValue('customer_group_id')
  customerGroupId,
  @JsonValue('sales_channel_id')
  salesChannelId,
  @JsonValue('product_id')
  productId,
  @JsonValue('product_type_id')
  productTypeId,
  @JsonValue('product_collection_id')
  productCollectionId,
  @JsonValue('product_tag_id')
  productTagId,
  @JsonValue('customer_id')
  customerId,
  @JsonValue('currency_code')
  currencyCode,
}

/// Promotion rule model
@JsonSerializable(fieldRename: FieldRename.snake)
class PromotionRule {
  final String id;
  final String? description;
  final RuleAttribute attribute;
  final RuleOperator operator;
  final List<String> values;
  final String? promotionId;
  final RuleType? ruleType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const PromotionRule({
    required this.id,
    this.description,
    required this.attribute,
    required this.operator,
    required this.values,
    this.promotionId,
    this.ruleType,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory PromotionRule.fromJson(Map<String, dynamic> json) =>
      _$PromotionRuleFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionRuleToJson(this);
}

/// Campaign budget for promotions
@JsonSerializable(fieldRename: FieldRename.snake)
class CampaignBudget {
  final String id;
  final String type;
  final int? limit;
  final int used;
  final String? currencyCode;
  final String? campaignId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const CampaignBudget({
    required this.id,
    required this.type,
    this.limit,
    required this.used,
    this.currencyCode,
    this.campaignId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory CampaignBudget.fromJson(Map<String, dynamic> json) =>
      _$CampaignBudgetFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignBudgetToJson(this);
}

/// Promotion model for Medusa v2
@JsonSerializable(fieldRename: FieldRename.snake)
class Promotion {
  final String id;
  final String code;
  final String? campaignId;
  final bool isAutomatic;
  final PromotionType type;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final List<PromotionRule>? rules;
  final List<PromotionRule>? targetRules;
  final List<PromotionRule>? buyRules;
  final ApplicationMethod applicationMethod;
  final CampaignBudget? budget;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const Promotion({
    required this.id,
    required this.code,
    this.campaignId,
    required this.isAutomatic,
    required this.type,
    this.startsAt,
    this.endsAt,
    this.rules,
    this.targetRules,
    this.buyRules,
    required this.applicationMethod,
    this.budget,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionToJson(this);

  /// Check if promotion is currently active
  bool get isActive {
    final now = DateTime.now();
    if (startsAt != null && now.isBefore(startsAt!)) return false;
    if (endsAt != null && now.isAfter(endsAt!)) return false;
    return true;
  }

  /// Check if promotion is scheduled to start in the future
  bool get isScheduled {
    if (startsAt == null) return false;
    return DateTime.now().isBefore(startsAt!);
  }

  /// Check if promotion has expired
  bool get hasExpired {
    if (endsAt == null) return false;
    return DateTime.now().isAfter(endsAt!);
  }

  /// Check if budget is exhausted
  bool get isBudgetExhausted {
    if (budget?.limit == null) return false;
    return budget!.used >= budget!.limit!;
  }
}

/// Create promotion request
@JsonSerializable(fieldRename: FieldRename.snake)
class CreatePromotionRequest {
  final String code;
  final String? campaignId;
  final bool? isAutomatic;
  final PromotionType type;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final ApplicationMethod applicationMethod;
  final List<PromotionRule>? rules;
  final List<PromotionRule>? targetRules;
  final List<PromotionRule>? buyRules;
  final Map<String, dynamic>? metadata;

  const CreatePromotionRequest({
    required this.code,
    this.campaignId,
    this.isAutomatic,
    required this.type,
    this.startsAt,
    this.endsAt,
    required this.applicationMethod,
    this.rules,
    this.targetRules,
    this.buyRules,
    this.metadata,
  });

  factory CreatePromotionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePromotionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePromotionRequestToJson(this);
}

/// Update promotion request
@JsonSerializable(fieldRename: FieldRename.snake)
class UpdatePromotionRequest {
  final String? code;
  final bool? isAutomatic;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final List<PromotionRule>? rules;
  final List<PromotionRule>? targetRules;
  final List<PromotionRule>? buyRules;
  final Map<String, dynamic>? metadata;

  const UpdatePromotionRequest({
    this.code,
    this.isAutomatic,
    this.startsAt,
    this.endsAt,
    this.rules,
    this.targetRules,
    this.buyRules,
    this.metadata,
  });

  factory UpdatePromotionRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePromotionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePromotionRequestToJson(this);
}

/// Promotion response
@JsonSerializable(fieldRename: FieldRename.snake)
class PromotionResponse {
  final Promotion promotion;

  const PromotionResponse({required this.promotion});

  factory PromotionResponse.fromJson(Map<String, dynamic> json) =>
      _$PromotionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionResponseToJson(this);
}

/// Promotions response
@JsonSerializable(fieldRename: FieldRename.snake)
class PromotionsResponse {
  final List<Promotion> promotions;
  final int count;
  final int offset;
  final int limit;

  const PromotionsResponse({
    required this.promotions,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory PromotionsResponse.fromJson(Map<String, dynamic> json) =>
      _$PromotionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionsResponseToJson(this);
}
