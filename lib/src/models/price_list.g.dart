// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoneyAmount _$MoneyAmountFromJson(Map<String, dynamic> json) => MoneyAmount(
  id: json['id'] as String,
  currencyCode: json['currencyCode'] as String,
  amount: (json['amount'] as num).toInt(),
  minQuantity: (json['minQuantity'] as num?)?.toInt(),
  maxQuantity: (json['maxQuantity'] as num?)?.toInt(),
  priceListId: json['priceListId'] as String?,
  variantId: json['variantId'] as String?,
  regionId: json['regionId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$MoneyAmountToJson(MoneyAmount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currencyCode': instance.currencyCode,
      'amount': instance.amount,
      'minQuantity': instance.minQuantity,
      'maxQuantity': instance.maxQuantity,
      'priceListId': instance.priceListId,
      'variantId': instance.variantId,
      'regionId': instance.regionId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

CustomerGroup _$CustomerGroupFromJson(Map<String, dynamic> json) =>
    CustomerGroup(
      id: json['id'] as String,
      name: json['name'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt:
          json['deletedAt'] == null
              ? null
              : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$CustomerGroupToJson(CustomerGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

PriceList _$PriceListFromJson(Map<String, dynamic> json) => PriceList(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  type: $enumDecode(_$PriceListTypeEnumMap, json['type']),
  status: $enumDecode(_$PriceListStatusEnumMap, json['status']),
  startsAt:
      json['startsAt'] == null
          ? null
          : DateTime.parse(json['startsAt'] as String),
  endsAt:
      json['endsAt'] == null ? null : DateTime.parse(json['endsAt'] as String),
  prices:
      (json['prices'] as List<dynamic>?)
          ?.map((e) => MoneyAmount.fromJson(e as Map<String, dynamic>))
          .toList(),
  customerGroups:
      (json['customerGroups'] as List<dynamic>?)
          ?.map((e) => CustomerGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$PriceListToJson(PriceList instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'type': _$PriceListTypeEnumMap[instance.type]!,
  'status': _$PriceListStatusEnumMap[instance.status]!,
  'startsAt': instance.startsAt?.toIso8601String(),
  'endsAt': instance.endsAt?.toIso8601String(),
  'prices': instance.prices,
  'customerGroups': instance.customerGroups,
  'metadata': instance.metadata,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
};

const _$PriceListTypeEnumMap = {
  PriceListType.sale: 'sale',
  PriceListType.override: 'override',
};

const _$PriceListStatusEnumMap = {
  PriceListStatus.active: 'active',
  PriceListStatus.draft: 'draft',
};

CreatePriceListRequest _$CreatePriceListRequestFromJson(
  Map<String, dynamic> json,
) => CreatePriceListRequest(
  name: json['name'] as String,
  description: json['description'] as String?,
  type: $enumDecode(_$PriceListTypeEnumMap, json['type']),
  status: $enumDecodeNullable(_$PriceListStatusEnumMap, json['status']),
  startsAt:
      json['startsAt'] == null
          ? null
          : DateTime.parse(json['startsAt'] as String),
  endsAt:
      json['endsAt'] == null ? null : DateTime.parse(json['endsAt'] as String),
  customerGroupIds:
      (json['customerGroupIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CreatePriceListRequestToJson(
  CreatePriceListRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'type': _$PriceListTypeEnumMap[instance.type]!,
  'status': _$PriceListStatusEnumMap[instance.status],
  'startsAt': instance.startsAt?.toIso8601String(),
  'endsAt': instance.endsAt?.toIso8601String(),
  'customerGroupIds': instance.customerGroupIds,
  'metadata': instance.metadata,
};

UpdatePriceListRequest _$UpdatePriceListRequestFromJson(
  Map<String, dynamic> json,
) => UpdatePriceListRequest(
  name: json['name'] as String?,
  description: json['description'] as String?,
  status: $enumDecodeNullable(_$PriceListStatusEnumMap, json['status']),
  startsAt:
      json['startsAt'] == null
          ? null
          : DateTime.parse(json['startsAt'] as String),
  endsAt:
      json['endsAt'] == null ? null : DateTime.parse(json['endsAt'] as String),
  customerGroupIds:
      (json['customerGroupIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UpdatePriceListRequestToJson(
  UpdatePriceListRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'status': _$PriceListStatusEnumMap[instance.status],
  'startsAt': instance.startsAt?.toIso8601String(),
  'endsAt': instance.endsAt?.toIso8601String(),
  'customerGroupIds': instance.customerGroupIds,
  'metadata': instance.metadata,
};

PriceListResponse _$PriceListResponseFromJson(Map<String, dynamic> json) =>
    PriceListResponse(
      priceList: PriceList.fromJson(json['priceList'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PriceListResponseToJson(PriceListResponse instance) =>
    <String, dynamic>{'priceList': instance.priceList};

PriceListsResponse _$PriceListsResponseFromJson(Map<String, dynamic> json) =>
    PriceListsResponse(
      priceLists:
          (json['priceLists'] as List<dynamic>)
              .map((e) => PriceList.fromJson(e as Map<String, dynamic>))
              .toList(),
      count: (json['count'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$PriceListsResponseToJson(PriceListsResponse instance) =>
    <String, dynamic>{
      'priceLists': instance.priceLists,
      'count': instance.count,
      'offset': instance.offset,
      'limit': instance.limit,
    };
