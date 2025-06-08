import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin product collection management resource
class AdminCollectionResource extends AdminResource {
  const AdminCollectionResource(super.client);

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

  /// Create a new collection
  Future<Collection?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<Collection>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'collection',
      fromJson: Collection.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a collection
  Future<Collection?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<Collection>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'collection',
      fromJson: Collection.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a collection
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

  /// Add products to collection
  Future<Collection?> addProducts(
    String id,
    List<String> productIds, {
    ClientHeaders? headers,
  }) async {
    final body = {'product_ids': productIds};

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/products/batch',
      method: 'POST',
      body: body,
      headers: headers,
    );

    final collectionData = response['collection'];
    return collectionData != null
        ? Collection.fromJson(collectionData as Map<String, dynamic>)
        : null;
  }

  /// Remove products from collection
  Future<Collection?> removeProducts(
    String id,
    List<String> productIds, {
    ClientHeaders? headers,
  }) async {
    final body = {'product_ids': productIds};

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/products/batch',
      method: 'DELETE',
      body: body,
      headers: headers,
    );

    final collectionData = response['collection'];
    return collectionData != null
        ? Collection.fromJson(collectionData as Map<String, dynamic>)
        : null;
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
}