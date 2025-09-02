import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

/// Notification status
enum NotificationStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('sent')
  sent,
  @JsonValue('failed')
  failed,
}

/// Notification provider model
@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationProvider {
  final String id;
  final bool isInstalled;

  const NotificationProvider({required this.id, required this.isInstalled});

  factory NotificationProvider.fromJson(Map<String, dynamic> json) =>
      _$NotificationProviderFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationProviderToJson(this);
}

/// Notification model for Medusa v2
@JsonSerializable(fieldRename: FieldRename.snake)
class Notification {
  final String id;
  final String? to;
  final String? channel;
  final String? template;
  final String? providerId;
  final NotificationProvider? provider;
  final Map<String, dynamic>? data;
  final String? parentId;
  final String? parentNotificationId;
  final NotificationStatus status;
  final String? resourceType;
  final String? resourceId;
  final String? customerId;
  final String? eventName;
  final List<String>? attempts;
  final DateTime? nextRetry;
  final String? externalId;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Notification({
    required this.id,
    this.to,
    this.channel,
    this.template,
    this.providerId,
    this.provider,
    this.data,
    this.parentId,
    this.parentNotificationId,
    required this.status,
    this.resourceType,
    this.resourceId,
    this.customerId,
    this.eventName,
    this.attempts,
    this.nextRetry,
    this.externalId,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  /// Check if notification is pending
  bool get isPending => status == NotificationStatus.pending;

  /// Check if notification was sent
  bool get isSent => status == NotificationStatus.sent;

  /// Check if notification failed
  bool get hasFailed => status == NotificationStatus.failed;

  /// Get number of attempts
  int get attemptCount => attempts?.length ?? 0;

  /// Check if notification should be retried
  bool get shouldRetry {
    if (nextRetry == null) return false;
    return DateTime.now().isAfter(nextRetry!) && hasFailed;
  }

  /// Check if notification is for email channel
  bool get isEmail => channel?.toLowerCase() == 'email';

  /// Check if notification is for SMS channel
  bool get isSms => channel?.toLowerCase() == 'sms';

  /// Check if notification is for push channel
  bool get isPush => channel?.toLowerCase() == 'push';
}

/// Send notification request
@JsonSerializable(fieldRename: FieldRename.snake)
class SendNotificationRequest {
  final String to;
  final String channel;
  final String template;
  final String? providerId;
  final Map<String, dynamic>? data;
  final String? resourceType;
  final String? resourceId;
  final String? customerId;
  final String? eventName;
  final Map<String, dynamic>? metadata;

  const SendNotificationRequest({
    required this.to,
    required this.channel,
    required this.template,
    this.providerId,
    this.data,
    this.resourceType,
    this.resourceId,
    this.customerId,
    this.eventName,
    this.metadata,
  });

  factory SendNotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$SendNotificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendNotificationRequestToJson(this);
}

/// Resend notification request
@JsonSerializable(fieldRename: FieldRename.snake)
class ResendNotificationRequest {
  final String? to;
  final Map<String, dynamic>? data;

  const ResendNotificationRequest({this.to, this.data});

  factory ResendNotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$ResendNotificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResendNotificationRequestToJson(this);
}

/// Notification response
@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationResponse {
  final Notification notification;

  const NotificationResponse({required this.notification});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}

/// Notifications response
@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationsResponse {
  final List<Notification> notifications;
  final int count;
  final int offset;
  final int limit;

  const NotificationsResponse({
    required this.notifications,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsResponseToJson(this);
}

/// Notification providers response
@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationProvidersResponse {
  final List<NotificationProvider> notificationProviders;

  const NotificationProvidersResponse({required this.notificationProviders});

  factory NotificationProvidersResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationProvidersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationProvidersResponseToJson(this);
}
