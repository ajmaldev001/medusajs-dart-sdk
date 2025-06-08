import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin sales channel management resource
class AdminSalesChannelResource extends AdminResource {
  const AdminSalesChannelResource(super.client);

  String get resourcePath => '$basePath/sales-channels';

  /// List sales channels
  Future<PaginatedResponse<SalesChannel>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<SalesChannel>(
      endpoint: resourcePath,
      dataKey: 'sales_channels',
      fromJson: SalesChannel.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a sales channel by ID
  Future<SalesChannel?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<SalesChannel>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'sales_channel',
      fromJson: SalesChannel.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new sales channel
  Future<SalesChannel?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<SalesChannel>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'sales_channel',
      fromJson: SalesChannel.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a sales channel
  Future<SalesChannel?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<SalesChannel>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'sales_channel',
      fromJson: SalesChannel.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a sales channel
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

  /// Add products to a sales channel
  Future<Map<String, dynamic>> addProducts(
    String id,
    List<String> productIds, {
    ClientHeaders? headers,
  }) async {
    return await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/products/batch',
      method: 'POST',
      body: {'add': productIds},
      headers: headers,
    );
  }

  /// Remove products from a sales channel
  Future<Map<String, dynamic>> removeProducts(
    String id,
    List<String> productIds, {
    ClientHeaders? headers,
  }) async {
    return await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/products/batch',
      method: 'POST',
      body: {'remove': productIds},
      headers: headers,
    );
  }

  /// Get products associated with a sales channel
  Future<PaginatedResponse<Product>> getProducts(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<Product>(
      endpoint: '$resourcePath/$id/products',
      dataKey: 'products',
      fromJson: Product.fromJson,
      query: query,
      headers: headers,
    );
  }
}