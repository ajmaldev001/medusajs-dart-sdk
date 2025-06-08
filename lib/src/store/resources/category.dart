import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Store category resource for browsing product categories
class StoreCategoryResource extends StoreResource {
  const StoreCategoryResource(super.client);

  String get resourcePath => '$basePath/product-categories';

  /// List categories
  Future<PaginatedResponse<Category>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<Category>(
      endpoint: resourcePath,
      dataKey: 'product_categories',
      fromJson: Category.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a category by ID
  Future<Category?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<Category>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'product_category',
      fromJson: Category.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Get products in category
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

  /// Get child categories
  Future<PaginatedResponse<Category>> getChildren(
    String parentId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['parent_category_id'] = parentId;

    return list(query: query, headers: headers);
  }

  /// Get root categories (no parent)
  Future<PaginatedResponse<Category>> getRoots({
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['parent_category_id'] = 'null';

    return list(query: query, headers: headers);
  }

  /// Search categories
  Future<PaginatedResponse<Category>> search(
    String searchTerm, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['q'] = searchTerm;

    return list(query: query, headers: headers);
  }
}