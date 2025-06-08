import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin product category management resource
class AdminCategoryResource extends AdminResource {
  const AdminCategoryResource(super.client);

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

  /// Create a new category
  Future<Category?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<Category>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'product_category',
      fromJson: Category.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a category
  Future<Category?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<Category>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'product_category',
      fromJson: Category.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a category
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

  /// Add products to category
  Future<Category?> addProducts(
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

    final categoryData = response['product_category'];
    return categoryData != null
        ? Category.fromJson(categoryData as Map<String, dynamic>)
        : null;
  }

  /// Remove products from category
  Future<Category?> removeProducts(
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

    final categoryData = response['product_category'];
    return categoryData != null
        ? Category.fromJson(categoryData as Map<String, dynamic>)
        : null;
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
}