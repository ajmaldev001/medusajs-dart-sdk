// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaxProvider _$TaxProviderFromJson(Map<String, dynamic> json) => TaxProvider(
  id: json['id'] as String,
  isInstalled: json['isInstalled'] as bool,
);

Map<String, dynamic> _$TaxProviderToJson(TaxProvider instance) =>
    <String, dynamic>{'id': instance.id, 'isInstalled': instance.isInstalled};

TaxRegion _$TaxRegionFromJson(Map<String, dynamic> json) => TaxRegion(
  id: json['id'] as String,
  countryCode: json['countryCode'] as String?,
  provinceCode: json['provinceCode'] as String?,
  parentId: json['parentId'] as String?,
  provider:
      json['provider'] == null
          ? null
          : TaxProvider.fromJson(json['provider'] as Map<String, dynamic>),
  providerId: json['providerId'] as String?,
  defaultTaxRate: (json['defaultTaxRate'] as num?)?.toDouble(),
  taxCalculationType: $enumDecodeNullable(
    _$TaxCalculationTypeEnumMap,
    json['taxCalculationType'],
  ),
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$TaxRegionToJson(TaxRegion instance) => <String, dynamic>{
  'id': instance.id,
  'countryCode': instance.countryCode,
  'provinceCode': instance.provinceCode,
  'parentId': instance.parentId,
  'provider': instance.provider,
  'providerId': instance.providerId,
  'defaultTaxRate': instance.defaultTaxRate,
  'taxCalculationType':
      _$TaxCalculationTypeEnumMap[instance.taxCalculationType],
  'metadata': instance.metadata,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
};

const _$TaxCalculationTypeEnumMap = {
  TaxCalculationType.inclusive: 'inclusive',
  TaxCalculationType.exclusive: 'exclusive',
};

TaxRate _$TaxRateFromJson(Map<String, dynamic> json) => TaxRate(
  id: json['id'] as String,
  rate: (json['rate'] as num?)?.toDouble(),
  code: json['code'] as String?,
  name: json['name'] as String,
  regionId: json['regionId'] as String?,
  region:
      json['region'] == null
          ? null
          : TaxRegion.fromJson(json['region'] as Map<String, dynamic>),
  isDefault: json['isDefault'] as bool,
  isCombinable: json['isCombinable'] as bool,
  type: $enumDecode(_$TaxRateTypeEnumMap, json['type']),
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$TaxRateToJson(TaxRate instance) => <String, dynamic>{
  'id': instance.id,
  'rate': instance.rate,
  'code': instance.code,
  'name': instance.name,
  'regionId': instance.regionId,
  'region': instance.region,
  'isDefault': instance.isDefault,
  'isCombinable': instance.isCombinable,
  'type': _$TaxRateTypeEnumMap[instance.type]!,
  'metadata': instance.metadata,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
};

const _$TaxRateTypeEnumMap = {
  TaxRateType.rate: 'rate',
  TaxRateType.flat: 'flat',
};

TaxLine _$TaxLineFromJson(Map<String, dynamic> json) => TaxLine(
  id: json['id'] as String,
  rate: (json['rate'] as num).toDouble(),
  name: json['name'] as String,
  code: json['code'] as String?,
  itemId: json['itemId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$TaxLineToJson(TaxLine instance) => <String, dynamic>{
  'id': instance.id,
  'rate': instance.rate,
  'name': instance.name,
  'code': instance.code,
  'itemId': instance.itemId,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

CreateTaxRegionRequest _$CreateTaxRegionRequestFromJson(
  Map<String, dynamic> json,
) => CreateTaxRegionRequest(
  countryCode: json['countryCode'] as String?,
  provinceCode: json['provinceCode'] as String?,
  parentId: json['parentId'] as String?,
  providerId: json['providerId'] as String?,
  defaultTaxRate: (json['defaultTaxRate'] as num?)?.toDouble(),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateTaxRegionRequestToJson(
  CreateTaxRegionRequest instance,
) => <String, dynamic>{
  'countryCode': instance.countryCode,
  'provinceCode': instance.provinceCode,
  'parentId': instance.parentId,
  'providerId': instance.providerId,
  'defaultTaxRate': instance.defaultTaxRate,
  'metadata': instance.metadata,
};

UpdateTaxRegionRequest _$UpdateTaxRegionRequestFromJson(
  Map<String, dynamic> json,
) => UpdateTaxRegionRequest(
  providerId: json['providerId'] as String?,
  defaultTaxRate: (json['defaultTaxRate'] as num?)?.toDouble(),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UpdateTaxRegionRequestToJson(
  UpdateTaxRegionRequest instance,
) => <String, dynamic>{
  'providerId': instance.providerId,
  'defaultTaxRate': instance.defaultTaxRate,
  'metadata': instance.metadata,
};

CreateTaxRateRequest _$CreateTaxRateRequestFromJson(
  Map<String, dynamic> json,
) => CreateTaxRateRequest(
  rate: (json['rate'] as num?)?.toDouble(),
  code: json['code'] as String?,
  name: json['name'] as String,
  regionId: json['regionId'] as String?,
  isDefault: json['isDefault'] as bool?,
  isCombinable: json['isCombinable'] as bool?,
  type: $enumDecode(_$TaxRateTypeEnumMap, json['type']),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreateTaxRateRequestToJson(
  CreateTaxRateRequest instance,
) => <String, dynamic>{
  'rate': instance.rate,
  'code': instance.code,
  'name': instance.name,
  'regionId': instance.regionId,
  'isDefault': instance.isDefault,
  'isCombinable': instance.isCombinable,
  'type': _$TaxRateTypeEnumMap[instance.type]!,
  'metadata': instance.metadata,
};

UpdateTaxRateRequest _$UpdateTaxRateRequestFromJson(
  Map<String, dynamic> json,
) => UpdateTaxRateRequest(
  rate: (json['rate'] as num?)?.toDouble(),
  code: json['code'] as String?,
  name: json['name'] as String?,
  isDefault: json['isDefault'] as bool?,
  isCombinable: json['isCombinable'] as bool?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UpdateTaxRateRequestToJson(
  UpdateTaxRateRequest instance,
) => <String, dynamic>{
  'rate': instance.rate,
  'code': instance.code,
  'name': instance.name,
  'isDefault': instance.isDefault,
  'isCombinable': instance.isCombinable,
  'metadata': instance.metadata,
};

TaxRegionResponse _$TaxRegionResponseFromJson(Map<String, dynamic> json) =>
    TaxRegionResponse(
      taxRegion: TaxRegion.fromJson(json['taxRegion'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TaxRegionResponseToJson(TaxRegionResponse instance) =>
    <String, dynamic>{'taxRegion': instance.taxRegion};

TaxRegionsResponse _$TaxRegionsResponseFromJson(Map<String, dynamic> json) =>
    TaxRegionsResponse(
      taxRegions:
          (json['taxRegions'] as List<dynamic>)
              .map((e) => TaxRegion.fromJson(e as Map<String, dynamic>))
              .toList(),
      count: (json['count'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$TaxRegionsResponseToJson(TaxRegionsResponse instance) =>
    <String, dynamic>{
      'taxRegions': instance.taxRegions,
      'count': instance.count,
      'offset': instance.offset,
      'limit': instance.limit,
    };

TaxRateResponse _$TaxRateResponseFromJson(Map<String, dynamic> json) =>
    TaxRateResponse(
      taxRate: TaxRate.fromJson(json['taxRate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TaxRateResponseToJson(TaxRateResponse instance) =>
    <String, dynamic>{'taxRate': instance.taxRate};

TaxRatesResponse _$TaxRatesResponseFromJson(Map<String, dynamic> json) =>
    TaxRatesResponse(
      taxRates:
          (json['taxRates'] as List<dynamic>)
              .map((e) => TaxRate.fromJson(e as Map<String, dynamic>))
              .toList(),
      count: (json['count'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$TaxRatesResponseToJson(TaxRatesResponse instance) =>
    <String, dynamic>{
      'taxRates': instance.taxRates,
      'count': instance.count,
      'offset': instance.offset,
      'limit': instance.limit,
    };

TaxProvidersResponse _$TaxProvidersResponseFromJson(
  Map<String, dynamic> json,
) => TaxProvidersResponse(
  taxProviders:
      (json['taxProviders'] as List<dynamic>)
          .map((e) => TaxProvider.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TaxProvidersResponseToJson(
  TaxProvidersResponse instance,
) => <String, dynamic>{'taxProviders': instance.taxProviders};
