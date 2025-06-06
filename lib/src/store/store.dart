import '../client/client.dart';
import '../types/types.dart';
import '../models/models.dart';

/// Store module for customer-facing operations
class MedusaStore {
  final MedusaClient _client;

  MedusaStore(this._client);

  /// Region operations
  late final region = _RegionResource(_client);

  /// Product collection operations
  late final collection = _CollectionResource(_client);

  /// Product category operations
  late final category = _CategoryResource(_client);

  /// Product operations
  late final product = _ProductResource(_client);

  /// Cart operations
  late final cart = _CartResource(_client);

  /// Fulfillment operations
  late final fulfillment = _FulfillmentResource(_client);

  /// Payment operations
  late final payment = _PaymentResource(_client);

  /// Order operations
  late final order = _OrderResource(_client);

  /// Customer operations
  late final customer = _CustomerResource(_client);
}

// Region Resource
class _RegionResource {
  final MedusaClient _client;

  _RegionResource(this._client);

  /// List regions
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    FindParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/regions',
      query: query?.toMap(),
      headers: headers,
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['regions'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Retrieve a region by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    SelectParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/regions/$id',
      query: query?.toMap(),
      headers: headers,
    );

    return response['region'] ?? {};
  }
}

// Collection Resource
class _CollectionResource {
  final MedusaClient _client;

  _CollectionResource(this._client);

  /// List collections
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    FindParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/collections',
      query: query?.toMap(),
      headers: headers,
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['collections'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Retrieve a collection by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    SelectParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/collections/$id',
      query: query?.toMap(),
      headers: headers,
    );

    return response['collection'] ?? {};
  }
}

// Category Resource
class _CategoryResource {
  final MedusaClient _client;

  _CategoryResource(this._client);

  /// List categories
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    FindParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/product-categories',
      query: query?.toMap(),
      headers: headers,
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(
        response['product_categories'] ?? [],
      ),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Retrieve a category by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    SelectParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/product-categories/$id',
      query: query?.toMap(),
      headers: headers,
    );

    return response['product_category'] ?? {};
  }
}

// Product Resource
class _ProductResource {
  final MedusaClient _client;

  _ProductResource(this._client);

