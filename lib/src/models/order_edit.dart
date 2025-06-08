import 'package:json_annotation/json_annotation.dart';

part 'order_edit.g.dart';

/// Order edit status
enum OrderEditStatus {
  @JsonValue('created')
  created,
  @JsonValue('requested')
  requested,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('declined')
  declined,
  @JsonValue('canceled')
  canceled,
}

/// Order edit change type
enum OrderEditChangeType {
  @JsonValue('item_add')
  itemAdd,
  @JsonValue('item_remove')
  itemRemove,
  @JsonValue('item_update')
  itemUpdate,
  @JsonValue('shipping_add')
  shippingAdd,
  @JsonValue('shipping_remove')
  shippingRemove,
}

/// Order edit change model
@JsonSerializable()
class OrderEditChange {
  final String id;
  final String orderEditId;
  final OrderEditChangeType type;
  final String? originalLineItemId;
  final String? lineItemId;
  final Map<String, dynamic>? data;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OrderEditChange({
    required this.id,
    required this.orderEditId,
    required this.type,
    this.originalLineItemId,
    this.lineItemId,
    this.data,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderEditChange.fromJson(Map<String, dynamic> json) =>
      _$OrderEditChangeFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEditChangeToJson(this);

  /// Check if change is adding an item
  bool get isItemAdd => type == OrderEditChangeType.itemAdd;

  /// Check if change is removing an item
  bool get isItemRemove => type == OrderEditChangeType.itemRemove;

  /// Check if change is updating an item
  bool get isItemUpdate => type == OrderEditChangeType.itemUpdate;

  /// Check if change is adding shipping
  bool get isShippingAdd => type == OrderEditChangeType.shippingAdd;

  /// Check if change is removing shipping
  bool get isShippingRemove => type == OrderEditChangeType.shippingRemove;
}

/// Order edit model for Medusa v2
@JsonSerializable()
class OrderEdit {
  final String id;
  final String orderId;
  final OrderEditStatus status;
  final String? internalNote;
  final String? createdBy;
  final String? requestedBy;
  final DateTime? requestedAt;
  final String? confirmedBy;
  final DateTime? confirmedAt;
  final String? declinedBy;
  final DateTime? declinedAt;
  final String? declinedReason;
  final String? canceledBy;
  final DateTime? canceledAt;
  final List<OrderEditChange>? changes;
  final int? subtotal;
  final int? total;
  final int? differenceDue;
  final String? paymentCollectionId;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OrderEdit({
    required this.id,
    required this.orderId,
    required this.status,
    this.internalNote,
    this.createdBy,
    this.requestedBy,
    this.requestedAt,
    this.confirmedBy,
    this.confirmedAt,
    this.declinedBy,
    this.declinedAt,
    this.declinedReason,
    this.canceledBy,
    this.canceledAt,
    this.changes,
    this.subtotal,
    this.total,
    this.differenceDue,
    this.paymentCollectionId,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderEdit.fromJson(Map<String, dynamic> json) =>
      _$OrderEditFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEditToJson(this);

  /// Check if order edit is created
  bool get isCreated => status == OrderEditStatus.created;

  /// Check if order edit is requested
  bool get isRequested => status == OrderEditStatus.requested;

  /// Check if order edit is confirmed
  bool get isConfirmed => status == OrderEditStatus.confirmed;

  /// Check if order edit is declined
  bool get isDeclined => status == OrderEditStatus.declined;

  /// Check if order edit is canceled
  bool get isCanceled => status == OrderEditStatus.canceled;

  /// Check if order edit is pending
  bool get isPending => isCreated || isRequested;

  /// Check if order edit is completed
  bool get isCompleted => isConfirmed || isDeclined || isCanceled;

  /// Check if customer owes money
  bool get customerOwesMoney => (differenceDue ?? 0) > 0;

  /// Check if store owes refund
  bool get storeOwesRefund => (differenceDue ?? 0) < 0;

  /// Get absolute difference amount
  int get absoluteDifference => (differenceDue ?? 0).abs();

  /// Get formatted total
  String getFormattedTotal([String symbol = '\$']) {
    if (total == null) return '${symbol}0.00';
    return '$symbol${(total! / 100).toStringAsFixed(2)}';
  }

  /// Get formatted subtotal
  String getFormattedSubtotal([String symbol = '\$']) {
    if (subtotal == null) return '${symbol}0.00';
    return '$symbol${(subtotal! / 100).toStringAsFixed(2)}';
  }

  /// Get formatted difference due
  String getFormattedDifferenceDue([String symbol = '\$']) {
    if (differenceDue == null) return '${symbol}0.00';
    return '$symbol${(differenceDue! / 100).toStringAsFixed(2)}';
  }

  /// Get count of changes by type
  int getChangeCount(OrderEditChangeType type) {
    if (changes == null) return 0;
    return changes!.where((change) => change.type == type).length;
  }

  /// Get count of item additions
  int get itemAdditionsCount => getChangeCount(OrderEditChangeType.itemAdd);

  /// Get count of item removals
  int get itemRemovalsCount => getChangeCount(OrderEditChangeType.itemRemove);

  /// Get count of item updates
  int get itemUpdatesCount => getChangeCount(OrderEditChangeType.itemUpdate);
}

/// Create order edit request
@JsonSerializable()
class CreateOrderEditRequest {
  final String orderId;
  final String? internalNote;
  final Map<String, dynamic>? metadata;

  const CreateOrderEditRequest({
    required this.orderId,
    this.internalNote,
    this.metadata,
  });

  factory CreateOrderEditRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderEditRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderEditRequestToJson(this);
}

/// Update order edit request
@JsonSerializable()
class UpdateOrderEditRequest {
  final String? internalNote;
  final Map<String, dynamic>? metadata;

  const UpdateOrderEditRequest({this.internalNote, this.metadata});

  factory UpdateOrderEditRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderEditRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderEditRequestToJson(this);
}

/// Add line item to order edit request
@JsonSerializable()
class AddOrderEditLineItemRequest {
  final String variantId;
  final int quantity;
  final Map<String, dynamic>? metadata;

  const AddOrderEditLineItemRequest({
    required this.variantId,
    required this.quantity,
    this.metadata,
  });

  factory AddOrderEditLineItemRequest.fromJson(Map<String, dynamic> json) =>
      _$AddOrderEditLineItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddOrderEditLineItemRequestToJson(this);
}

/// Update order edit line item request
@JsonSerializable()
class UpdateOrderEditLineItemRequest {
  final int quantity;
  final Map<String, dynamic>? metadata;

  const UpdateOrderEditLineItemRequest({required this.quantity, this.metadata});

  factory UpdateOrderEditLineItemRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderEditLineItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderEditLineItemRequestToJson(this);
}

/// Request order edit confirmation request
@JsonSerializable()
class RequestOrderEditConfirmationRequest {
  final Map<String, dynamic>? metadata;

  const RequestOrderEditConfirmationRequest({this.metadata});

  factory RequestOrderEditConfirmationRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$RequestOrderEditConfirmationRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RequestOrderEditConfirmationRequestToJson(this);
}

/// Confirm order edit request
@JsonSerializable()
class ConfirmOrderEditRequest {
  final Map<String, dynamic>? metadata;

  const ConfirmOrderEditRequest({this.metadata});

  factory ConfirmOrderEditRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmOrderEditRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmOrderEditRequestToJson(this);
}

/// Decline order edit request
@JsonSerializable()
class DeclineOrderEditRequest {
  final String? reason;
  final Map<String, dynamic>? metadata;

  const DeclineOrderEditRequest({this.reason, this.metadata});

  factory DeclineOrderEditRequest.fromJson(Map<String, dynamic> json) =>
      _$DeclineOrderEditRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeclineOrderEditRequestToJson(this);
}

/// Cancel order edit request
@JsonSerializable()
class CancelOrderEditRequest {
  final Map<String, dynamic>? metadata;

  const CancelOrderEditRequest({this.metadata});

  factory CancelOrderEditRequest.fromJson(Map<String, dynamic> json) =>
      _$CancelOrderEditRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CancelOrderEditRequestToJson(this);
}

/// Order edit response
@JsonSerializable()
class OrderEditResponse {
  final OrderEdit orderEdit;

  const OrderEditResponse({required this.orderEdit});

  factory OrderEditResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderEditResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEditResponseToJson(this);
}

/// Order edits response
@JsonSerializable()
class OrderEditsResponse {
  final List<OrderEdit> orderEdits;
  final int count;
  final int offset;
  final int limit;

  const OrderEditsResponse({
    required this.orderEdits,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory OrderEditsResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderEditsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEditsResponseToJson(this);
}
