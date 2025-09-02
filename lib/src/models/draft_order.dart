import 'package:json_annotation/json_annotation.dart';

part 'draft_order.g.dart';

/// Draft order status
enum DraftOrderStatus {
  @JsonValue('open')
  open,
  @JsonValue('completed')
  completed,
}

/// Draft order model for Medusa v2
@JsonSerializable(fieldRename: FieldRename.snake)
class DraftOrder {
  final String id;
  final DraftOrderStatus status;
  final String? displayId;
  final String? cartId;
  final String? orderId;
  final String? regionId;
  final String? customerId;
  final String? salesChannelId;
  final String email;
  final String? currencyCode;
  final String? shippingAddressId;
  final String? billingAddressId;
  final int? subtotal;
  final int? taxTotal;
  final int? total;
  final DateTime? completedAt;
  final bool? noNotificationOrder;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const DraftOrder({
    required this.id,
    required this.status,
    this.displayId,
    this.cartId,
    this.orderId,
    this.regionId,
    this.customerId,
    this.salesChannelId,
    required this.email,
    this.currencyCode,
    this.shippingAddressId,
    this.billingAddressId,
    this.subtotal,
    this.taxTotal,
    this.total,
    this.completedAt,
    this.noNotificationOrder,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory DraftOrder.fromJson(Map<String, dynamic> json) =>
      _$DraftOrderFromJson(json);

  Map<String, dynamic> toJson() => _$DraftOrderToJson(this);

  /// Check if draft order is open
  bool get isOpen => status == DraftOrderStatus.open;

  /// Check if draft order is completed
  bool get isCompleted => status == DraftOrderStatus.completed;

  /// Get formatted total as string
  String getFormattedTotal([String symbol = '\$']) {
    if (total == null) return '${symbol}0.00';
    return '$symbol${(total! / 100).toStringAsFixed(2)}';
  }

  /// Get formatted subtotal as string
  String getFormattedSubtotal([String symbol = '\$']) {
    if (subtotal == null) return '${symbol}0.00';
    return '$symbol${(subtotal! / 100).toStringAsFixed(2)}';
  }

  /// Get formatted tax total as string
  String getFormattedTaxTotal([String symbol = '\$']) {
    if (taxTotal == null) return '${symbol}0.00';
    return '$symbol${(taxTotal! / 100).toStringAsFixed(2)}';
  }
}

/// Create draft order request
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateDraftOrderRequest {
  final String email;
  final String? regionId;
  final String? customerId;
  final String? salesChannelId;
  final Map<String, dynamic>? shippingAddress;
  final Map<String, dynamic>? billingAddress;
  final List<CreateDraftOrderItemRequest>? items;
  final List<CreateDraftOrderDiscountRequest>? discounts;
  final bool? noNotificationOrder;
  final Map<String, dynamic>? metadata;

  const CreateDraftOrderRequest({
    required this.email,
    this.regionId,
    this.customerId,
    this.salesChannelId,
    this.shippingAddress,
    this.billingAddress,
    this.items,
    this.discounts,
    this.noNotificationOrder,
    this.metadata,
  });

  factory CreateDraftOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateDraftOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateDraftOrderRequestToJson(this);
}

/// Create draft order item request
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateDraftOrderItemRequest {
  final String variantId;
  final int quantity;
  final int? unitPrice;
  final String? title;
  final Map<String, dynamic>? metadata;

  const CreateDraftOrderItemRequest({
    required this.variantId,
    required this.quantity,
    this.unitPrice,
    this.title,
    this.metadata,
  });

  factory CreateDraftOrderItemRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateDraftOrderItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateDraftOrderItemRequestToJson(this);
}

/// Create draft order discount request
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateDraftOrderDiscountRequest {
  final String code;

  const CreateDraftOrderDiscountRequest({required this.code});

  factory CreateDraftOrderDiscountRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateDraftOrderDiscountRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateDraftOrderDiscountRequestToJson(this);
}

/// Update draft order request
@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateDraftOrderRequest {
  final String? regionId;
  final String? customerId;
  final String? email;
  final Map<String, dynamic>? shippingAddress;
  final Map<String, dynamic>? billingAddress;
  final bool? noNotificationOrder;
  final Map<String, dynamic>? metadata;

  const UpdateDraftOrderRequest({
    this.regionId,
    this.customerId,
    this.email,
    this.shippingAddress,
    this.billingAddress,
    this.noNotificationOrder,
    this.metadata,
  });

  factory UpdateDraftOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateDraftOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDraftOrderRequestToJson(this);
}

/// Complete draft order request
@JsonSerializable(fieldRename: FieldRename.snake)
class CompleteDraftOrderRequest {
  final bool? noNotificationOrder;

  const CompleteDraftOrderRequest({this.noNotificationOrder});

  factory CompleteDraftOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CompleteDraftOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CompleteDraftOrderRequestToJson(this);
}

/// Register payment request
@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterPaymentRequest {
  final int amount;

  const RegisterPaymentRequest({required this.amount});

  factory RegisterPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterPaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterPaymentRequestToJson(this);
}

/// Draft order response
@JsonSerializable(fieldRename: FieldRename.snake)
class DraftOrderResponse {
  final DraftOrder draftOrder;

  const DraftOrderResponse({required this.draftOrder});

  factory DraftOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$DraftOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DraftOrderResponseToJson(this);
}

/// Draft orders response
@JsonSerializable(fieldRename: FieldRename.snake)
class DraftOrdersResponse {
  final List<DraftOrder> draftOrders;
  final int count;
  final int offset;
  final int limit;

  const DraftOrdersResponse({
    required this.draftOrders,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory DraftOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$DraftOrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DraftOrdersResponseToJson(this);
}