  /// List products with modern query builder
  Future<PaginatedResponse<Map<String, dynamic>>> list([
    ProductQueryBuilder? query,
  ]) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/products',
      query: query?.build(),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['products'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// List products with traditional query parameters
  Future<PaginatedResponse<Map<String, dynamic>>> listWithParams({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/products',
      query: query,
      headers: headers,
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['products'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Retrieve a product by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    SelectParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/products/$id',
      query: query?.toMap(),
      headers: headers,
    );

    return response['product'] ?? {};
  }

  /// Search products
  Future<PaginatedResponse<Map<String, dynamic>>> search(
    String searchTerm, {
    ProductQueryBuilder? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = additionalFilters ?? ProductQueryBuilder();
    query.search(searchTerm);

    return list(query);
  }

  /// Get products by category
  Future<PaginatedResponse<Map<String, dynamic>>> byCategory(
    String categoryId, {
    ProductQueryBuilder? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = additionalFilters ?? ProductQueryBuilder();
    query.category(categoryId);

    return list(query);
  }

  /// Get products by collection
  Future<PaginatedResponse<Map<String, dynamic>>> byCollection(
    String collectionId, {
    ProductQueryBuilder? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = additionalFilters ?? ProductQueryBuilder();
    query.collection(collectionId);

    return list(query);
  }
}

// Cart Resource
class _CartResource {
  final MedusaClient _client;

  _CartResource(this._client);

  /// Create a cart
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> body, {
    SelectParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/carts',
      method: 'POST',
      body: body,
      query: query?.toMap(),
      headers: headers,
    );

    return response['cart'] ?? {};
  }

  /// Update a cart
  Future<Map<String, dynamic>> update(
    String id,
    Map<String, dynamic> body, {
    SelectParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/carts/$id',
      method: 'POST',
      body: body,
      query: query?.toMap(),
      headers: headers,
    );

    return response['cart'] ?? {};
  }

  /// Retrieve a cart by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    SelectParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/carts/$id',
      query: query?.toMap(),
      headers: headers,
    );

    return response['cart'] ?? {};
  }

  /// Add line item to cart
  Future<Map<String, dynamic>> createLineItem(
    String cartId,
    Map<String, dynamic> body, {
    SelectParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/carts/$cartId/line-items',
      method: 'POST',
      body: body,
      query: query?.toMap(),
      headers: headers,
    );

    return response['cart'] ?? {};
  }

  /// Update line item in cart
  Future<Map<String, dynamic>> updateLineItem(
    String cartId,
    String lineItemId,
    Map<String, dynamic> body, {
    SelectParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/carts/$cartId/line-items/$lineItemId',
      method: 'POST',
      body: body,
      query: query?.toMap(),
      headers: headers,
    );

    return response['cart'] ?? {};
  }

  /// Delete line item from cart
  Future<Map<String, dynamic>> deleteLineItem(
    String cartId,
    String lineItemId, {
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/carts/$cartId/line-items/$lineItemId',
      method: 'DELETE',
      headers: headers,
    );

    return response;
  }

  /// Add shipping method to cart
  Future<Map<String, dynamic>> addShippingMethod(
    String cartId,
    Map<String, dynamic> body, {
    SelectParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/carts/$cartId/shipping-methods',
      method: 'POST',
      body: body,
      query: query?.toMap(),
      headers: headers,
    );

    return response['cart'] ?? {};
  }

  /// Complete cart (place order)
  Future<Map<String, dynamic>> complete(
    String cartId, {
    SelectParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/carts/$cartId/complete',
      method: 'POST',
      query: query?.toMap(),
      headers: headers,
    );

    return response;
  }
}

// Other resource classes would follow similar patterns...

// Fulfillment Resource
class _FulfillmentResource {
  final MedusaClient _client;

  _FulfillmentResource(this._client);

  /// List shipping options for cart
  Future<PaginatedResponse<Map<String, dynamic>>> listCartOptions({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/shipping-options',
      query: query,
      headers: headers,
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['shipping_options'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }
}

// Payment Resource
class _PaymentResource {
  final MedusaClient _client;

  _PaymentResource(this._client);

  /// List payment providers
  Future<PaginatedResponse<Map<String, dynamic>>> listPaymentProviders({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/payment-providers',
      query: query,
      headers: headers,
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(
        response['payment_providers'] ?? [],
      ),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }
}

// Order Resource
class _OrderResource {
  final MedusaClient _client;

  _OrderResource(this._client);

  /// List orders
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/orders',
      query: query,
      headers: headers,
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['orders'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Retrieve an order by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    SelectParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/orders/$id',
      query: query?.toMap(),
      headers: headers,
    );

    return response['order'] ?? {};
  }
}

// Customer Resource
class _CustomerResource {
  final MedusaClient _client;

  _CustomerResource(this._client);

  /// Create customer
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> body, {
    SelectParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/customers',
      method: 'POST',
      body: body,
      query: query?.toMap(),
      headers: headers,
    );

    return response['customer'] ?? {};
  }

  /// Update customer
  Future<Map<String, dynamic>> update(
    Map<String, dynamic> body, {
    SelectParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/customers/me',
      method: 'POST',
      body: body,
      query: query?.toMap(),
      headers: headers,
    );

    return response['customer'] ?? {};
  }

  /// Retrieve current customer
  Future<Map<String, dynamic>> retrieve({
    SelectParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await _client.fetch<Map<String, dynamic>>(
      '/store/customers/me',
      query: query?.toMap(),
      headers: headers,
    );

    return response['customer'] ?? {};
  }
}
