// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fulfillment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fulfillment _$FulfillmentFromJson(Map<String, dynamic> json) => Fulfillment(
  id: json['id'] as String,
  locationId: json['locationId'] as String?,
  packedAt: json['packedAt'] as bool? ?? false,
  shippedAt: json['shippedAt'] as bool? ?? false,
  deliveredAt: json['deliveredAt'] as bool? ?? false,
  canceledAt: json['canceledAt'] as bool? ?? false,
  data: json['data'] as Map<String, dynamic>?,
  providerId: json['providerId'] as String,
  shippingOptionId: json['shippingOptionId'] as String,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$FulfillmentToJson(Fulfillment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'locationId': instance.locationId,
      'packedAt': instance.packedAt,
      'shippedAt': instance.shippedAt,
      'deliveredAt': instance.deliveredAt,
      'canceledAt': instance.canceledAt,
      'data': instance.data,
      'providerId': instance.providerId,
      'shippingOptionId': instance.shippingOptionId,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

ShippingOption _$ShippingOptionFromJson(Map<String, dynamic> json) =>
    ShippingOption(
      id: json['id'] as String,
      name: json['name'] as String,
      priceType: json['priceType'] as String,
      serviceZoneId: json['serviceZoneId'] as String?,
      shippingProfileId: json['shippingProfileId'] as String?,
      providerId: json['providerId'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt:
          json['deletedAt'] == null
              ? null
              : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$ShippingOptionToJson(ShippingOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'priceType': instance.priceType,
      'serviceZoneId': instance.serviceZoneId,
      'shippingProfileId': instance.shippingProfileId,
      'providerId': instance.providerId,
      'data': instance.data,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

ShippingProfile _$ShippingProfileFromJson(Map<String, dynamic> json) =>
    ShippingProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt:
          json['deletedAt'] == null
              ? null
              : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$ShippingProfileToJson(ShippingProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };
