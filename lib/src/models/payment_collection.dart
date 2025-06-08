import 'package:json_annotation/json_annotation.dart';

part 'payment_collection.g.dart';

/// Payment collection status
enum PaymentCollectionStatus {
  @JsonValue('not_paid')
  notPaid,
  @JsonValue('awaiting')
  awaiting,
  @JsonValue('authorized')
  authorized,
  @JsonValue('partially_authorized')
  partiallyAuthorized,
  @JsonValue('canceled')
  canceled,
}

/// Payment collection type
enum PaymentCollectionType {
  @JsonValue('order_edit')
  orderEdit,
  @JsonValue('subscription')
  subscription,
  @JsonValue('custom')
  custom,
}

/// Payment session status
enum PaymentSessionStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('authorized')
  authorized,
  @JsonValue('requires_more')
  requiresMore,
  @JsonValue('error')
  error,
  @JsonValue('canceled')
  canceled,
}

/// Payment session model
@JsonSerializable()
class PaymentSession {
  final String id;
  final String paymentCollectionId;
  final String providerId;
  final String currencyCode;
  final int amount;
  final PaymentSessionStatus status;
  final Map<String, dynamic>? data;
  final bool isSelected;
  final bool isInitiated;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PaymentSession({
    required this.id,
    required this.paymentCollectionId,
    required this.providerId,
    required this.currencyCode,
    required this.amount,
    required this.status,
    this.data,
    required this.isSelected,
    required this.isInitiated,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentSession.fromJson(Map<String, dynamic> json) =>
      _$PaymentSessionFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentSessionToJson(this);

  /// Check if session is pending
  bool get isPending => status == PaymentSessionStatus.pending;

  /// Check if session is authorized
  bool get isAuthorized => status == PaymentSessionStatus.authorized;

  /// Check if session requires more action
  bool get requiresMore => status == PaymentSessionStatus.requiresMore;

  /// Check if session has error
  bool get hasError => status == PaymentSessionStatus.error;

  /// Check if session is canceled
  bool get isCanceled => status == PaymentSessionStatus.canceled;

  /// Get formatted amount
  String getFormattedAmount([String symbol = '\$']) {
    return '$symbol${(amount / 100).toStringAsFixed(2)}';
  }
}

/// Payment model
@JsonSerializable()
class Payment {
  final String id;
  final int amount;
  final String currencyCode;
  final String providerId;
  final String? cartId;
  final String? orderId;
  final String? orderEditId;
  final String? customerId;
  final Map<String, dynamic>? data;
  final DateTime? capturedAt;
  final DateTime? canceledAt;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Payment({
    required this.id,
    required this.amount,
    required this.currencyCode,
    required this.providerId,
    this.cartId,
    this.orderId,
    this.orderEditId,
    this.customerId,
    this.data,
    this.capturedAt,
    this.canceledAt,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  /// Check if payment is captured
  bool get isCaptured => capturedAt != null;

  /// Check if payment is canceled
  bool get isCanceled => canceledAt != null;

  /// Get formatted amount
  String getFormattedAmount([String symbol = '\$']) {
    return '$symbol${(amount / 100).toStringAsFixed(2)}';
  }
}

/// Payment collection model for Medusa v2
@JsonSerializable()
class PaymentCollection {
  final String id;
  final PaymentCollectionType type;
  final PaymentCollectionStatus status;
  final String? description;
  final int amount;
  final int authorizedAmount;
  final String regionId;
  final String currencyCode;
  final List<PaymentSession>? paymentSessions;
  final List<Payment>? payments;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const PaymentCollection({
    required this.id,
    required this.type,
    required this.status,
    this.description,
    required this.amount,
    required this.authorizedAmount,
    required this.regionId,
    required this.currencyCode,
    this.paymentSessions,
    this.payments,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory PaymentCollection.fromJson(Map<String, dynamic> json) =>
      _$PaymentCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentCollectionToJson(this);

  /// Check if collection is not paid
  bool get isNotPaid => status == PaymentCollectionStatus.notPaid;

  /// Check if collection is awaiting payment
  bool get isAwaiting => status == PaymentCollectionStatus.awaiting;

  /// Check if collection is authorized
  bool get isAuthorized => status == PaymentCollectionStatus.authorized;

  /// Check if collection is partially authorized
  bool get isPartiallyAuthorized =>
      status == PaymentCollectionStatus.partiallyAuthorized;

  /// Check if collection is canceled
  bool get isCanceled => status == PaymentCollectionStatus.canceled;

  /// Check if collection is fully paid
  bool get isFullyPaid => authorizedAmount >= amount;

  /// Check if collection is for order edit
  bool get isForOrderEdit => type == PaymentCollectionType.orderEdit;

  /// Check if collection is for subscription
  bool get isForSubscription => type == PaymentCollectionType.subscription;

  /// Get remaining amount to be paid
  int get remainingAmount => amount - authorizedAmount;

  /// Get formatted total amount
  String getFormattedAmount([String symbol = '\$']) {
    return '$symbol${(amount / 100).toStringAsFixed(2)}';
  }

  /// Get formatted authorized amount
  String getFormattedAuthorizedAmount([String symbol = '\$']) {
    return '$symbol${(authorizedAmount / 100).toStringAsFixed(2)}';
  }

  /// Get formatted remaining amount
  String getFormattedRemainingAmount([String symbol = '\$']) {
    return '$symbol${(remainingAmount / 100).toStringAsFixed(2)}';
  }

  /// Get selected payment session
  PaymentSession? get selectedPaymentSession {
    if (paymentSessions == null) return null;
    return paymentSessions!.where((session) => session.isSelected).firstOrNull;
  }

  /// Get count of authorized payments
  int get authorizedPaymentsCount {
    if (payments == null) return 0;
    return payments!.where((payment) => payment.isCaptured).length;
  }
}

/// Create payment collection request
@JsonSerializable()
class CreatePaymentCollectionRequest {
  final PaymentCollectionType type;
  final String? description;
  final int amount;
  final String regionId;
  final String currencyCode;
  final Map<String, dynamic>? metadata;

  const CreatePaymentCollectionRequest({
    required this.type,
    this.description,
    required this.amount,
    required this.regionId,
    required this.currencyCode,
    this.metadata,
  });

  factory CreatePaymentCollectionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentCollectionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePaymentCollectionRequestToJson(this);
}

/// Update payment collection request
@JsonSerializable()
class UpdatePaymentCollectionRequest {
  final String? description;
  final Map<String, dynamic>? metadata;

  const UpdatePaymentCollectionRequest({this.description, this.metadata});

  factory UpdatePaymentCollectionRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePaymentCollectionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePaymentCollectionRequestToJson(this);
}

/// Set payment sessions request
@JsonSerializable()
class SetPaymentSessionsRequest {
  final List<String> providerIds;

  const SetPaymentSessionsRequest({required this.providerIds});

  factory SetPaymentSessionsRequest.fromJson(Map<String, dynamic> json) =>
      _$SetPaymentSessionsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SetPaymentSessionsRequestToJson(this);
}

/// Authorize payment session request
@JsonSerializable()
class AuthorizePaymentSessionRequest {
  final String sessionId;
  final Map<String, dynamic>? context;

  const AuthorizePaymentSessionRequest({required this.sessionId, this.context});

  factory AuthorizePaymentSessionRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthorizePaymentSessionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizePaymentSessionRequestToJson(this);
}

/// Payment collection response
@JsonSerializable()
class PaymentCollectionResponse {
  final PaymentCollection paymentCollection;

  const PaymentCollectionResponse({required this.paymentCollection});

  factory PaymentCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentCollectionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentCollectionResponseToJson(this);
}

/// Payment collections response
@JsonSerializable()
class PaymentCollectionsResponse {
  final List<PaymentCollection> paymentCollections;
  final int count;
  final int offset;
  final int limit;

  const PaymentCollectionsResponse({
    required this.paymentCollections,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory PaymentCollectionsResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentCollectionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentCollectionsResponseToJson(this);
}
