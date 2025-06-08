import 'package:json_annotation/json_annotation.dart';

part 'price_list.g.dart';

/// Price list types
enum PriceListType {
  @JsonValue('sale')
  sale,
  @JsonValue('override')
  override,
}

/// Price list status
enum PriceListStatus {
  @JsonValue('active')
  active,
  @JsonValue('draft')
  draft,
}

/// Money amount for price list entries
@JsonSerializable()
class MoneyAmount {
  final String id;
  final String currencyCode;
  final int amount;
  final int? minQuantity;
  final int? maxQuantity;
  final String? priceListId;
  final String? variantId;
  final String? regionId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const MoneyAmount({
    required this.id,
    required this.currencyCode,
    required this.amount,
    this.minQuantity,
    this.maxQuantity,
    this.priceListId,
    this.variantId,
    this.regionId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory MoneyAmount.fromJson(Map<String, dynamic> json) =>
      _$MoneyAmountFromJson(json);

  Map<String, dynamic> toJson() => _$MoneyAmountToJson(this);
}

/// Customer group for price list targeting
@JsonSerializable()
class CustomerGroup {
  final String id;
  final String name;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const CustomerGroup({
    required this.id,
    required this.name,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory CustomerGroup.fromJson(Map<String, dynamic> json) =>
      _$CustomerGroupFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerGroupToJson(this);
}

/// Price list model for Medusa v2
@JsonSerializable()
class PriceList {
  final String id;
  final String name;
  final String? description;
  final PriceListType type;
  final PriceListStatus status;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final List<MoneyAmount>? prices;
  final List<CustomerGroup>? customerGroups;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const PriceList({
    required this.id,
    required this.name,
    this.description,
    required this.type,
    required this.status,
    this.startsAt,
    this.endsAt,
    this.prices,
    this.customerGroups,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory PriceList.fromJson(Map<String, dynamic> json) =>
      _$PriceListFromJson(json);

  Map<String, dynamic> toJson() => _$PriceListToJson(this);

  /// Check if price list is currently active
  bool get isActive {
    if (status != PriceListStatus.active) return false;

    final now = DateTime.now();
    if (startsAt != null && now.isBefore(startsAt!)) return false;
    if (endsAt != null && now.isAfter(endsAt!)) return false;

    return true;
  }

  /// Check if price list is scheduled to start in the future
  bool get isScheduled {
    if (startsAt == null) return false;
    return DateTime.now().isBefore(startsAt!);
  }

  /// Check if price list has expired
  bool get hasExpired {
    if (endsAt == null) return false;
    return DateTime.now().isAfter(endsAt!);
  }
}

/// Create price list request
@JsonSerializable()
class CreatePriceListRequest {
  final String name;
  final String? description;
  final PriceListType type;
  final PriceListStatus? status;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final List<String>? customerGroupIds;
  final Map<String, dynamic>? metadata;

  const CreatePriceListRequest({
    required this.name,
    this.description,
    required this.type,
    this.status,
    this.startsAt,
    this.endsAt,
    this.customerGroupIds,
    this.metadata,
  });

  factory CreatePriceListRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePriceListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePriceListRequestToJson(this);
}

/// Update price list request
@JsonSerializable()
class UpdatePriceListRequest {
  final String? name;
  final String? description;
  final PriceListStatus? status;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final List<String>? customerGroupIds;
  final Map<String, dynamic>? metadata;

  const UpdatePriceListRequest({
    this.name,
    this.description,
    this.status,
    this.startsAt,
    this.endsAt,
    this.customerGroupIds,
    this.metadata,
  });

  factory UpdatePriceListRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePriceListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePriceListRequestToJson(this);
}

/// Price list response
@JsonSerializable()
class PriceListResponse {
  final PriceList priceList;

  const PriceListResponse({required this.priceList});

  factory PriceListResponse.fromJson(Map<String, dynamic> json) =>
      _$PriceListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PriceListResponseToJson(this);
}

/// Price lists response
@JsonSerializable()
class PriceListsResponse {
  final List<PriceList> priceLists;
  final int count;
  final int offset;
  final int limit;

  const PriceListsResponse({
    required this.priceLists,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory PriceListsResponse.fromJson(Map<String, dynamic> json) =>
      _$PriceListsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PriceListsResponseToJson(this);
}
