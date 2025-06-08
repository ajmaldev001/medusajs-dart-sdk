import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin customer management resource
class AdminCustomerResource extends AdminResource {
  const AdminCustomerResource(super.client);

  String get resourcePath => '$basePath/customers';

  /// List customers
  Future<PaginatedResponse<Customer>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<Customer>(
      endpoint: resourcePath,
      dataKey: 'customers',
      fromJson: Customer.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a customer by ID
  Future<Customer?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<Customer>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'customer',
      fromJson: Customer.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new customer
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

  /// Update a customer
  Future<Customer?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<Customer>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'customer',
      fromJson: Customer.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a customer
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

  /// Search customers
  Future<PaginatedResponse<Customer>> search(
    String searchTerm, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['q'] = searchTerm;

    return list(query: query, headers: headers);
  }

  /// Get customers by email
  Future<PaginatedResponse<Customer>> byEmail(
    String email, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['email'] = email;

    return list(query: query, headers: headers);
  }

  /// Get customers by group
  Future<PaginatedResponse<Customer>> byGroup(
    String groupId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['group_id'] = groupId;

    return list(query: query, headers: headers);
  }

  /// Add customer to group
  Future<Customer?> addToGroup(
    String customerId,
    String groupId, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$customerId/groups/$groupId',
      method: 'POST',
      headers: headers,
    );

    final customerData = response['customer'];
    return customerData != null
        ? Customer.fromJson(customerData as Map<String, dynamic>)
        : null;
  }

  /// Remove customer from group
  Future<Customer?> removeFromGroup(
    String customerId,
    String groupId, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$customerId/groups/$groupId',
      method: 'DELETE',
      headers: headers,
    );

    final customerData = response['customer'];
    return customerData != null
        ? Customer.fromJson(customerData as Map<String, dynamic>)
        : null;
  }
}