// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationProvider _$NotificationProviderFromJson(
  Map<String, dynamic> json,
) => NotificationProvider(
  id: json['id'] as String,
  isInstalled: json['isInstalled'] as bool,
);

Map<String, dynamic> _$NotificationProviderToJson(
  NotificationProvider instance,
) => <String, dynamic>{'id': instance.id, 'isInstalled': instance.isInstalled};

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
  id: json['id'] as String,
  to: json['to'] as String?,
  channel: json['channel'] as String?,
  template: json['template'] as String?,
  providerId: json['providerId'] as String?,
  provider:
      json['provider'] == null
          ? null
          : NotificationProvider.fromJson(
            json['provider'] as Map<String, dynamic>,
          ),
  data: json['data'] as Map<String, dynamic>?,
  parentId: json['parentId'] as String?,
  parentNotificationId: json['parentNotificationId'] as String?,
  status: $enumDecode(_$NotificationStatusEnumMap, json['status']),
  resourceType: json['resourceType'] as String?,
  resourceId: json['resourceId'] as String?,
  customerId: json['customerId'] as String?,
  eventName: json['eventName'] as String?,
  attempts:
      (json['attempts'] as List<dynamic>?)?.map((e) => e as String).toList(),
  nextRetry:
      json['nextRetry'] == null
          ? null
          : DateTime.parse(json['nextRetry'] as String),
  externalId: json['externalId'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'to': instance.to,
      'channel': instance.channel,
      'template': instance.template,
      'providerId': instance.providerId,
      'provider': instance.provider,
      'data': instance.data,
      'parentId': instance.parentId,
      'parentNotificationId': instance.parentNotificationId,
      'status': _$NotificationStatusEnumMap[instance.status]!,
      'resourceType': instance.resourceType,
      'resourceId': instance.resourceId,
      'customerId': instance.customerId,
      'eventName': instance.eventName,
      'attempts': instance.attempts,
      'nextRetry': instance.nextRetry?.toIso8601String(),
      'externalId': instance.externalId,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$NotificationStatusEnumMap = {
  NotificationStatus.pending: 'pending',
  NotificationStatus.sent: 'sent',
  NotificationStatus.failed: 'failed',
};

SendNotificationRequest _$SendNotificationRequestFromJson(
  Map<String, dynamic> json,
) => SendNotificationRequest(
  to: json['to'] as String,
  channel: json['channel'] as String,
  template: json['template'] as String,
  providerId: json['providerId'] as String?,
  data: json['data'] as Map<String, dynamic>?,
  resourceType: json['resourceType'] as String?,
  resourceId: json['resourceId'] as String?,
  customerId: json['customerId'] as String?,
  eventName: json['eventName'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$SendNotificationRequestToJson(
  SendNotificationRequest instance,
) => <String, dynamic>{
  'to': instance.to,
  'channel': instance.channel,
  'template': instance.template,
  'providerId': instance.providerId,
  'data': instance.data,
  'resourceType': instance.resourceType,
  'resourceId': instance.resourceId,
  'customerId': instance.customerId,
  'eventName': instance.eventName,
  'metadata': instance.metadata,
};

ResendNotificationRequest _$ResendNotificationRequestFromJson(
  Map<String, dynamic> json,
) => ResendNotificationRequest(
  to: json['to'] as String?,
  data: json['data'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ResendNotificationRequestToJson(
  ResendNotificationRequest instance,
) => <String, dynamic>{'to': instance.to, 'data': instance.data};

NotificationResponse _$NotificationResponseFromJson(
  Map<String, dynamic> json,
) => NotificationResponse(
  notification: Notification.fromJson(
    json['notification'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$NotificationResponseToJson(
  NotificationResponse instance,
) => <String, dynamic>{'notification': instance.notification};

NotificationsResponse _$NotificationsResponseFromJson(
  Map<String, dynamic> json,
) => NotificationsResponse(
  notifications:
      (json['notifications'] as List<dynamic>)
          .map((e) => Notification.fromJson(e as Map<String, dynamic>))
          .toList(),
  count: (json['count'] as num).toInt(),
  offset: (json['offset'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
);

Map<String, dynamic> _$NotificationsResponseToJson(
  NotificationsResponse instance,
) => <String, dynamic>{
  'notifications': instance.notifications,
  'count': instance.count,
  'offset': instance.offset,
  'limit': instance.limit,
};

NotificationProvidersResponse _$NotificationProvidersResponseFromJson(
  Map<String, dynamic> json,
) => NotificationProvidersResponse(
  notificationProviders:
      (json['notificationProviders'] as List<dynamic>)
          .map((e) => NotificationProvider.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$NotificationProvidersResponseToJson(
  NotificationProvidersResponse instance,
) => <String, dynamic>{'notificationProviders': instance.notificationProviders};
