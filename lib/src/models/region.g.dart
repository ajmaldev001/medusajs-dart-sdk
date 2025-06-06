// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
  id: json['id'] as String,
  name: json['name'] as String,
  currencyCode: json['currencyCode'] as String,
  taxRate: (json['taxRate'] as num).toDouble(),
  taxCode: json['taxCode'] as String?,
  countries:
      (json['countries'] as List<dynamic>?)
          ?.map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
  paymentProviders:
      (json['paymentProviders'] as List<dynamic>?)
          ?.map((e) => PaymentProvider.fromJson(e as Map<String, dynamic>))
          .toList(),
  fulfillmentProviders:
      (json['fulfillmentProviders'] as List<dynamic>?)
          ?.map((e) => FulfillmentProvider.fromJson(e as Map<String, dynamic>))
          .toList(),
  includesTax: json['includesTax'] as bool?,
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
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'currencyCode': instance.currencyCode,
  'taxRate': instance.taxRate,
  'taxCode': instance.taxCode,
  'countries': instance.countries,
  'paymentProviders': instance.paymentProviders,
  'fulfillmentProviders': instance.fulfillmentProviders,
  'includesTax': instance.includesTax,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
  'metadata': instance.metadata,
};

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
  iso2: json['iso2'] as String,
  iso3: json['iso3'] as String,
  numCode: (json['numCode'] as num).toInt(),
  name: json['name'] as String,
  displayName: json['displayName'] as String,
  regionId: json['regionId'] as String?,
);

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
  'iso2': instance.iso2,
  'iso3': instance.iso3,
  'numCode': instance.numCode,
  'name': instance.name,
  'displayName': instance.displayName,
  'regionId': instance.regionId,
};

PaymentProvider _$PaymentProviderFromJson(Map<String, dynamic> json) =>
    PaymentProvider(
      id: json['id'] as String,
      isInstalled: json['isInstalled'] as bool,
    );

Map<String, dynamic> _$PaymentProviderToJson(PaymentProvider instance) =>
    <String, dynamic>{'id': instance.id, 'isInstalled': instance.isInstalled};

FulfillmentProvider _$FulfillmentProviderFromJson(Map<String, dynamic> json) =>
    FulfillmentProvider(
      id: json['id'] as String,
      isInstalled: json['isInstalled'] as bool,
    );

Map<String, dynamic> _$FulfillmentProviderToJson(
  FulfillmentProvider instance,
) => <String, dynamic>{'id': instance.id, 'isInstalled': instance.isInstalled};
