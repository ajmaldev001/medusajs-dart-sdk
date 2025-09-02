import 'package:json_annotation/json_annotation.dart';

part 'sales_channel.g.dart';

/// Represents a sales channel
@JsonSerializable(fieldRename: FieldRename.snake)
class SalesChannel {
  /// Unique identifier for the sales channel
  final String id;

  /// Sales channel name
  final String name;

  /// Sales channel description
  final String? description;

  /// Whether the sales channel is disabled
  final bool isDisabled;

  /// Sales channel metadata
  final Map<String, dynamic>? metadata;

  /// When the sales channel was created
  final DateTime createdAt;

  /// When the sales channel was last updated
  final DateTime updatedAt;

  /// When the sales channel was deleted (if soft deleted)
  final DateTime? deletedAt;

  const SalesChannel({
    required this.id,
    required this.name,
    this.description,
    this.isDisabled = false,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory SalesChannel.fromJson(Map<String, dynamic> json) =>
      _$SalesChannelFromJson(json);
  Map<String, dynamic> toJson() => _$SalesChannelToJson(this);

  /// Check if sales channel is active
  bool get isActive => !isDisabled;
}

/// Request to create a sales channel
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateSalesChannelRequest {
  /// Sales channel name
  final String name;

  /// Sales channel description
  final String? description;

  /// Whether the sales channel is disabled
  final bool? isDisabled;

  /// Sales channel metadata
  final Map<String, dynamic>? metadata;

  const CreateSalesChannelRequest({
    required this.name,
    this.description,
    this.isDisabled,
    this.metadata,
  });

  factory CreateSalesChannelRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSalesChannelRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateSalesChannelRequestToJson(this);
}

/// Request to update a sales channel
@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateSalesChannelRequest {
  /// Sales channel name
  final String? name;

  /// Sales channel description
  final String? description;

  /// Whether the sales channel is disabled
  final bool? isDisabled;

  /// Sales channel metadata
  final Map<String, dynamic>? metadata;

  const UpdateSalesChannelRequest({
    this.name,
    this.description,
    this.isDisabled,
    this.metadata,
  });

  factory UpdateSalesChannelRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateSalesChannelRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateSalesChannelRequestToJson(this);
}
