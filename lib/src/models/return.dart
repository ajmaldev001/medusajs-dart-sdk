import 'package:json_annotation/json_annotation.dart';

part 'return.g.dart';

/// Return status
enum ReturnStatus {
  @JsonValue('requested')
  requested,
  @JsonValue('received')
  received,
  @JsonValue('requires_action')
  requiresAction,
  @JsonValue('canceled')
  canceled,
}

/// Return item reason
@JsonSerializable(fieldRename: FieldRename.snake)
class ReturnReason {
  final String id;
  final String value;
  final String label;
  final String? description;
  final String? parentReturnReasonId;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const ReturnReason({
    required this.id,
    required this.value,
    required this.label,
    this.description,
    this.parentReturnReasonId,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ReturnReason.fromJson(Map<String, dynamic> json) =>
      _$ReturnReasonFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnReasonToJson(this);
}

/// Return item model
@JsonSerializable(fieldRename: FieldRename.snake)
class ReturnItem {
  final String id;
  final String returnId;
  final String orderItemId;
  final int quantity;
  final bool isDamaged;
  final String? note;
  final String? reasonId;
  final ReturnReason? reason;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const ReturnItem({
    required this.id,
    required this.returnId,
    required this.orderItemId,
    required this.quantity,
    required this.isDamaged,
    this.note,
    this.reasonId,
    this.reason,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ReturnItem.fromJson(Map<String, dynamic> json) =>
      _$ReturnItemFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnItemToJson(this);
}

/// Shipping method for returns
@JsonSerializable(fieldRename: FieldRename.snake)
class ReturnShippingMethod {
  final String id;
  final String returnId;
  final String? shippingOptionId;
  final int? price;
  final Map<String, dynamic>? data;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ReturnShippingMethod({
    required this.id,
    required this.returnId,
    this.shippingOptionId,
    this.price,
    this.data,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReturnShippingMethod.fromJson(Map<String, dynamic> json) =>
      _$ReturnShippingMethodFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnShippingMethodToJson(this);
}

/// Return model for Medusa v2
@JsonSerializable(fieldRename: FieldRename.snake)
class Return {
  final String id;
  final ReturnStatus status;
  final String? orderId;
  final String? exchangeId;
  final String? claimId;
  final String? locationId;
  final List<ReturnItem>? items;
  final ReturnShippingMethod? shippingMethod;
  final Map<String, dynamic>? shippingData;
  final int? refundAmount;
  final DateTime? receivedAt;
  final String? note;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const Return({
    required this.id,
    required this.status,
    this.orderId,
    this.exchangeId,
    this.claimId,
    this.locationId,
    this.items,
    this.shippingMethod,
    this.shippingData,
    this.refundAmount,
    this.receivedAt,
    this.note,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Return.fromJson(Map<String, dynamic> json) => _$ReturnFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnToJson(this);

  /// Check if return has been received
  bool get isReceived => status == ReturnStatus.received;

  /// Check if return is pending
  bool get isPending => status == ReturnStatus.requested;

  /// Check if return requires action
  bool get requiresAction => status == ReturnStatus.requiresAction;

  /// Check if return is canceled
  bool get isCanceled => status == ReturnStatus.canceled;

  /// Get total quantity of items being returned
  int get totalQuantity {
    if (items == null) return 0;
    return items!.fold(0, (sum, item) => sum + item.quantity);
  }

  /// Get count of damaged items
  int get damagedItemsCount {
    if (items == null) return 0;
    return items!.where((item) => item.isDamaged).length;
  }
}

/// Create return request
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateReturnRequest {
  final String orderId;
  final List<CreateReturnItemRequest> items;
  final String? locationId;
  final String? note;
  final bool? receiveNow;
  final Map<String, dynamic>? metadata;

  const CreateReturnRequest({
    required this.orderId,
    required this.items,
    this.locationId,
    this.note,
    this.receiveNow,
    this.metadata,
  });

  factory CreateReturnRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateReturnRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateReturnRequestToJson(this);
}

/// Create return item request
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateReturnItemRequest {
  final String orderItemId;
  final int quantity;
  final String? reasonId;
  final String? note;
  final bool? isDamaged;
  final Map<String, dynamic>? metadata;

  const CreateReturnItemRequest({
    required this.orderItemId,
    required this.quantity,
    this.reasonId,
    this.note,
    this.isDamaged,
    this.metadata,
  });

  factory CreateReturnItemRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateReturnItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateReturnItemRequestToJson(this);
}

/// Update return request
@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateReturnRequest {
  final String? note;
  final DateTime? receivedAt;
  final Map<String, dynamic>? metadata;

  const UpdateReturnRequest({this.note, this.receivedAt, this.metadata});

  factory UpdateReturnRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateReturnRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateReturnRequestToJson(this);
}

/// Receive return request
@JsonSerializable(fieldRename: FieldRename.snake)
class ReceiveReturnRequest {
  final List<ReceiveReturnItemRequest>? items;
  final String? note;
  final Map<String, dynamic>? metadata;

  const ReceiveReturnRequest({this.items, this.note, this.metadata});

  factory ReceiveReturnRequest.fromJson(Map<String, dynamic> json) =>
      _$ReceiveReturnRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiveReturnRequestToJson(this);
}

/// Receive return item request
@JsonSerializable(fieldRename: FieldRename.snake)
class ReceiveReturnItemRequest {
  final String returnItemId;
  final int quantity;
  final bool? isDamaged;
  final String? note;

  const ReceiveReturnItemRequest({
    required this.returnItemId,
    required this.quantity,
    this.isDamaged,
    this.note,
  });

  factory ReceiveReturnItemRequest.fromJson(Map<String, dynamic> json) =>
      _$ReceiveReturnItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiveReturnItemRequestToJson(this);
}

/// Return response
@JsonSerializable(fieldRename: FieldRename.snake)
class ReturnResponse {
  final Return returnOrder;

  const ReturnResponse({required this.returnOrder});

  factory ReturnResponse.fromJson(Map<String, dynamic> json) =>
      _$ReturnResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnResponseToJson(this);
}

/// Returns response
@JsonSerializable(fieldRename: FieldRename.snake)
class ReturnsResponse {
  final List<Return> returns;
  final int count;
  final int offset;
  final int limit;

  const ReturnsResponse({
    required this.returns,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory ReturnsResponse.fromJson(Map<String, dynamic> json) =>
      _$ReturnsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnsResponseToJson(this);
}

/// Return reasons response
@JsonSerializable(fieldRename: FieldRename.snake)
class ReturnReasonsResponse {
  final List<ReturnReason> returnReasons;

  const ReturnReasonsResponse({required this.returnReasons});

  factory ReturnReasonsResponse.fromJson(Map<String, dynamic> json) =>
      _$ReturnReasonsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnReasonsResponseToJson(this);
}
