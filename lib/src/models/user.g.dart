// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']),
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'avatarUrl': instance.avatarUrl,
  'role': _$UserRoleEnumMap[instance.role],
  'metadata': instance.metadata,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
};

const _$UserRoleEnumMap = {
  UserRole.admin: 'admin',
  UserRole.member: 'member',
  UserRole.developer: 'developer',
};

Invite _$InviteFromJson(Map<String, dynamic> json) => Invite(
  id: json['id'] as String,
  email: json['email'] as String,
  status: $enumDecode(_$InviteStatusEnumMap, json['status']),
  token: json['token'] as String,
  userId: json['userId'] as String?,
  user:
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
  expiresAt: DateTime.parse(json['expiresAt'] as String),
  acceptedAt:
      json['acceptedAt'] == null
          ? null
          : DateTime.parse(json['acceptedAt'] as String),
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$InviteToJson(Invite instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'status': _$InviteStatusEnumMap[instance.status]!,
  'token': instance.token,
  'userId': instance.userId,
  'user': instance.user,
  'expiresAt': instance.expiresAt.toIso8601String(),
  'acceptedAt': instance.acceptedAt?.toIso8601String(),
  'metadata': instance.metadata,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
};

const _$InviteStatusEnumMap = {
  InviteStatus.pending: 'pending',
  InviteStatus.accepted: 'accepted',
  InviteStatus.expired: 'expired',
  InviteStatus.canceled: 'canceled',
};

CreateUserRequest _$CreateUserRequestFromJson(Map<String, dynamic> json) =>
    CreateUserRequest(
      email: json['email'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CreateUserRequestToJson(CreateUserRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'role': _$UserRoleEnumMap[instance.role],
      'metadata': instance.metadata,
    };

UpdateUserRequest _$UpdateUserRequestFromJson(Map<String, dynamic> json) =>
    UpdateUserRequest(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UpdateUserRequestToJson(UpdateUserRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatarUrl': instance.avatarUrl,
      'role': _$UserRoleEnumMap[instance.role],
      'metadata': instance.metadata,
    };

CreateInviteRequest _$CreateInviteRequestFromJson(Map<String, dynamic> json) =>
    CreateInviteRequest(
      email: json['email'] as String,
      role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CreateInviteRequestToJson(
  CreateInviteRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'role': _$UserRoleEnumMap[instance.role],
  'metadata': instance.metadata,
};

AcceptInviteRequest _$AcceptInviteRequestFromJson(Map<String, dynamic> json) =>
    AcceptInviteRequest(
      token: json['token'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AcceptInviteRequestToJson(
  AcceptInviteRequest instance,
) => <String, dynamic>{
  'token': instance.token,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'password': instance.password,
};

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) =>
    UserResponse(user: User.fromJson(json['user'] as Map<String, dynamic>));

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{'user': instance.user};

UsersResponse _$UsersResponseFromJson(Map<String, dynamic> json) =>
    UsersResponse(
      users:
          (json['users'] as List<dynamic>)
              .map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList(),
      count: (json['count'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$UsersResponseToJson(UsersResponse instance) =>
    <String, dynamic>{
      'users': instance.users,
      'count': instance.count,
      'offset': instance.offset,
      'limit': instance.limit,
    };

InviteResponse _$InviteResponseFromJson(Map<String, dynamic> json) =>
    InviteResponse(
      invite: Invite.fromJson(json['invite'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InviteResponseToJson(InviteResponse instance) =>
    <String, dynamic>{'invite': instance.invite};

InvitesResponse _$InvitesResponseFromJson(Map<String, dynamic> json) =>
    InvitesResponse(
      invites:
          (json['invites'] as List<dynamic>)
              .map((e) => Invite.fromJson(e as Map<String, dynamic>))
              .toList(),
      count: (json['count'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$InvitesResponseToJson(InvitesResponse instance) =>
    <String, dynamic>{
      'invites': instance.invites,
      'count': instance.count,
      'offset': instance.offset,
      'limit': instance.limit,
    };
