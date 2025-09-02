import 'package:json_annotation/json_annotation.dart';

part 'exchange.g.dart';

/// Exchange status
enum ExchangeStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('requested')
  requested,
  @JsonValue('received')
  received,
  @JsonValue('completed')
  completed,
  @JsonValue('canceled')
  canceled,
}

/// Exchange payment status
enum ExchangePaymentStatus {
  @JsonValue('not_paid')
  notPaid,
  @JsonValue('paid')
  paid,
  @JsonValue('refunded')
  refunded,
  @JsonValue('partially_refunded')
  partiallyRefunded,
}

/// Exchange fulfillment status
enum ExchangeFulfillmentStatus {
  @JsonValue('not_fulfilled')
  notFulfilled,
  @JsonValue('fulfilled')
  fulfilled,
  @JsonValue('shipped')
  shipped,
  @JsonValue('partially_shipped')
  partiallyShipped,
  @JsonValue('canceled')
  canceled,
  @JsonValue('requires_action')
  requiresAction,
}

/// Exchange item model
@JsonSerializable(fieldRename: FieldRename.snake)
class ExchangeItem {
  final String id;
  final String exchangeId;
  final String orderItemId;
  final int quantity;
  final String? note;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ExchangeItem({
    required this.id,
    required this.exchangeId,
    required this.orderItemId,
    required this.quantity,
    this.note,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExchangeItem.fromJson(Map<String, dynamic> json) =>
      _$ExchangeItemFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeItemToJson(this);
}

/// Additional exchange item model
@JsonSerializable(fieldRename: FieldRename.snake)
class AdditionalExchangeItem {
  final String id;
  final String exchangeId;
  final String variantId;
  final int quantity;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AdditionalExchangeItem({
    required this.id,
    required this.exchangeId,
    required this.variantId,
    required this.quantity,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdditionalExchangeItem.fromJson(Map<String, dynamic> json) =>
      _$AdditionalExchangeItemFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalExchangeItemToJson(this);
}

/// Exchange model for Medusa v2
@JsonSerializable(fieldRename: FieldRename.snake)
class Exchange {
  final String id;
  final ExchangeStatus status;
  final ExchangePaymentStatus paymentStatus;
  final ExchangeFulfillmentStatus fulfillmentStatus;
  final String orderId;
  final List<ExchangeItem>? exchangeItems;
  final List<AdditionalExchangeItem>? additionalItems;
  final String? returnId;
  final String? cartId;
  final int? differenceDue;
  final String? shippingAddressId;
  final bool? allowBackorder;
  final DateTime? completedAt;
  final DateTime? canceledAt;
  final String? note;
  final bool? noNotification;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const Exchange({
    required this.id,
    required this.status,
    required this.paymentStatus,
    required this.fulfillmentStatus,
    required this.orderId,
    this.exchangeItems,
    this.additionalItems,
    this.returnId,
    this.cartId,
    this.differenceDue,
    this.shippingAddressId,
    this.allowBackorder,
    this.completedAt,
    this.canceledAt,
    this.note,
    this.noNotification,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Exchange.fromJson(Map<String, dynamic> json) =>
      _$ExchangeFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeToJson(this);

  /// Check if exchange is draft
  bool get isDraft => status == ExchangeStatus.draft;

  /// Check if exchange is requested
  bool get isRequested => status == ExchangeStatus.requested;

  /// Check if exchange is received
  bool get isReceived => status == ExchangeStatus.received;

  /// Check if exchange is completed
  bool get isCompleted => status == ExchangeStatus.completed;

  /// Check if exchange is canceled
  bool get isCanceled => status == ExchangeStatus.canceled;

  /// Check if exchange is paid
  bool get isPaid => paymentStatus == ExchangePaymentStatus.paid;

  /// Check if exchange is fulfilled
  bool get isFulfilled =>
      fulfillmentStatus == ExchangeFulfillmentStatus.fulfilled;

  /// Check if exchange is shipped
  bool get isShipped => fulfillmentStatus == ExchangeFulfillmentStatus.shipped;

  /// Check if customer owes money
  bool get customerOwesMoney => (differenceDue ?? 0) > 0;

  /// Check if store owes refund
  bool get storeOwesRefund => (differenceDue ?? 0) < 0;

  /// Get absolute difference amount
  int get absoluteDifference => (differenceDue ?? 0).abs();

  /// Get formatted difference due
  String getFormattedDifferenceDue([String symbol = '\$']) {
    if (differenceDue == null) return '${symbol}0.00';
    return '$symbol${(differenceDue! / 100).toStringAsFixed(2)}';
  }

  /// Get total quantity of items being exchanged
  int get totalExchangeQuantity {
    if (exchangeItems == null) return 0;
    return exchangeItems!.fold(0, (sum, item) => sum + item.quantity);
  }

  /// Get total quantity of additional items
  int get totalAdditionalQuantity {
    if (additionalItems == null) return 0;
    return additionalItems!.fold(0, (sum, item) => sum + item.quantity);
  }
}

/// Create exchange request
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateExchangeRequest {
  final String orderId;
  final List<CreateExchangeItemRequest> exchangeItems;
  final List<CreateAdditionalExchangeItemRequest>? additionalItems;
  final String? shippingAddressId;
  final bool? allowBackorder;
  final bool? noNotification;
  final String? note;
  final Map<String, dynamic>? metadata;

  const CreateExchangeRequest({
    required this.orderId,
    required this.exchangeItems,
    this.additionalItems,
    this.shippingAddressId,
    this.allowBackorder,
    this.noNotification,
    this.note,
    this.metadata,
  });

  factory CreateExchangeRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateExchangeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateExchangeRequestToJson(this);
}

/// Create exchange item request
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateExchangeItemRequest {
  final String orderItemId;
  final int quantity;
  final String? note;
  final Map<String, dynamic>? metadata;

  const CreateExchangeItemRequest({
    required this.orderItemId,
    required this.quantity,
    this.note,
    this.metadata,
  });

  factory CreateExchangeItemRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateExchangeItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateExchangeItemRequestToJson(this);
}

/// Create additional exchange item request
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateAdditionalExchangeItemRequest {
  final String variantId;
  final int quantity;
  final Map<String, dynamic>? metadata;

  const CreateAdditionalExchangeItemRequest({
    required this.variantId,
    required this.quantity,
    this.metadata,
  });

  factory CreateAdditionalExchangeItemRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$CreateAdditionalExchangeItemRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateAdditionalExchangeItemRequestToJson(this);
}

/// Update exchange request
@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateExchangeRequest {
  final String? note;
  final bool? noNotification;
  final Map<String, dynamic>? metadata;

  const UpdateExchangeRequest({this.note, this.noNotification, this.metadata});

  factory UpdateExchangeRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateExchangeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateExchangeRequestToJson(this);
}

/// Cancel exchange request
@JsonSerializable(fieldRename: FieldRename.snake)
class CancelExchangeRequest {
  final bool? noNotification;

  const CancelExchangeRequest({this.noNotification});

  factory CancelExchangeRequest.fromJson(Map<String, dynamic> json) =>
      _$CancelExchangeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CancelExchangeRequestToJson(this);
}

/// Process exchange payment request
@JsonSerializable(fieldRename: FieldRename.snake)
class ProcessExchangePaymentRequest {
  final int amount;

  const ProcessExchangePaymentRequest({required this.amount});

  factory ProcessExchangePaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$ProcessExchangePaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessExchangePaymentRequestToJson(this);
}

/// Exchange response
@JsonSerializable(fieldRename: FieldRename.snake)
class ExchangeResponse {
  final Exchange exchange;

  const ExchangeResponse({required this.exchange});

  factory ExchangeResponse.fromJson(Map<String, dynamic> json) =>
      _$ExchangeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeResponseToJson(this);
}

/// Exchanges response
@JsonSerializable(fieldRename: FieldRename.snake)
class ExchangesResponse {
  final List<Exchange> exchanges;
  final int count;
  final int offset;
  final int limit;

  const ExchangesResponse({
    required this.exchanges,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory ExchangesResponse.fromJson(Map<String, dynamic> json) =>
      _$ExchangesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangesResponseToJson(this);
}
