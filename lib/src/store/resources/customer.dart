import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Store customer resource for customer account operations
class StoreCustomerResource extends StoreResource {
  const StoreCustomerResource(super.client);

  String get resourcePath => '$basePath/customers';

  /// Create a customer (register)
  Future<Customer?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<Customer>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'customer',
      fromJson: Customer.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update current customer
  Future<Customer?> update(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/me',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final customerData = response['customer'];
    return customerData != null
        ? Customer.fromJson(customerData as Map<String, dynamic>)
        : null;
  }

  /// Retrieve current customer
  Future<Customer?> retrieve({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/me',
      query: query,
      headers: headers,
    );

    final customerData = response['customer'];
    return customerData != null
        ? Customer.fromJson(customerData as Map<String, dynamic>)
        : null;
  }

  /// Create customer address
  Future<Customer?> createAddress(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/me/addresses',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final customerData = response['customer'];
    return customerData != null
        ? Customer.fromJson(customerData as Map<String, dynamic>)
        : null;
  }

  /// Update customer address
  Future<Customer?> updateAddress(
    String addressId,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/me/addresses/$addressId',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final customerData = response['customer'];
    return customerData != null
        ? Customer.fromJson(customerData as Map<String, dynamic>)
        : null;
  }

  /// List customer addresses
  Future<PaginatedResponse<Address>> listAddresses({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/me/addresses',
      query: query,
      headers: headers,
    );

    final addresses = (response['addresses'] as List? ?? [])
        .map((json) => Address.fromJson(json as Map<String, dynamic>))
        .toList();

    return PaginatedResponse(
      data: addresses,
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Retrieve customer address
  Future<Address?> retrieveAddress(
    String addressId, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/me/addresses/$addressId',
      query: query,
      headers: headers,
    );

    final addressData = response['address'];
    return addressData != null
        ? Address.fromJson(addressData as Map<String, dynamic>)
        : null;
  }

  /// Delete customer address
  Future<Map<String, dynamic>> deleteAddress(
    String addressId, {
    ClientHeaders? headers,
  }) async {
    return await client.fetch<Map<String, dynamic>>(
      '$resourcePath/me/addresses/$addressId',
      method: 'DELETE',
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
      '$resourcePath/password-token',
      method: 'POST',
      body: body,
      headers: headers,
    );
  }

  /// Reset password
  Future<Customer?> resetPassword(
    Map<String, dynamic> body, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/password-reset',
      method: 'POST',
      body: body,
      headers: headers,
    );

    final customerData = response['customer'];
    return customerData != null
        ? Customer.fromJson(customerData as Map<String, dynamic>)
        : null;
  }
}