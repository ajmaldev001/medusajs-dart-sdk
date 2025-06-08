import 'package:json_annotation/json_annotation.dart';
import 'address.dart';

part 'stock_location.g.dart';

/// Represents a stock location
@JsonSerializable()
class StockLocation {
  /// Unique identifier for the stock location
  final String id;

  /// Stock location name
  final String name;

  /// Stock location address
  final Address? address;

  /// Stock location metadata
  final Map<String, dynamic>? metadata;

  /// When the stock location was created
  final DateTime createdAt;

  /// When the stock location was last updated
  final DateTime updatedAt;

  /// When the stock location was deleted (if soft deleted)
  final DateTime? deletedAt;

  const StockLocation({
    required this.id,
    required this.name,
    this.address,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory StockLocation.fromJson(Map<String, dynamic> json) =>
      _$StockLocationFromJson(json);
  Map<String, dynamic> toJson() => _$StockLocationToJson(this);
}

/// Request to create a stock location
@JsonSerializable()
class CreateStockLocationRequest {
  /// Stock location name
  final String name;

  /// Stock location address
  final Address? address;

  /// Stock location metadata
  final Map<String, dynamic>? metadata;

  const CreateStockLocationRequest({
    required this.name,
    this.address,
    this.metadata,
  });

  factory CreateStockLocationRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateStockLocationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateStockLocationRequestToJson(this);
}

/// Request to update a stock location
@JsonSerializable()
class UpdateStockLocationRequest {
  /// Stock location name
  final String? name;

  /// Stock location address
  final Address? address;

  /// Stock location metadata
  final Map<String, dynamic>? metadata;

  const UpdateStockLocationRequest({this.name, this.address, this.metadata});

  factory UpdateStockLocationRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateStockLocationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateStockLocationRequestToJson(this);
}
