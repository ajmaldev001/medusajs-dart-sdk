import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin product management resource
class AdminProductResource extends AdminResource {
  const AdminProductResource(super.client);

  String get resourcePath => '$basePath/products';

  /// List products
  Future<PaginatedResponse<Product>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<Product>(
      endpoint: resourcePath,
      dataKey: 'products',
      fromJson: Product.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a product by ID
  Future<Product?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<Product>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'product',
      fromJson: Product.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new product
  Future<Product?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<Product>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'product',
      fromJson: Product.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a product
  Future<Product?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<Product>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'product',
      fromJson: Product.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a product
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

  /// Search products
  Future<PaginatedResponse<Product>> search(
    String searchTerm, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['q'] = searchTerm;

    return list(query: query, headers: headers);
  }

  /// Get products by category
  Future<PaginatedResponse<Product>> byCategory(
    String categoryId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['category_id'] = categoryId;

    return list(query: query, headers: headers);
  }

  /// Get products by collection
  Future<PaginatedResponse<Product>> byCollection(
    String collectionId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['collection_id'] = collectionId;

    return list(query: query, headers: headers);
  }
}