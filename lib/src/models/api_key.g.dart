// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiKey _$ApiKeyFromJson(Map<String, dynamic> json) => ApiKey(
  id: json['id'] as String,
  token: json['token'] as String,
  title: json['title'] as String,
  type: $enumDecode(_$ApiKeyTypeEnumMap, json['type']),
  lastUsedAt:
      json['lastUsedAt'] == null
          ? null
          : DateTime.parse(json['lastUsedAt'] as String),
  revoked: json['revoked'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  revokedAt:
      json['revokedAt'] == null
          ? null
          : DateTime.parse(json['revokedAt'] as String),
  createdBy: json['createdBy'] as String?,
  revokedBy: json['revokedBy'] as String?,
);

Map<String, dynamic> _$ApiKeyToJson(ApiKey instance) => <String, dynamic>{
  'id': instance.id,
  'token': instance.token,
  'title': instance.title,
  'type': _$ApiKeyTypeEnumMap[instance.type]!,
  'lastUsedAt': instance.lastUsedAt?.toIso8601String(),
  'revoked': instance.revoked,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'revokedAt': instance.revokedAt?.toIso8601String(),
  'createdBy': instance.createdBy,
  'revokedBy': instance.revokedBy,
};

const _$ApiKeyTypeEnumMap = {
  ApiKeyType.publishable: 'publishable',
  ApiKeyType.secret: 'secret',
};

CreateApiKeyRequest _$CreateApiKeyRequestFromJson(Map<String, dynamic> json) =>
    CreateApiKeyRequest(
      title: json['title'] as String,
      type: $enumDecode(_$ApiKeyTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$CreateApiKeyRequestToJson(
  CreateApiKeyRequest instance,
) => <String, dynamic>{
  'title': instance.title,
  'type': _$ApiKeyTypeEnumMap[instance.type]!,
};

UpdateApiKeyRequest _$UpdateApiKeyRequestFromJson(Map<String, dynamic> json) =>
    UpdateApiKeyRequest(title: json['title'] as String?);

Map<String, dynamic> _$UpdateApiKeyRequestToJson(
  UpdateApiKeyRequest instance,
) => <String, dynamic>{'title': instance.title};
