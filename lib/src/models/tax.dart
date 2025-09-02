import 'package:json_annotation/json_annotation.dart';

part 'tax.g.dart';

/// Tax calculation types
enum TaxCalculationType {
  @JsonValue('inclusive')
  inclusive,
  @JsonValue('exclusive')
  exclusive,
}

/// Tax rate type
enum TaxRateType {
  @JsonValue('rate')
  rate,
  @JsonValue('flat')
  flat,
}

/// Tax provider model
@JsonSerializable(fieldRename: FieldRename.snake)
class TaxProvider {
  final String id;
  final bool isInstalled;

  const TaxProvider({required this.id, required this.isInstalled});

  factory TaxProvider.fromJson(Map<String, dynamic> json) =>
      _$TaxProviderFromJson(json);

  Map<String, dynamic> toJson() => _$TaxProviderToJson(this);
}

/// Tax region model
@JsonSerializable(fieldRename: FieldRename.snake)
class TaxRegion {
  final String id;
  final String? countryCode;
  final String? provinceCode;
  final String? parentId;
  final TaxProvider? provider;
  final String? providerId;
  final double? defaultTaxRate;
  final TaxCalculationType? taxCalculationType;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const TaxRegion({
    required this.id,
    this.countryCode,
    this.provinceCode,
    this.parentId,
    this.provider,
    this.providerId,
    this.defaultTaxRate,
    this.taxCalculationType,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory TaxRegion.fromJson(Map<String, dynamic> json) =>
      _$TaxRegionFromJson(json);

  Map<String, dynamic> toJson() => _$TaxRegionToJson(this);

  /// Check if this is a country-level tax region
  bool get isCountryLevel => countryCode != null && provinceCode == null;

  /// Check if this is a province/state-level tax region
  bool get isProvinceLevel => provinceCode != null;

  /// Get display name for the tax region
  String get displayName {
    if (isProvinceLevel) {
      return '$provinceCode, $countryCode';
    }
    return countryCode ?? 'Unknown Region';
  }
}

/// Tax rate model
@JsonSerializable(fieldRename: FieldRename.snake)
class TaxRate {
  final String id;
  final double? rate;
  final String? code;
  final String name;
  final String? regionId;
  final TaxRegion? region;
  final bool isDefault;
  final bool isCombinable;
  final TaxRateType type;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const TaxRate({
    required this.id,
    this.rate,
    this.code,
    required this.name,
    this.regionId,
    this.region,
    required this.isDefault,
    required this.isCombinable,
    required this.type,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory TaxRate.fromJson(Map<String, dynamic> json) =>
      _$TaxRateFromJson(json);

  Map<String, dynamic> toJson() => _$TaxRateToJson(this);

  /// Get rate as percentage
  double get rateAsPercentage => (rate ?? 0) * 100;

  /// Check if this is a percentage-based rate
  bool get isPercentageRate => type == TaxRateType.rate;

  /// Check if this is a flat rate
  bool get isFlatRate => type == TaxRateType.flat;

  /// Calculate tax amount for a given amount
  double calculateTax(double amount) {
    if (rate == null) return 0;

    if (isPercentageRate) {
      return amount * rate!;
    } else {
      // Flat rate
      return rate!;
    }
  }
}

/// Tax line model
@JsonSerializable(fieldRename: FieldRename.snake)
class TaxLine {
  final String id;
  final double rate;
  final String name;
  final String? code;
  final String? itemId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TaxLine({
    required this.id,
    required this.rate,
    required this.name,
    this.code,
    this.itemId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaxLine.fromJson(Map<String, dynamic> json) =>
      _$TaxLineFromJson(json);

  Map<String, dynamic> toJson() => _$TaxLineToJson(this);

  /// Get rate as percentage
  double get rateAsPercentage => rate * 100;
}

/// Create tax region request
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateTaxRegionRequest {
  final String? countryCode;
  final String? provinceCode;
  final String? parentId;
  final String? providerId;
  final double? defaultTaxRate;
  final Map<String, dynamic>? metadata;

  const CreateTaxRegionRequest({
    this.countryCode,
    this.provinceCode,
    this.parentId,
    this.providerId,
    this.defaultTaxRate,
    this.metadata,
  });

  factory CreateTaxRegionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateTaxRegionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTaxRegionRequestToJson(this);
}

/// Update tax region request
@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateTaxRegionRequest {
  final String? providerId;
  final double? defaultTaxRate;
  final Map<String, dynamic>? metadata;

  const UpdateTaxRegionRequest({
    this.providerId,
    this.defaultTaxRate,
    this.metadata,
  });

  factory UpdateTaxRegionRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateTaxRegionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTaxRegionRequestToJson(this);
}

/// Create tax rate request
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateTaxRateRequest {
  final double? rate;
  final String? code;
  final String name;
  final String? regionId;
  final bool? isDefault;
  final bool? isCombinable;
  final TaxRateType type;
  final Map<String, dynamic>? metadata;

  const CreateTaxRateRequest({
    this.rate,
    this.code,
    required this.name,
    this.regionId,
    this.isDefault,
    this.isCombinable,
    required this.type,
    this.metadata,
  });

  factory CreateTaxRateRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateTaxRateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTaxRateRequestToJson(this);
}

/// Update tax rate request
@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateTaxRateRequest {
  final double? rate;
  final String? code;
  final String? name;
  final bool? isDefault;
  final bool? isCombinable;
  final Map<String, dynamic>? metadata;

  const UpdateTaxRateRequest({
    this.rate,
    this.code,
    this.name,
    this.isDefault,
    this.isCombinable,
    this.metadata,
  });

  factory UpdateTaxRateRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateTaxRateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTaxRateRequestToJson(this);
}

/// Tax region response
@JsonSerializable(fieldRename: FieldRename.snake)
class TaxRegionResponse {
  final TaxRegion taxRegion;

  const TaxRegionResponse({required this.taxRegion});

  factory TaxRegionResponse.fromJson(Map<String, dynamic> json) =>
      _$TaxRegionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaxRegionResponseToJson(this);
}

/// Tax regions response
@JsonSerializable(fieldRename: FieldRename.snake)
class TaxRegionsResponse {
  final List<TaxRegion> taxRegions;
  final int count;
  final int offset;
  final int limit;

  const TaxRegionsResponse({
    required this.taxRegions,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory TaxRegionsResponse.fromJson(Map<String, dynamic> json) =>
      _$TaxRegionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaxRegionsResponseToJson(this);
}

/// Tax rate response
@JsonSerializable(fieldRename: FieldRename.snake)
class TaxRateResponse {
  final TaxRate taxRate;

  const TaxRateResponse({required this.taxRate});

  factory TaxRateResponse.fromJson(Map<String, dynamic> json) =>
      _$TaxRateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaxRateResponseToJson(this);
}

/// Tax rates response
@JsonSerializable(fieldRename: FieldRename.snake)
class TaxRatesResponse {
  final List<TaxRate> taxRates;
  final int count;
  final int offset;
  final int limit;

  const TaxRatesResponse({
    required this.taxRates,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory TaxRatesResponse.fromJson(Map<String, dynamic> json) =>
      _$TaxRatesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaxRatesResponseToJson(this);
}

/// Tax providers response
@JsonSerializable(fieldRename: FieldRename.snake)
class TaxProvidersResponse {
  final List<TaxProvider> taxProviders;

  const TaxProvidersResponse({required this.taxProviders});

  factory TaxProvidersResponse.fromJson(Map<String, dynamic> json) =>
      _$TaxProvidersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaxProvidersResponseToJson(this);
}
