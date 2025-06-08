import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin user management resource
class AdminUserResource extends AdminResource {
  const AdminUserResource(super.client);

  String get resourcePath => '$basePath/users';

  /// List users
  Future<PaginatedResponse<User>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<User>(
      endpoint: resourcePath,
      dataKey: 'users',
      fromJson: User.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a user by ID
  Future<User?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<User>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'user',
      fromJson: User.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new user
  Future<User?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<User>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'user',
      fromJson: User.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a user
  Future<User?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<User>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'user',
      fromJson: User.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a user
  Future<Map<String, dynamic>> delete(
    String id, {
    ClientHeaders? headers,
  }) async {
    return await deleteGeneric(
      id: id,
      endpoint: '$resourcePath/$id',
      headers: headers,
    );
  }

  /// Get current user
  Future<User?> me({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/auth/me',
      query: query,
      headers: headers,
    );

    final userData = response['user'];
    return userData != null
        ? User.fromJson(userData as Map<String, dynamic>)
        : null;
  }

  /// Update current user
  Future<User?> updateMe(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/auth/me',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final userData = response['user'];
    return userData != null
        ? User.fromJson(userData as Map<String, dynamic>)
        : null;
  }

  /// Reset password
  Future<Map<String, dynamic>> resetPassword(
    Map<String, dynamic> body, {
    ClientHeaders? headers,
  }) async {
    return await client.fetch<Map<String, dynamic>>(
      '$basePath/auth/reset-password',
      method: 'POST',
      body: body,
      headers: headers,
    );
  }

  /// Request password reset
  Future<Map<String, dynamic>> requestPasswordReset(
    String email, {
    ClientHeaders? headers,
  }) async {
    final body = {'email': email};

    return await client.fetch<Map<String, dynamic>>(
      '$basePath/auth/password-token',
      method: 'POST',
      body: body,
      headers: headers,
    );
  }
}