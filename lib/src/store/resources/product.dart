import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Store product resource for customer-facing product operations
class StoreProductResource extends StoreResource {
  const StoreProductResource(super.client);

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

  /// Get products in price range
  Future<PaginatedResponse<Product>> inPriceRange(
    double minPrice,
    double maxPrice, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['price_gte'] = minPrice;
    query['price_lte'] = maxPrice;

    return list(query: query, headers: headers);
  }

  /// Get featured products
  Future<PaginatedResponse<Product>> featured({
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['is_featured'] = true;

    return list(query: query, headers: headers);
  }
}