import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Store collection resource for browsing collections
class StoreCollectionResource extends StoreResource {
  const StoreCollectionResource(super.client);

  String get resourcePath => '$basePath/collections';

  /// List collections
  Future<PaginatedResponse<Collection>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<Collection>(
      endpoint: resourcePath,
      dataKey: 'collections',
      fromJson: Collection.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a collection by ID
  Future<Collection?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<Collection>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'collection',
      fromJson: Collection.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Get products in collection
  Future<PaginatedResponse<Product>> getProducts(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/products',
      query: query,
      headers: headers,
    );

    final products = (response['products'] as List? ?? [])
        .map((json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();

    return PaginatedResponse(
      data: products,
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Search collections
  Future<PaginatedResponse<Collection>> search(
    String searchTerm, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['q'] = searchTerm;

    return list(query: query, headers: headers);
  }
}