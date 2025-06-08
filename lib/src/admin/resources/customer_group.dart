import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin customer group management resource
class AdminCustomerGroupResource extends AdminResource {
  const AdminCustomerGroupResource(super.client);

  String get resourcePath => '$basePath/customer-groups';

  /// List customer groups
  Future<PaginatedResponse<CustomerGroup>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<CustomerGroup>(
      endpoint: resourcePath,
      dataKey: 'customer_groups',
      fromJson: CustomerGroup.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a customer group by ID
  Future<CustomerGroup?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<CustomerGroup>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'customer_group',
      fromJson: CustomerGroup.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new customer group
  Future<CustomerGroup?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<CustomerGroup>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'customer_group',
      fromJson: CustomerGroup.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a customer group
  Future<CustomerGroup?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<CustomerGroup>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'customer_group',
      fromJson: CustomerGroup.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a customer group
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

  /// Add customer to group
  Future<CustomerGroup?> addCustomer(
    String id,
    String customerId, {
    ClientHeaders? headers,
  }) async {
    return await createGeneric<CustomerGroup>(
      body: {'customer_id': customerId},
      endpoint: '$resourcePath/$id/customers',
      dataKey: 'customer_group',
      fromJson: CustomerGroup.fromJson,
      headers: headers,
    );
  }

  /// Remove customer from group
  Future<CustomerGroup?> removeCustomer(
    String id,
    String customerId, {
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<CustomerGroup>(
      id: customerId,
      body: {},
      endpoint: '$resourcePath/$id/customers/$customerId',
      dataKey: 'customer_group',
      fromJson: CustomerGroup.fromJson,
      headers: headers,
    );
  }

  /// List customers in group
  Future<PaginatedResponse<Customer>> getCustomers(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<Customer>(
      endpoint: '$resourcePath/$id/customers',
      dataKey: 'customers',
      fromJson: Customer.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Add multiple customers to group
  Future<CustomerGroup?> addCustomers(
    String id,
    List<String> customerIds, {
    ClientHeaders? headers,
  }) async {
    return await createGeneric<CustomerGroup>(
      body: {'customer_ids': customerIds},
      endpoint: '$resourcePath/$id/customers/batch',
      dataKey: 'customer_group',
      fromJson: CustomerGroup.fromJson,
      headers: headers,
    );
  }

  /// Remove multiple customers from group
  Future<CustomerGroup?> removeCustomers(
    String id,
    List<String> customerIds, {
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<CustomerGroup>(
      id: id,
      body: {'customer_ids': customerIds},
      endpoint: '$resourcePath/$id/customers/batch',
      dataKey: 'customer_group',
      fromJson: CustomerGroup.fromJson,
      headers: headers,
    );
  }

  /// Search customer groups by name
  Future<PaginatedResponse<CustomerGroup>> search(
    String searchTerm, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['q'] = searchTerm;

    return list(query: query, headers: headers);
  }
}