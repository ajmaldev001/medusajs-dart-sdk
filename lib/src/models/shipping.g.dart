// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingOption _$ShippingOptionFromJson(Map<String, dynamic> json) =>
    ShippingOption(
      id: json['id'] as String,
      name: json['name'] as String,
      regionId: json['regionId'] as String,
      profileId: json['profileId'] as String,
      providerId: json['providerId'] as String,
      priceType: $enumDecode(_$PriceTypeEnumMap, json['priceType']),
      amount: (json['amount'] as num?)?.toInt(),
      isReturn: json['isReturn'] as bool,
      adminOnly: json['adminOnly'] as bool?,
      requirements:
          (json['requirements'] as List<dynamic>?)
              ?.map(
                (e) => ShippingOptionRequirement.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
      data: json['data'] as Map<String, dynamic>?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
      deletedAt:
          json['deletedAt'] == null
              ? null
              : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$ShippingOptionToJson(ShippingOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'regionId': instance.regionId,
      'profileId': instance.profileId,
      'providerId': instance.providerId,
      'priceType': _$PriceTypeEnumMap[instance.priceType]!,
      'amount': instance.amount,
      'isReturn': instance.isReturn,
      'adminOnly': instance.adminOnly,
      'requirements': instance.requirements,
      'data': instance.data,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

const _$PriceTypeEnumMap = {
  PriceType.flatRate: 'flat_rate',
  PriceType.calculated: 'calculated',
};

ShippingOptionRequirement _$ShippingOptionRequirementFromJson(
  Map<String, dynamic> json,
) => ShippingOptionRequirement(
  id: json['id'] as String,
  shippingOptionId: json['shippingOptionId'] as String,
  type: $enumDecode(_$RequirementTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toInt(),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$ShippingOptionRequirementToJson(
  ShippingOptionRequirement instance,
) => <String, dynamic>{
  'id': instance.id,
  'shippingOptionId': instance.shippingOptionId,
  'type': _$RequirementTypeEnumMap[instance.type]!,
  'amount': instance.amount,
  'deletedAt': instance.deletedAt?.toIso8601String(),
};

const _$RequirementTypeEnumMap = {
  RequirementType.minSubtotal: 'min_subtotal',
  RequirementType.maxSubtotal: 'max_subtotal',
};

ShippingMethod _$ShippingMethodFromJson(Map<String, dynamic> json) =>
    ShippingMethod(
      id: json['id'] as String,
      shippingOptionId: json['shippingOptionId'] as String,
      cartId: json['cartId'] as String?,
      orderId: json['orderId'] as String?,
      swapId: json['swapId'] as String?,
      returnId: json['returnId'] as String?,
      claimId: json['claimId'] as String?,
      price: (json['price'] as num).toInt(),
      data: json['data'] as Map<String, dynamic>?,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ShippingMethodToJson(ShippingMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shippingOptionId': instance.shippingOptionId,
      'cartId': instance.cartId,
      'orderId': instance.orderId,
      'swapId': instance.swapId,
      'returnId': instance.returnId,
      'claimId': instance.claimId,
      'price': instance.price,
      'data': instance.data,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
