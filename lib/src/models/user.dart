import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// User roles
enum UserRole {
  @JsonValue('admin')
  admin,
  @JsonValue('member')
  member,
  @JsonValue('developer')
  developer,
}

/// Invite status
enum InviteStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('expired')
  expired,
  @JsonValue('canceled')
  canceled,
}

/// User model for Medusa v2
@JsonSerializable()
class User {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? avatarUrl;
  final UserRole? role;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const User({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.role,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// Get user's full name
  String get fullName {
    if (firstName == null && lastName == null) return email;
    return '${firstName ?? ''} ${lastName ?? ''}'.trim();
  }

  /// Get user's display name (firstName or email)
  String get displayName {
    return firstName ?? email;
  }

  /// Check if user is admin
  bool get isAdmin => role == UserRole.admin;

  /// Check if user is member
  bool get isMember => role == UserRole.member;

  /// Check if user is developer
  bool get isDeveloper => role == UserRole.developer;
}

/// User invite model
@JsonSerializable()
class Invite {
  final String id;
  final String email;
  final InviteStatus status;
  final String token;
  final String? userId;
  final User? user;
  final DateTime expiresAt;
  final DateTime? acceptedAt;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const Invite({
    required this.id,
    required this.email,
    required this.status,
    required this.token,
    this.userId,
    this.user,
    required this.expiresAt,
    this.acceptedAt,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Invite.fromJson(Map<String, dynamic> json) => _$InviteFromJson(json);

  Map<String, dynamic> toJson() => _$InviteToJson(this);

  /// Check if invite is pending
  bool get isPending => status == InviteStatus.pending;

  /// Check if invite is accepted
  bool get isAccepted => status == InviteStatus.accepted;

  /// Check if invite is expired
  bool get isExpired =>
      status == InviteStatus.expired || DateTime.now().isAfter(expiresAt);

  /// Check if invite is canceled
  bool get isCanceled => status == InviteStatus.canceled;

  /// Check if invite is still valid
  bool get isValid => isPending && !isExpired;
}

/// Create user request
@JsonSerializable()
class CreateUserRequest {
  final String email;
  final String? firstName;
  final String? lastName;
  final UserRole? role;
  final Map<String, dynamic>? metadata;

  const CreateUserRequest({
    required this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.metadata,
  });

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserRequestToJson(this);
}

/// Update user request
@JsonSerializable()
class UpdateUserRequest {
  final String? firstName;
  final String? lastName;
  final String? avatarUrl;
  final UserRole? role;
  final Map<String, dynamic>? metadata;

  const UpdateUserRequest({
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.role,
    this.metadata,
  });

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);
}

/// Create invite request
@JsonSerializable()
class CreateInviteRequest {
  final String email;
  final UserRole? role;
  final Map<String, dynamic>? metadata;

  const CreateInviteRequest({required this.email, this.role, this.metadata});

  factory CreateInviteRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateInviteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateInviteRequestToJson(this);
}

/// Accept invite request
@JsonSerializable()
class AcceptInviteRequest {
  final String token;
  final String? firstName;
  final String? lastName;
  final String password;

  const AcceptInviteRequest({
    required this.token,
    this.firstName,
    this.lastName,
    required this.password,
  });

  factory AcceptInviteRequest.fromJson(Map<String, dynamic> json) =>
      _$AcceptInviteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptInviteRequestToJson(this);
}

/// User response
@JsonSerializable()
class UserResponse {
  final User user;

  const UserResponse({required this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

/// Users response
@JsonSerializable()
class UsersResponse {
  final List<User> users;
  final int count;
  final int offset;
  final int limit;

  const UsersResponse({
    required this.users,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UsersResponseToJson(this);
}

/// Invite response
@JsonSerializable()
class InviteResponse {
  final Invite invite;

  const InviteResponse({required this.invite});

  factory InviteResponse.fromJson(Map<String, dynamic> json) =>
      _$InviteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InviteResponseToJson(this);
}

/// Invites response
@JsonSerializable()
class InvitesResponse {
  final List<Invite> invites;
  final int count;
  final int offset;
  final int limit;

  const InvitesResponse({
    required this.invites,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory InvitesResponse.fromJson(Map<String, dynamic> json) =>
      _$InvitesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InvitesResponseToJson(this);
}
