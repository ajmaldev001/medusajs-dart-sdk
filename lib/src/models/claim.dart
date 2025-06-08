import 'package:json_annotation/json_annotation.dart';

part 'claim.g.dart';

/// Claim types
enum ClaimType {
  @JsonValue('replace')
  replace,
  @JsonValue('refund')
  refund,
}

/// Claim payment status
enum ClaimPaymentStatus {
  @JsonValue('na')
  na,
  @JsonValue('not_refunded')
  notRefunded,
  @JsonValue('refunded')
  refunded,
}

/// Claim fulfillment status
enum ClaimFulfillmentStatus {
  @JsonValue('not_fulfilled')
  notFulfilled,
  @JsonValue('partially_fulfilled')
  partiallyFulfilled,
  @JsonValue('fulfilled')
  fulfilled,
  @JsonValue('partially_shipped')
  partiallyShipped,
  @JsonValue('shipped')
  shipped,
  @JsonValue('partially_returned')
  partiallyReturned,
  @JsonValue('returned')
  returned,
  @JsonValue('canceled')
  canceled,
  @JsonValue('requires_action')
  requiresAction,
}

/// Claim item model
@JsonSerializable()
class ClaimItem {
  final String id;
  final String itemId;
  final String variantId;
  final String claimOrderId;
  final int quantity;
  final String? reason;
  final String? note;
  final List<String>? images;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const ClaimItem({
    required this.id,
    required this.itemId,
    required this.variantId,
    required this.claimOrderId,
    required this.quantity,
    this.reason,
    this.note,
    this.images,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ClaimItem.fromJson(Map<String, dynamic> json) =>
      _$ClaimItemFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimItemToJson(this);
}

/// Additional claim item (for replacements)
@JsonSerializable()
class AdditionalClaimItem {
  final String id;
  final String variantId;
  final String claimOrderId;
  final int quantity;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const AdditionalClaimItem({
    required this.id,
    required this.variantId,
    required this.claimOrderId,
    required this.quantity,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdditionalClaimItem.fromJson(Map<String, dynamic> json) =>
      _$AdditionalClaimItemFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalClaimItemToJson(this);
}

/// Claim order model for Medusa v2
@JsonSerializable()
class ClaimOrder {
  final String id;
  final ClaimPaymentStatus paymentStatus;
  final ClaimFulfillmentStatus fulfillmentStatus;
  final ClaimType type;
  final String orderId;
  final String? shippingAddressId;
  final List<ClaimItem>? claimItems;
  final List<AdditionalClaimItem>? additionalItems;
  final String? returnOrderId;
  final int? refundAmount;
  final DateTime? canceledAt;
  final String? note;
  final bool? noNotification;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const ClaimOrder({
    required this.id,
    required this.paymentStatus,
    required this.fulfillmentStatus,
    required this.type,
    required this.orderId,
    this.shippingAddressId,
    this.claimItems,
    this.additionalItems,
    this.returnOrderId,
    this.refundAmount,
    this.canceledAt,
    this.note,
    this.noNotification,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ClaimOrder.fromJson(Map<String, dynamic> json) =>
      _$ClaimOrderFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimOrderToJson(this);

  /// Check if claim is for replacement
  bool get isReplacement => type == ClaimType.replace;

  /// Check if claim is for refund
  bool get isRefund => type == ClaimType.refund;

  /// Check if claim is canceled
  bool get isCanceled => canceledAt != null;

  /// Check if claim is fulfilled
  bool get isFulfilled => fulfillmentStatus == ClaimFulfillmentStatus.fulfilled;

  /// Check if claim is shipped
  bool get isShipped => fulfillmentStatus == ClaimFulfillmentStatus.shipped;

  /// Check if claim is refunded
  bool get isRefunded => paymentStatus == ClaimPaymentStatus.refunded;

  /// Get total quantity of claimed items
  int get totalClaimedQuantity {
    if (claimItems == null) return 0;
    return claimItems!.fold(0, (sum, item) => sum + item.quantity);
  }

  /// Get total quantity of additional items
  int get totalAdditionalQuantity {
    if (additionalItems == null) return 0;
    return additionalItems!.fold(0, (sum, item) => sum + item.quantity);
  }
}

/// Create claim request
@JsonSerializable()
class CreateClaimRequest {
  final String orderId;
  final ClaimType type;
  final List<CreateClaimItemRequest> claimItems;
  final List<CreateAdditionalClaimItemRequest>? additionalItems;
  final String? shippingAddressId;
  final bool? returnShipping;
  final bool? noNotification;
  final String? note;
  final Map<String, dynamic>? metadata;

  const CreateClaimRequest({
    required this.orderId,
    required this.type,
    required this.claimItems,
    this.additionalItems,
    this.shippingAddressId,
    this.returnShipping,
    this.noNotification,
    this.note,
    this.metadata,
  });

  factory CreateClaimRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateClaimRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateClaimRequestToJson(this);
}

/// Create claim item request
@JsonSerializable()
class CreateClaimItemRequest {
  final String itemId;
  final int quantity;
  final String? reason;
  final String? note;
  final List<String>? images;
  final Map<String, dynamic>? metadata;

  const CreateClaimItemRequest({
    required this.itemId,
    required this.quantity,
    this.reason,
    this.note,
    this.images,
    this.metadata,
  });

  factory CreateClaimItemRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateClaimItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateClaimItemRequestToJson(this);
}

/// Create additional claim item request
@JsonSerializable()
class CreateAdditionalClaimItemRequest {
  final String variantId;
  final int quantity;
  final Map<String, dynamic>? metadata;

  const CreateAdditionalClaimItemRequest({
    required this.variantId,
    required this.quantity,
    this.metadata,
  });

  factory CreateAdditionalClaimItemRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$CreateAdditionalClaimItemRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateAdditionalClaimItemRequestToJson(this);
}

/// Update claim request
@JsonSerializable()
class UpdateClaimRequest {
  final String? note;
  final bool? noNotification;
  final Map<String, dynamic>? metadata;

  const UpdateClaimRequest({this.note, this.noNotification, this.metadata});

  factory UpdateClaimRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateClaimRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateClaimRequestToJson(this);
}

/// Cancel claim request
@JsonSerializable()
class CancelClaimRequest {
  final bool? noNotification;

  const CancelClaimRequest({this.noNotification});

  factory CancelClaimRequest.fromJson(Map<String, dynamic> json) =>
      _$CancelClaimRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CancelClaimRequestToJson(this);
}

/// Claim response
@JsonSerializable()
class ClaimResponse {
  final ClaimOrder claim;

  const ClaimResponse({required this.claim});

  factory ClaimResponse.fromJson(Map<String, dynamic> json) =>
      _$ClaimResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimResponseToJson(this);
}

/// Claims response
@JsonSerializable()
class ClaimsResponse {
  final List<ClaimOrder> claims;
  final int count;
  final int offset;
  final int limit;

  const ClaimsResponse({
    required this.claims,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory ClaimsResponse.fromJson(Map<String, dynamic> json) =>
      _$ClaimsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimsResponseToJson(this);
}
