import 'package:json_annotation/json_annotation.dart';

part 'reservation.g.dart';

/// Reservation type
enum ReservationType {
  @JsonValue('order')
  order,
  @JsonValue('exchange')
  exchange,
  @JsonValue('return')
  returnType,
  @JsonValue('draft_order')
  draftOrder,
  @JsonValue('other')
  other,
}

/// Reservation model for Medusa v2
@JsonSerializable(fieldRename: FieldRename.snake)
class Reservation {
  final String id;
  final String inventoryItemId;
  final String locationId;
  final int quantity;
  final String? orderId;
  final String? lineItemId;
  final String? description;
  final ReservationType? type;
  final String? externalId;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const Reservation({
    required this.id,
    required this.inventoryItemId,
    required this.locationId,
    required this.quantity,
    this.orderId,
    this.lineItemId,
    this.description,
    this.type,
    this.externalId,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);

  /// Check if reservation is for an order
  bool get isOrderReservation => type == ReservationType.order;

  /// Check if reservation is for an exchange
  bool get isExchangeReservation => type == ReservationType.exchange;

  /// Check if reservation is for a return
  bool get isReturnReservation => type == ReservationType.returnType;

  /// Check if reservation is for a draft order
  bool get isDraftOrderReservation => type == ReservationType.draftOrder;

  /// Get age of reservation in days
  int get ageInDays {
    return DateTime.now().difference(createdAt).inDays;
  }

  /// Check if reservation is recent (created within last 24 hours)
  bool get isRecent {
    return DateTime.now().difference(createdAt).inHours < 24;
  }
}

/// Create reservation request
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateReservationRequest {
  final String inventoryItemId;
  final String locationId;
  final int quantity;
  final String? orderId;
  final String? lineItemId;
  final String? description;
  final ReservationType? type;
  final String? externalId;
  final Map<String, dynamic>? metadata;

  const CreateReservationRequest({
    required this.inventoryItemId,
    required this.locationId,
    required this.quantity,
    this.orderId,
    this.lineItemId,
    this.description,
    this.type,
    this.externalId,
    this.metadata,
  });

  factory CreateReservationRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateReservationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateReservationRequestToJson(this);
}

/// Update reservation request
@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateReservationRequest {
  final String? locationId;
  final int? quantity;
  final String? description;
  final String? externalId;
  final Map<String, dynamic>? metadata;

  const UpdateReservationRequest({
    this.locationId,
    this.quantity,
    this.description,
    this.externalId,
    this.metadata,
  });

  factory UpdateReservationRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateReservationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateReservationRequestToJson(this);
}

/// Reservation response
@JsonSerializable(fieldRename: FieldRename.snake)
class ReservationResponse {
  final Reservation reservation;

  const ReservationResponse({required this.reservation});

  factory ReservationResponse.fromJson(Map<String, dynamic> json) =>
      _$ReservationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationResponseToJson(this);
}

/// Reservations response
@JsonSerializable(fieldRename: FieldRename.snake)
class ReservationsResponse {
  final List<Reservation> reservations;
  final int count;
  final int offset;
  final int limit;

  const ReservationsResponse({
    required this.reservations,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory ReservationsResponse.fromJson(Map<String, dynamic> json) =>
      _$ReservationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationsResponseToJson(this);
}
