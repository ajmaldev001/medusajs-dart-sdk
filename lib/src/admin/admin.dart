import '../client/client.dart';
import '../types/types.dart';
import '../models/models.dart';
import '../pagination/pagination.dart';
import '../batch/batch.dart';

/// Admin module for administrative operations
///
/// Provides access to all administrative functionality including:
/// - Product management
/// - Order management
/// - Customer management
/// - Inventory management
/// - Analytics and reporting
/// - Settings and configuration
///
/// All admin operations require proper authentication and authorization.
class MedusaAdmin {
  final MedusaClient _client;

  MedusaAdmin(this._client);

  /// Product management operations
  late final product = _AdminProductResource(_client);

  /// Order management operations
  late final order = _AdminOrderResource(_client);

  /// Customer management operations
  late final customer = _AdminCustomerResource(_client);

  /// User management operations
  late final user = _AdminUserResource(_client);

  /// Region management operations
  late final region = _AdminRegionResource(_client);

  /// Product collection management operations
  late final collection = _AdminCollectionResource(_client);

  /// Product category management operations
  late final category = _AdminCategoryResource(_client);

  /// Inventory management operations
  late final inventory = _AdminInventoryResource(_client);

  /// Price list management operations
  late final priceList = _AdminPriceListResource(_client);

  /// Discount management operations
  late final discount = _AdminDiscountResource(_client);

  /// Gift card management operations
  late final giftCard = _AdminGiftCardResource(_client);

  /// Tax management operations
  late final tax = _AdminTaxResource(_client);

  /// Shipping management operations
  late final shipping = _AdminShippingResource(_client);

  /// Payment provider management operations
  late final payment = _AdminPaymentResource(_client);

  /// Store settings operations
  late final store = _AdminStoreResource(_client);

  /// Currency management operations
  late final currency = _AdminCurrencyResource(_client);

  /// Analytics and reporting operations
  late final analytics = _AdminAnalyticsResource(_client);

  /// Return management operations
  late final returns = _AdminReturnResource(_client);

  /// Swap management operations
  late final swap = _AdminSwapResource(_client);

  /// Fulfillment management operations
  late final fulfillment = _AdminFulfillmentResource(_client);

  /// Reservation management operations
  late final reservation = _AdminReservationResource(_client);

  /// Sales channel management operations
  late final salesChannel = _AdminSalesChannelResource(_client);

  /// Stock location management operations
  late final stockLocation = _AdminStockLocationResource(_client);

  /// Workflow execution operations
  late final workflow = _AdminWorkflowResource(_client);

  /// API key management operations
  late final apiKey = _AdminApiKeyResource(_client);

  /// Invite management operations
  late final invite = _AdminInviteResource(_client);

  /// Upload operations
  late final upload = _AdminUploadResource(_client);

  /// Notification operations
  late final notification = _AdminNotificationResource(_client);

  /// Authentication operations
  late final auth = _AdminAuthResource(_client);

  /// Create a new batch manager for bulk operations
  BatchManager createBatch({int maxBatchSize = 50}) {
    return BatchManager(_client, maxBatchSize: maxBatchSize);
  }

  /// Create a product batch builder
  ProductBatchBuilder batchProducts({int maxBatchSize = 50}) {
    final manager = createBatch(maxBatchSize: maxBatchSize);
    return ProductBatchBuilder(manager);
  }

  /// Create an order batch builder
  OrderBatchBuilder batchOrders({int maxBatchSize = 50}) {
    final manager = createBatch(maxBatchSize: maxBatchSize);
    return OrderBatchBuilder(manager);
  }

  /// Create a customer batch builder
  CustomerBatchBuilder batchCustomers({int maxBatchSize = 50}) {
    final manager = createBatch(maxBatchSize: maxBatchSize);
    return CustomerBatchBuilder(manager);
  }

  /// Create an auto-batching manager
  AutoBatchManager createAutoBatch({
    Duration batchDelay = const Duration(milliseconds: 100),
    int maxBatchSize = 50,
  }) {
    return AutoBatchManager(
      _client,
      batchDelay: batchDelay,
      maxBatchSize: maxBatchSize,
    );
  }
}

/// Base class for admin resources
abstract class _AdminResource {
  final MedusaClient client;
  const _AdminResource(this.client);

  /// Get the base path for this resource
  String get basePath;
}

/// Admin product management resource
class _AdminProductResource extends _AdminResource {
  const _AdminProductResource(super.client);

  @override
  String get basePath => '/admin/products';

  /// Create a new query builder for products
  ProductQueryBuilder query() => ProductQueryBuilder();

  /// List all products with filtering and pagination
  Future<PaginatedResponse<Product>> list({
    ProductQueryBuilder? queryBuilder,
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final finalQuery = queryBuilder?.build() ?? query;
    return client.fetch<PaginatedResponse<Product>>(
      basePath,
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Search products with a text query
  Future<PaginatedResponse<Product>> search(
    String searchTerm, {
    ProductQueryBuilder? queryBuilder,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = queryBuilder ?? ProductQueryBuilder();
    builder.search(searchTerm);
    return list(
      queryBuilder: builder,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get products by collection
  Future<PaginatedResponse<Product>> byCollection(
    String collectionId, {
    ProductQueryBuilder? queryBuilder,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = queryBuilder ?? ProductQueryBuilder();
    builder.collection(collectionId);
    return list(
      queryBuilder: builder,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get products by category
  Future<PaginatedResponse<Product>> byCategory(
    String categoryId, {
    ProductQueryBuilder? queryBuilder,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = queryBuilder ?? ProductQueryBuilder();
    builder.category(categoryId);
    return list(
      queryBuilder: builder,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Retrieve a specific product by ID
  Future<Product> retrieve(
    String id, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
    return Product.fromJson(response['product']);
  }

  /// Create a paginated iterator for products
  PaginatedIterator<Product> paginate({
    ProductQueryBuilder? queryBuilder,
    PaginationConfig? config,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) {
    final paginationConfig = config ?? const PaginationConfig();

    return PaginatedIterator<Product>((offset, limit) async {
      final builder = queryBuilder ?? ProductQueryBuilder();
      builder.paginate(limit: limit, offset: offset);

      return await list(
        queryBuilder: builder,
        headers: headers,
        useCache: useCache,
        cacheTtl: cacheTtl,
      );
    }, paginationConfig);
  }

  /// Get all products across all pages
  Future<List<Product>> getAll({
    ProductQueryBuilder? queryBuilder,
    PaginationConfig? config,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final iterator = paginate(
      queryBuilder: queryBuilder,
      config: config ?? const PaginationConfig(fetchAll: true),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );

    return await iterator.getAllPages();
  }

  /// Get products as a stream
  Stream<Product> asStream({
    ProductQueryBuilder? queryBuilder,
    PaginationConfig? config,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) {
    final iterator = paginate(
      queryBuilder: queryBuilder,
      config: config ?? const PaginationConfig(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );

    return iterator.asStream();
  }

  /// Create a new product
  Future<Product> create(
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false, // Don't cache write operations
    );
    return Product.fromJson(response['product']);
  }

  /// Update an existing product
  Future<Product> update(
    String id,
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false, // Don't cache write operations
    );
    return Product.fromJson(response['product']);
  }

  /// Delete a product
  Future<DeleteResponse> delete(String id, {ClientHeaders? headers}) async {
    return client.fetch<DeleteResponse>(
      '$basePath/$id',
      method: 'DELETE',
      headers: headers,
      useCache: false, // Don't cache write operations
    );
  }

  /// Batch operations for products
  Future<BatchResponse<Product>> batch(
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    return client.fetch<BatchResponse<Product>>(
      '$basePath/batch',
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false, // Don't cache write operations
    );
  }
}

/// Admin order management resource
class _AdminOrderResource extends _AdminResource {
  const _AdminOrderResource(super.client);

  @override
  String get basePath => '/admin/orders';

  /// Create a new query builder for orders
  OrderQueryBuilder query() => OrderQueryBuilder();

  /// List all orders with filtering and pagination
  Future<PaginatedResponse<Order>> list({
    OrderQueryBuilder? queryBuilder,
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final finalQuery = queryBuilder?.build() ?? query;
    return client.fetch<PaginatedResponse<Order>>(
      basePath,
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get orders by status
  Future<PaginatedResponse<Order>> byStatus(
    String status, {
    OrderQueryBuilder? queryBuilder,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = queryBuilder ?? OrderQueryBuilder();
    builder.status(status);
    return list(
      queryBuilder: builder,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get orders by customer
  Future<PaginatedResponse<Order>> byCustomer(
    String customerId, {
    OrderQueryBuilder? queryBuilder,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = queryBuilder ?? OrderQueryBuilder();
    builder.customer(customerId);
    return list(
      queryBuilder: builder,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Retrieve a specific order by ID
  Future<Order> retrieve(
    String id, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
    return Order.fromJson(response['order']);
  }

  /// Update an order
  Future<Order> update(
    String id,
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false, // Don't cache write operations
    );
    return Order.fromJson(response['order']);
  }

  /// Cancel an order
  Future<Order> cancel(String id, {ClientHeaders? headers}) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/cancel',
      method: 'POST',
      headers: headers,
      useCache: false, // Don't cache write operations
    );
    return Order.fromJson(response['order']);
  }

  /// Capture payment for an order
  Future<Order> capturePayment(
    String id,
    Map<String, dynamic> payload, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/capture',
      method: 'POST',
      body: payload,
      headers: headers,
      useCache: false, // Don't cache write operations
    );
    return Order.fromJson(response['order']);
  }

  /// Fulfill an order
  Future<Order> fulfill(
    String id,
    Map<String, dynamic> payload, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/fulfillment',
      method: 'POST',
      body: payload,
      headers: headers,
      useCache: false, // Don't cache write operations
    );
    return Order.fromJson(response['order']);
  }
}

/// Admin customer management resource
class _AdminCustomerResource extends _AdminResource {
  const _AdminCustomerResource(super.client);

  @override
  String get basePath => '/admin/customers';

  /// Create a new query builder for customers
  CustomerQueryBuilder query() => CustomerQueryBuilder();

  /// List all customers with filtering and pagination
  Future<PaginatedResponse<Customer>> list({
    CustomerQueryBuilder? queryBuilder,
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final finalQuery = queryBuilder?.build() ?? query;
    return client.fetch<PaginatedResponse<Customer>>(
      basePath,
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Search customers with a text query
  Future<PaginatedResponse<Customer>> search(
    String searchTerm, {
    CustomerQueryBuilder? queryBuilder,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = queryBuilder ?? CustomerQueryBuilder();
    builder.search(searchTerm);
    return list(
      queryBuilder: builder,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Retrieve a specific customer by ID
  Future<Customer> retrieve(
    String id, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
    return Customer.fromJson(response['customer']);
  }

  /// Create a new customer
  Future<Customer> create(
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
    );
    return Customer.fromJson(response['customer']);
  }

  /// Update an existing customer
  Future<Customer> update(
    String id,
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
    );
    return Customer.fromJson(response['customer']);
  }

  /// Delete a customer
  Future<DeleteResponse> delete(String id, {ClientHeaders? headers}) async {
    return client.fetch<DeleteResponse>(
      '$basePath/$id',
      method: 'DELETE',
      headers: headers,
    );
  }
}

// Additional admin resource classes would follow the same pattern...
// For brevity, I'm showing just the key ones, but the full implementation
// would include all the resources listed in the constructor

/// Placeholder admin resources (simplified implementations)
class _AdminUserResource extends _AdminResource {
  const _AdminUserResource(super.client);
  @override
  String get basePath => '/admin/users';

  /// Create a new query builder for users
  QueryBuilder query() => QueryBuilder();

  /// List all users with filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    QueryBuilder? queryBuilder,
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final finalQuery = queryBuilder?.build() ?? query;
    return client.fetch<PaginatedResponse<Map<String, dynamic>>>(
      basePath,
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );
  }

  /// Get a specific user by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );
    return response['user'];
  }

  /// Create a new user
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['user'];
  }

  /// Update an existing user
  Future<Map<String, dynamic>> update(
    String id,
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['user'];
  }

  /// Delete a user
  Future<DeleteResponse> delete(String id, {ClientHeaders? headers}) async {
    return client.fetch<DeleteResponse>(
      '$basePath/$id',
      method: 'DELETE',
      headers: headers,
      useCache: false,
    );
  }

  /// Search users by email or name
  Future<PaginatedResponse<Map<String, dynamic>>> search(
    String searchTerm, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final searchQuery = QueryBuilder().search(searchTerm).build();

    final finalQuery = {...?query, ...searchQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get users by role
  Future<PaginatedResponse<Map<String, dynamic>>> getByRole(
    String role, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final roleQuery = QueryBuilder().where('role', role).build();

    final finalQuery = {...?query, ...roleQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }
}

class _AdminRegionResource extends _AdminResource {
  const _AdminRegionResource(super.client);
  @override
  String get basePath => '/admin/regions';

  /// Create a new query builder for regions
  QueryBuilder query() => QueryBuilder();

  /// List all regions with filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    QueryBuilder? queryBuilder,
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final finalQuery = queryBuilder?.build() ?? query;
    return client.fetch<PaginatedResponse<Map<String, dynamic>>>(
      basePath,
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
  }

  /// Get a specific region by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 30),
    );
    return response['region'];
  }

  /// Create a new region
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['region'];
  }

  /// Update an existing region
  Future<Map<String, dynamic>> update(
    String id,
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['region'];
  }

  /// Delete a region
  Future<DeleteResponse> delete(String id, {ClientHeaders? headers}) async {
    return client.fetch<DeleteResponse>(
      '$basePath/$id',
      method: 'DELETE',
      headers: headers,
      useCache: false,
    );
  }

  /// Add countries to a region
  Future<Map<String, dynamic>> addCountries(
    String id,
    List<String> countryIds, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/countries',
      method: 'POST',
      body: {'country_codes': countryIds},
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['region'];
  }

  /// Remove countries from a region
  Future<Map<String, dynamic>> removeCountries(
    String id,
    List<String> countryIds, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/countries',
      method: 'DELETE',
      body: {'country_codes': countryIds},
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['region'];
  }

  /// Add payment providers to a region
  Future<Map<String, dynamic>> addPaymentProviders(
    String id,
    List<String> providerIds, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/payment-providers',
      method: 'POST',
      body: {'provider_ids': providerIds},
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['region'];
  }

  /// Remove payment providers from a region
  Future<Map<String, dynamic>> removePaymentProviders(
    String id,
    List<String> providerIds, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/payment-providers',
      method: 'DELETE',
      body: {'provider_ids': providerIds},
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['region'];
  }

  /// Add fulfillment providers to a region
  Future<Map<String, dynamic>> addFulfillmentProviders(
    String id,
    List<String> providerIds, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/fulfillment-providers',
      method: 'POST',
      body: {'provider_ids': providerIds},
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['region'];
  }

  /// Remove fulfillment providers from a region
  Future<Map<String, dynamic>> removeFulfillmentProviders(
    String id,
    List<String> providerIds, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/fulfillment-providers',
      method: 'DELETE',
      body: {'provider_ids': providerIds},
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['region'];
  }

  /// Get regions by currency code
  Future<PaginatedResponse<Map<String, dynamic>>> getByCurrency(
    String currencyCode, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final currencyQuery =
        QueryBuilder().where('currency_code', currencyCode).build();

    final finalQuery = {...?query, ...currencyQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }
}

class _AdminCollectionResource extends _AdminResource {
  const _AdminCollectionResource(super.client);
  @override
  String get basePath => '/admin/collections';

  /// Create a new query builder for collections
  QueryBuilder query() => QueryBuilder();

  /// List all collections with filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    QueryBuilder? queryBuilder,
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final finalQuery = queryBuilder?.build() ?? query;
    return client.fetch<PaginatedResponse<Map<String, dynamic>>>(
      basePath,
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get a specific collection by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
    return response['collection'];
  }

  /// Create a new collection
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['collection'];
  }

  /// Update a collection
  Future<Map<String, dynamic>> update(
    String id,
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['collection'];
  }

  /// Delete a collection
  Future<DeleteResponse> delete(String id, {ClientHeaders? headers}) async {
    return client.fetch<DeleteResponse>(
      '$basePath/$id',
      method: 'DELETE',
      headers: headers,
      useCache: false,
    );
  }

  /// Search collections by title or handle
  Future<PaginatedResponse<Map<String, dynamic>>> search(
    String query, {
    QueryParams? params,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final searchQuery = {'q': query, ...?params};
    return list(
      query: searchQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Add products to a collection
  Future<Map<String, dynamic>> addProducts(
    String id,
    List<String> productIds, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/products/batch',
      method: 'POST',
      body: {'product_ids': productIds},
      headers: headers,
      useCache: false,
    );
    return response['collection'];
  }

  /// Remove products from a collection
  Future<Map<String, dynamic>> removeProducts(
    String id,
    List<String> productIds, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/products/batch',
      method: 'DELETE',
      body: {'product_ids': productIds},
      headers: headers,
      useCache: false,
    );
    return response['collection'];
  }
}

class _AdminCategoryResource extends _AdminResource {
  const _AdminCategoryResource(super.client);
  @override
  String get basePath => '/admin/product-categories';

  /// Create a new query builder for categories
  QueryBuilder query() => QueryBuilder();

  /// List all categories with filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    QueryBuilder? queryBuilder,
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final finalQuery = queryBuilder?.build() ?? query;
    return client.fetch<PaginatedResponse<Map<String, dynamic>>>(
      basePath,
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );
  }

  /// Get a specific category by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
    return response['product_category'];
  }

  /// Create a new category
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['product_category'];
  }

  /// Update an existing category
  Future<Map<String, dynamic>> update(
    String id,
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['product_category'];
  }

  /// Delete a category
  Future<DeleteResponse> delete(String id, {ClientHeaders? headers}) async {
    return client.fetch<DeleteResponse>(
      '$basePath/$id',
      method: 'DELETE',
      headers: headers,
      useCache: false,
    );
  }

  /// Add products to a category
  Future<Map<String, dynamic>> addProducts(
    String id,
    List<String> productIds, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/products/batch',
      method: 'POST',
      body: {'product_ids': productIds},
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['product_category'];
  }

  /// Remove products from a category
  Future<Map<String, dynamic>> removeProducts(
    String id,
    List<String> productIds, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/products/batch',
      method: 'DELETE',
      body: {'product_ids': productIds},
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['product_category'];
  }

  /// Search categories by name or handle
  Future<PaginatedResponse<Map<String, dynamic>>> search(
    String searchTerm, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final searchQuery = QueryBuilder().search(searchTerm).build();

    final finalQuery = {...?query, ...searchQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get categories by parent ID
  Future<PaginatedResponse<Map<String, dynamic>>> getByParent(
    String? parentId, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final parentQuery =
        QueryBuilder().where('parent_category_id', parentId).build();

    final finalQuery = {...?query, ...parentQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get root categories (no parent)
  Future<PaginatedResponse<Map<String, dynamic>>> getRootCategories({
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    return getByParent(
      null,
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }
}

class _AdminInventoryResource extends _AdminResource {
  const _AdminInventoryResource(super.client);
  @override
  String get basePath => '/admin/inventory-items';

  /// Create a new query builder for inventory items
  QueryBuilder query() => QueryBuilder();

  /// List all inventory items with filtering and pagination
  Future<PaginatedResponse<InventoryItem>> list({
    QueryBuilder? queryBuilder,
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final finalQuery = queryBuilder?.build() ?? query;
    return client.fetch<PaginatedResponse<InventoryItem>>(
      basePath,
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get a specific inventory item by ID
  Future<InventoryItem> retrieve(
    String id, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
    return InventoryItem.fromJson(response['inventory_item']);
  }

  /// Create a new inventory item
  Future<InventoryItem> create(
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return InventoryItem.fromJson(response['inventory_item']);
  }

  /// Update an inventory item
  Future<InventoryItem> update(
    String id,
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return InventoryItem.fromJson(response['inventory_item']);
  }

  /// Delete an inventory item
  Future<DeleteResponse> delete(String id, {ClientHeaders? headers}) async {
    return client.fetch<DeleteResponse>(
      '$basePath/$id',
      method: 'DELETE',
      headers: headers,
      useCache: false,
    );
  }

  /// Search inventory items by SKU or title
  Future<PaginatedResponse<InventoryItem>> search(
    String query, {
    QueryParams? params,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final searchQuery = {'q': query, ...?params};
    return list(
      query: searchQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get inventory level for a location
  Future<InventoryLevel> getLevel(
    String id,
    String locationId, {
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/location-levels/$locationId',
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
    return InventoryLevel.fromJson(response['inventory_level']);
  }

  /// Update inventory level for a location
  Future<InventoryLevel> updateLevel(
    String id,
    String locationId,
    Map<String, dynamic> payload, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/location-levels/$locationId',
      method: 'POST',
      body: payload,
      headers: headers,
      useCache: false,
    );
    return InventoryLevel.fromJson(response['inventory_level']);
  }
}

class _AdminPriceListResource extends _AdminResource {
  const _AdminPriceListResource(super.client);
  @override
  String get basePath => '/admin/price-lists';

  /// Create a new query builder for price lists
  QueryBuilder query() => QueryBuilder();

  /// List all price lists with filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    QueryBuilder? queryBuilder,
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final finalQuery = queryBuilder?.build() ?? query;
    return client.fetch<PaginatedResponse<Map<String, dynamic>>>(
      basePath,
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get a specific price list by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
    return response['price_list'];
  }

  /// Create a new price list
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['price_list'];
  }

  /// Update a price list
  Future<Map<String, dynamic>> update(
    String id,
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['price_list'];
  }

  /// Delete a price list
  Future<DeleteResponse> delete(String id, {ClientHeaders? headers}) async {
    return client.fetch<DeleteResponse>(
      '$basePath/$id',
      method: 'DELETE',
      headers: headers,
      useCache: false,
    );
  }

  /// Search price lists by name or description
  Future<PaginatedResponse<Map<String, dynamic>>> search(
    String query, {
    QueryParams? params,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final searchQuery = {'q': query, ...?params};
    return list(
      query: searchQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get price lists by status
  Future<PaginatedResponse<Map<String, dynamic>>> byStatus(
    String status, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final statusQuery = {'status': status, ...?query};
    return list(
      query: statusQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get price lists by type
  Future<PaginatedResponse<Map<String, dynamic>>> byType(
    String type, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final typeQuery = {'type': type, ...?query};
    return list(
      query: typeQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Add products to a price list
  Future<Map<String, dynamic>> addProducts(
    String id,
    List<String> productIds, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/products/batch',
      method: 'POST',
      body: {'product_ids': productIds},
      headers: headers,
      useCache: false,
    );
    return response['price_list'];
  }

  /// Remove products from a price list
  Future<Map<String, dynamic>> removeProducts(
    String id,
    List<String> productIds, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/products/batch',
      method: 'DELETE',
      body: {'product_ids': productIds},
      headers: headers,
      useCache: false,
    );
    return response['price_list'];
  }
}

class _AdminDiscountResource extends _AdminResource {
  const _AdminDiscountResource(super.client);
  @override
  String get basePath => '/admin/discounts';

  /// Create a new query builder for discounts
  QueryBuilder query() => QueryBuilder();

  /// List all discounts with filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    QueryBuilder? queryBuilder,
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final finalQuery = queryBuilder?.build() ?? query;
    return client.fetch<PaginatedResponse<Map<String, dynamic>>>(
      basePath,
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get a specific discount by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
    return response['discount'];
  }

  /// Create a new discount
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['discount'];
  }

  /// Update a discount
  Future<Map<String, dynamic>> update(
    String id,
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['discount'];
  }

  /// Delete a discount
  Future<DeleteResponse> delete(String id, {ClientHeaders? headers}) async {
    return client.fetch<DeleteResponse>(
      '$basePath/$id',
      method: 'DELETE',
      headers: headers,
      useCache: false,
    );
  }

  /// Search discounts by code or description
  Future<PaginatedResponse<Map<String, dynamic>>> search(
    String query, {
    QueryParams? params,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final searchQuery = {'q': query, ...?params};
    return list(
      query: searchQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get discounts by type
  Future<PaginatedResponse<Map<String, dynamic>>> byType(
    String type, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final typeQuery = {'type': type, ...?query};
    return list(
      query: typeQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get active discounts
  Future<PaginatedResponse<Map<String, dynamic>>> active({
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final now = DateTime.now().toIso8601String();
    final activeQuery = {
      'starts_at[lte]': now,
      'ends_at[gte]': now,
      'is_disabled': false,
      ...?query,
    };
    return list(
      query: activeQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Add products to discount condition
  Future<Map<String, dynamic>> addProducts(
    String id,
    List<String> productIds, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/conditions/products/batch',
      method: 'POST',
      body: {'product_ids': productIds},
      headers: headers,
      useCache: false,
    );
    return response['discount'];
  }

  /// Remove products from discount condition
  Future<Map<String, dynamic>> removeProducts(
    String id,
    List<String> productIds, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/conditions/products/batch',
      method: 'DELETE',
      body: {'product_ids': productIds},
      headers: headers,
      useCache: false,
    );
    return response['discount'];
  }
}

class _AdminGiftCardResource extends _AdminResource {
  const _AdminGiftCardResource(super.client);
  @override
  String get basePath => '/admin/gift-cards';

  /// Create a new query builder for gift cards
  QueryBuilder query() => QueryBuilder();

  /// List all gift cards with filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    QueryBuilder? queryBuilder,
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final finalQuery = queryBuilder?.build() ?? query;
    return client.fetch<PaginatedResponse<Map<String, dynamic>>>(
      basePath,
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );
  }

  /// Get a specific gift card by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );
    return response['gift_card'];
  }

  /// Create a new gift card
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['gift_card'];
  }

  /// Update an existing gift card
  Future<Map<String, dynamic>> update(
    String id,
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['gift_card'];
  }

  /// Delete a gift card
  Future<DeleteResponse> delete(String id, {ClientHeaders? headers}) async {
    return client.fetch<DeleteResponse>(
      '$basePath/$id',
      method: 'DELETE',
      headers: headers,
      useCache: false,
    );
  }

  /// Search gift cards by code
  Future<PaginatedResponse<Map<String, dynamic>>> searchByCode(
    String code, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final searchQuery = QueryBuilder().where('code', code).build();

    final finalQuery = {...?query, ...searchQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get active gift cards
  Future<PaginatedResponse<Map<String, dynamic>>> getActive({
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final activeQuery = QueryBuilder().where('is_disabled', false).build();

    final finalQuery = {...?query, ...activeQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get disabled gift cards
  Future<PaginatedResponse<Map<String, dynamic>>> getDisabled({
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final disabledQuery = QueryBuilder().where('is_disabled', true).build();

    final finalQuery = {...?query, ...disabledQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get gift cards by region
  Future<PaginatedResponse<Map<String, dynamic>>> getByRegion(
    String regionId, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final regionQuery = QueryBuilder().where('region_id', regionId).build();

    final finalQuery = {...?query, ...regionQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Generate a custom gift card with code
  Future<Map<String, dynamic>> createCustom(
    String code,
    int value,
    String regionId, {
    bool? isDisabled,
    DateTime? endsAt,
    Map<String, dynamic>? metadata,
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final payload = <String, dynamic>{
      'type': 'custom',
      'code': code,
      'value': value,
      'region_id': regionId,
      if (isDisabled != null) 'is_disabled': isDisabled,
      if (endsAt != null) 'ends_at': endsAt.toIso8601String(),
      if (metadata != null) 'metadata': metadata,
    };

    return create(payload, query: query, headers: headers);
  }
}

class _AdminTaxResource extends _AdminResource {
  const _AdminTaxResource(super.client);
  @override
  String get basePath => '/admin/tax-rates';

  /// Create a new query builder for tax rates
  QueryBuilder query() => QueryBuilder();

  /// List all tax rates with filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    QueryBuilder? queryBuilder,
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final finalQuery = queryBuilder?.build() ?? query;
    return client.fetch<PaginatedResponse<Map<String, dynamic>>>(
      basePath,
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );
  }

  /// Get a specific tax rate by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
    return response['tax_rate'];
  }

  /// Create a new tax rate
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['tax_rate'];
  }

  /// Update an existing tax rate
  Future<Map<String, dynamic>> update(
    String id,
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['tax_rate'];
  }

  /// Delete a tax rate
  Future<DeleteResponse> delete(String id, {ClientHeaders? headers}) async {
    return client.fetch<DeleteResponse>(
      '$basePath/$id',
      method: 'DELETE',
      headers: headers,
      useCache: false,
    );
  }

  /// Add products to a tax rate
  Future<Map<String, dynamic>> addProducts(
    String id,
    List<String> productIds, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/products/batch',
      method: 'POST',
      body: {
        'products': productIds.map((id) => {'id': id}).toList(),
      },
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['tax_rate'];
  }

  /// Remove products from a tax rate
  Future<Map<String, dynamic>> removeProducts(
    String id,
    List<String> productIds, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/products/batch',
      method: 'DELETE',
      body: {
        'products': productIds.map((id) => {'id': id}).toList(),
      },
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['tax_rate'];
  }

  /// Add product types to a tax rate
  Future<Map<String, dynamic>> addProductTypes(
    String id,
    List<String> productTypeIds, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/product-types/batch',
      method: 'POST',
      body: {
        'product_types': productTypeIds.map((id) => {'id': id}).toList(),
      },
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['tax_rate'];
  }

  /// Remove product types from a tax rate
  Future<Map<String, dynamic>> removeProductTypes(
    String id,
    List<String> productTypeIds, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/product-types/batch',
      method: 'DELETE',
      body: {
        'product_types': productTypeIds.map((id) => {'id': id}).toList(),
      },
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['tax_rate'];
  }

  /// Add shipping options to a tax rate
  Future<Map<String, dynamic>> addShippingOptions(
    String id,
    List<String> shippingOptionIds, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/shipping-options/batch',
      method: 'POST',
      body: {
        'shipping_options': shippingOptionIds.map((id) => {'id': id}).toList(),
      },
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['tax_rate'];
  }

  /// Remove shipping options from a tax rate
  Future<Map<String, dynamic>> removeShippingOptions(
    String id,
    List<String> shippingOptionIds, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/shipping-options/batch',
      method: 'DELETE',
      body: {
        'shipping_options': shippingOptionIds.map((id) => {'id': id}).toList(),
      },
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['tax_rate'];
  }

  /// Get tax rates by region
  Future<PaginatedResponse<Map<String, dynamic>>> getByRegion(
    String regionId, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final regionQuery = QueryBuilder().where('region_id', regionId).build();

    final finalQuery = {...?query, ...regionQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }
}

class _AdminShippingResource extends _AdminResource {
  const _AdminShippingResource(super.client);
  @override
  String get basePath => '/admin/shipping-options';

  /// Create a new query builder for shipping options
  QueryBuilder query() => QueryBuilder();

  /// List all shipping options with filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    QueryBuilder? queryBuilder,
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final finalQuery = queryBuilder?.build() ?? query;
    return client.fetch<PaginatedResponse<Map<String, dynamic>>>(
      basePath,
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );
  }

  /// Get a specific shipping option by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
    return response['shipping_option'];
  }

  /// Create a new shipping option
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['shipping_option'];
  }

  /// Update an existing shipping option
  Future<Map<String, dynamic>> update(
    String id,
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['shipping_option'];
  }

  /// Delete a shipping option
  Future<DeleteResponse> delete(String id, {ClientHeaders? headers}) async {
    return client.fetch<DeleteResponse>(
      '$basePath/$id',
      method: 'DELETE',
      headers: headers,
      useCache: false,
    );
  }

  /// Get shipping options by region
  Future<PaginatedResponse<Map<String, dynamic>>> getByRegion(
    String regionId, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final regionQuery = QueryBuilder().where('region_id', regionId).build();

    final finalQuery = {...?query, ...regionQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get shipping options by profile
  Future<PaginatedResponse<Map<String, dynamic>>> getByProfile(
    String profileId, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final profileQuery = QueryBuilder().where('profile_id', profileId).build();

    final finalQuery = {...?query, ...profileQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get active shipping options
  Future<PaginatedResponse<Map<String, dynamic>>> getActive({
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final activeQuery = QueryBuilder().where('is_return', false).build();

    final finalQuery = {...?query, ...activeQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get return shipping options
  Future<PaginatedResponse<Map<String, dynamic>>> getReturns({
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final returnQuery = QueryBuilder().where('is_return', true).build();

    final finalQuery = {...?query, ...returnQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get shipping profiles
  Future<PaginatedResponse<Map<String, dynamic>>> getProfiles({
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    return client.fetch<PaginatedResponse<Map<String, dynamic>>>(
      '/admin/shipping-profiles',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
  }

  /// Get a specific shipping profile by ID
  Future<Map<String, dynamic>> getProfile(
    String id, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '/admin/shipping-profiles/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 20),
    );
    return response['shipping_profile'];
  }

  /// Create a new shipping profile
  Future<Map<String, dynamic>> createProfile(
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '/admin/shipping-profiles',
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['shipping_profile'];
  }

  /// Update a shipping profile
  Future<Map<String, dynamic>> updateProfile(
    String id,
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '/admin/shipping-profiles/$id',
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['shipping_profile'];
  }

  /// Delete a shipping profile
  Future<DeleteResponse> deleteProfile(
    String id, {
    ClientHeaders? headers,
  }) async {
    return client.fetch<DeleteResponse>(
      '/admin/shipping-profiles/$id',
      method: 'DELETE',
      headers: headers,
      useCache: false,
    );
  }
}

class _AdminPaymentResource extends _AdminResource {
  const _AdminPaymentResource(super.client);
  @override
  String get basePath => '/admin/payments';

  /// Create a new query builder for payments
  QueryBuilder query() => QueryBuilder();

  /// List all payments with filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    QueryBuilder? queryBuilder,
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final finalQuery = queryBuilder?.build() ?? query;
    return client.fetch<PaginatedResponse<Map<String, dynamic>>>(
      basePath,
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );
  }

  /// Get a specific payment by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );
    return response['payment'];
  }

  /// Capture a payment
  Future<Map<String, dynamic>> capture(
    String id, {
    int? amount,
    ClientHeaders? headers,
  }) async {
    final body = <String, dynamic>{};
    if (amount != null) body['amount'] = amount;

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/capture',
      method: 'POST',
      body: body,
      headers: headers,
      useCache: false,
    );
    return response['payment'];
  }

  /// Refund a payment
  Future<Map<String, dynamic>> refund(
    String id, {
    int? amount,
    String? reason,
    String? note,
    ClientHeaders? headers,
  }) async {
    final body = <String, dynamic>{};
    if (amount != null) body['amount'] = amount;
    if (reason != null) body['reason'] = reason;
    if (note != null) body['note'] = note;

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/refund',
      method: 'POST',
      body: body,
      headers: headers,
      useCache: false,
    );
    return response['refund'];
  }

  /// Cancel a payment
  Future<Map<String, dynamic>> cancel(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/cancel',
      method: 'POST',
      headers: headers,
      useCache: false,
    );
    return response['payment'];
  }

  /// Get payments by order
  Future<PaginatedResponse<Map<String, dynamic>>> getByOrder(
    String orderId, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final orderQuery = QueryBuilder().where('order_id', orderId).build();

    final finalQuery = {...?query, ...orderQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get payments by status
  Future<PaginatedResponse<Map<String, dynamic>>> getByStatus(
    String status, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final statusQuery =
        QueryBuilder()
            .where('status', status)
            .orderBy('created_at', ascending: false)
            .build();

    final finalQuery = {...?query, ...statusQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get captured payments
  Future<PaginatedResponse<Map<String, dynamic>>> getCaptured({
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    return getByStatus(
      'captured',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get pending payments
  Future<PaginatedResponse<Map<String, dynamic>>> getPending({
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    return getByStatus(
      'awaiting',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get payment providers
  Future<List<Map<String, dynamic>>> getProviders({
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '/admin/payment-providers',
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 30),
    );
    return List<Map<String, dynamic>>.from(response['payment_providers'] ?? []);
  }
}

class _AdminStoreResource extends _AdminResource {
  const _AdminStoreResource(super.client);
  @override
  String get basePath => '/admin/store';

  /// Get store details
  Future<Map<String, dynamic>> retrieve({
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 30),
    );
    return response['store'];
  }

  /// Update store details
  Future<Map<String, dynamic>> update(
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['store'];
  }

  /// Add currencies to the store
  Future<Map<String, dynamic>> addCurrencies(
    List<String> currencyCodes, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/currencies',
      method: 'POST',
      body: {'currency_codes': currencyCodes},
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['store'];
  }

  /// Remove currencies from the store
  Future<Map<String, dynamic>> removeCurrencies(
    List<String> currencyCodes, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/currencies',
      method: 'DELETE',
      body: {'currency_codes': currencyCodes},
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['store'];
  }

  /// Update store payment providers
  Future<Map<String, dynamic>> updatePaymentProviders(
    List<String> providerIds, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/payment-providers',
      method: 'POST',
      body: {'provider_ids': providerIds},
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['store'];
  }

  /// Update store tax providers
  Future<Map<String, dynamic>> updateTaxProviders(
    List<String> providerIds, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/tax-providers',
      method: 'POST',
      body: {'provider_ids': providerIds},
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['store'];
  }

  /// Get store extended details with relations
  Future<Map<String, dynamic>> getExtended({
    List<String>? expand,
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final expandQuery =
        expand != null
            ? QueryBuilder().expand(expand).build()
            : <String, dynamic>{};

    final finalQuery = {...?query, ...expandQuery};
    return retrieve(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get store with all relations
  Future<Map<String, dynamic>> getWithAllRelations({
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    return getExtended(
      expand: [
        'currencies',
        'default_currency',
        'default_region',
        'regions',
        'regions.countries',
        'regions.payment_providers',
        'regions.fulfillment_providers',
        'regions.currency',
        'payment_providers',
        'tax_providers',
      ],
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get available payment providers
  Future<List<Map<String, dynamic>>> getAvailablePaymentProviders({
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '/admin/store/payment-providers',
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 60),
    );
    return List<Map<String, dynamic>>.from(response['payment_providers'] ?? []);
  }

  /// Get available tax providers
  Future<List<Map<String, dynamic>>> getAvailableTaxProviders({
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '/admin/store/tax-providers',
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 60),
    );
    return List<Map<String, dynamic>>.from(response['tax_providers'] ?? []);
  }
}

class _AdminCurrencyResource extends _AdminResource {
  const _AdminCurrencyResource(super.client);
  @override
  String get basePath => '/admin/currencies';

  /// Create a new query builder for currencies
  QueryBuilder query() => QueryBuilder();

  /// List all currencies with filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    QueryBuilder? queryBuilder,
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final finalQuery = queryBuilder?.build() ?? query;
    return client.fetch<PaginatedResponse<Map<String, dynamic>>>(
      basePath,
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(hours: 1),
    );
  }

  /// Get a specific currency by code
  Future<Map<String, dynamic>> retrieve(
    String code, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$code',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(hours: 2),
    );
    return response['currency'];
  }

  /// Update a currency
  Future<Map<String, dynamic>> update(
    String code,
    Map<String, dynamic> payload, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$code',
      method: 'POST',
      body: payload,
      query: query,
      headers: headers,
      useCache: false,
    );
    return response['currency'];
  }

  /// Get all available currencies (from external API)
  Future<List<Map<String, dynamic>>> getAvailable({
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/available',
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(hours: 6),
    );
    return List<Map<String, dynamic>>.from(response['currencies'] ?? []);
  }

  /// Search currencies by name or code
  Future<PaginatedResponse<Map<String, dynamic>>> search(
    String searchTerm, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final searchQuery = QueryBuilder().search(searchTerm).build();

    final finalQuery = {...?query, ...searchQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get store currencies only
  Future<PaginatedResponse<Map<String, dynamic>>> getStoreCurrencies({
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final storeQuery = QueryBuilder().where('includes_tax', true).build();

    final finalQuery = {...?query, ...storeQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }
}

class _AdminAnalyticsResource extends _AdminResource {
  const _AdminAnalyticsResource(super.client);
  @override
  String get basePath => '/admin/analytics';

  /// Get order analytics
  Future<Map<String, dynamic>> getOrderAnalytics({
    DateTime? dateRangeFrom,
    DateTime? dateRangeTo,
    String? currencyCode,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query = <String, dynamic>{};
    if (dateRangeFrom != null) {
      query['date_range_from'] = dateRangeFrom.toIso8601String();
    }
    if (dateRangeTo != null) {
      query['date_range_to'] = dateRangeTo.toIso8601String();
    }
    if (currencyCode != null) {
      query['currency_code'] = currencyCode;
    }

    return client.fetch<Map<String, dynamic>>(
      '$basePath/orders',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
  }

  /// Get variant analytics
  Future<Map<String, dynamic>> getVariantAnalytics({
    DateTime? dateRangeFrom,
    DateTime? dateRangeTo,
    String? currencyCode,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query = <String, dynamic>{};
    if (dateRangeFrom != null) {
      query['date_range_from'] = dateRangeFrom.toIso8601String();
    }
    if (dateRangeTo != null) {
      query['date_range_to'] = dateRangeTo.toIso8601String();
    }
    if (currencyCode != null) {
      query['currency_code'] = currencyCode;
    }

    return client.fetch<Map<String, dynamic>>(
      '$basePath/variants',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
  }

  /// Get product analytics
  Future<Map<String, dynamic>> getProductAnalytics({
    DateTime? dateRangeFrom,
    DateTime? dateRangeTo,
    String? currencyCode,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query = <String, dynamic>{};
    if (dateRangeFrom != null) {
      query['date_range_from'] = dateRangeFrom.toIso8601String();
    }
    if (dateRangeTo != null) {
      query['date_range_to'] = dateRangeTo.toIso8601String();
    }
    if (currencyCode != null) {
      query['currency_code'] = currencyCode;
    }

    return client.fetch<Map<String, dynamic>>(
      '$basePath/products',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
  }

  /// Get customer analytics
  Future<Map<String, dynamic>> getCustomerAnalytics({
    DateTime? dateRangeFrom,
    DateTime? dateRangeTo,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query = <String, dynamic>{};
    if (dateRangeFrom != null) {
      query['date_range_from'] = dateRangeFrom.toIso8601String();
    }
    if (dateRangeTo != null) {
      query['date_range_to'] = dateRangeTo.toIso8601String();
    }

    return client.fetch<Map<String, dynamic>>(
      '$basePath/customers',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
  }

  /// Get revenue analytics
  Future<Map<String, dynamic>> getRevenueAnalytics({
    DateTime? dateRangeFrom,
    DateTime? dateRangeTo,
    String? currencyCode,
    String? period = 'day', // day, week, month, year
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query = <String, dynamic>{};
    if (dateRangeFrom != null) {
      query['date_range_from'] = dateRangeFrom.toIso8601String();
    }
    if (dateRangeTo != null) {
      query['date_range_to'] = dateRangeTo.toIso8601String();
    }
    if (currencyCode != null) {
      query['currency_code'] = currencyCode;
    }
    if (period != null) {
      query['period'] = period;
    }

    return client.fetch<Map<String, dynamic>>(
      '$basePath/revenue',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );
  }

  /// Get sales analytics
  Future<Map<String, dynamic>> getSalesAnalytics({
    DateTime? dateRangeFrom,
    DateTime? dateRangeTo,
    String? period = 'day', // day, week, month, year
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query = <String, dynamic>{};
    if (dateRangeFrom != null) {
      query['date_range_from'] = dateRangeFrom.toIso8601String();
    }
    if (dateRangeTo != null) {
      query['date_range_to'] = dateRangeTo.toIso8601String();
    }
    if (period != null) {
      query['period'] = period;
    }

    return client.fetch<Map<String, dynamic>>(
      '$basePath/sales',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );
  }
}

class _AdminReturnResource extends _AdminResource {
  const _AdminReturnResource(super.client);
  @override
  String get basePath => '/admin/returns';

  /// List returns with advanced filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    int? limit,
    int? offset,
    List<String>? expand,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (query != null) {
      builder.whereAll(query);
    }

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['returns'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Get return by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query =
        expand != null && expand.isNotEmpty
            ? QueryBuilder().expand(expand).build()
            : <String, dynamic>{};

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );
    return response['return'];
  }

  /// Cancel a return
  Future<Map<String, dynamic>> cancel(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/cancel',
      method: 'POST',
      headers: headers,
      useCache: false,
    );
    return response['return'];
  }

  /// Receive items from a return
  Future<Map<String, dynamic>> receive(
    String id, {
    required List<Map<String, dynamic>> items,
    Map<String, dynamic>? locationId,
    String? note,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/receive',
      method: 'POST',
      body: {
        'items': items,
        if (locationId != null) 'location_id': locationId,
        if (note != null) 'note': note,
      },
      headers: headers,
      useCache: false,
    );
    return response['return'];
  }

  /// List returns by order
  Future<PaginatedResponse<Map<String, dynamic>>> listByOrder(
    String orderId, {
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? [])
        .where('order_id', orderId);

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['returns'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Search returns by various criteria
  Future<PaginatedResponse<Map<String, dynamic>>> search({
    String? searchTerm,
    String? status,
    String? orderId,
    String? customerId,
    DateTime? createdAfter,
    DateTime? createdBefore,
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (searchTerm != null && searchTerm.isNotEmpty) {
      builder.where('q', searchTerm);
    }
    if (status != null) {
      builder.where('status', status);
    }
    if (orderId != null) {
      builder.where('order_id', orderId);
    }
    if (customerId != null) {
      builder.where('customer_id', customerId);
    }
    if (createdAfter != null) {
      builder.where('created_at[gte]', createdAfter.toIso8601String());
    }
    if (createdBefore != null) {
      builder.where('created_at[lte]', createdBefore.toIso8601String());
    }

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['returns'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Get return statistics
  Future<Map<String, dynamic>> getStatistics({
    DateTime? startDate,
    DateTime? endDate,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder();

    if (startDate != null) {
      builder.where('start_date', startDate.toIso8601String());
    }
    if (endDate != null) {
      builder.where('end_date', endDate.toIso8601String());
    }

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/statistics',
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
    return response['statistics'];
  }
}

class _AdminSwapResource extends _AdminResource {
  const _AdminSwapResource(super.client);
  @override
  String get basePath => '/admin/swaps';

  /// List swaps with advanced filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    int? limit,
    int? offset,
    List<String>? expand,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (query != null) {
      builder.whereAll(query);
    }

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['swaps'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Get swap by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query =
        expand != null && expand.isNotEmpty
            ? QueryBuilder().expand(expand).build()
            : <String, dynamic>{};

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );
    return response['swap'];
  }

  /// Create a swap
  Future<Map<String, dynamic>> create({
    required String orderId,
    required List<Map<String, dynamic>> returnItems,
    List<Map<String, dynamic>>? additionalItems,
    Map<String, dynamic>? customShippingOptions,
    bool? allowBackorder,
    String? note,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: {
        'order_id': orderId,
        'return_items': returnItems,
        if (additionalItems != null) 'additional_items': additionalItems,
        if (customShippingOptions != null)
          'custom_shipping_options': customShippingOptions,
        if (allowBackorder != null) 'allow_backorder': allowBackorder,
        if (note != null) 'note': note,
      },
      headers: headers,
      useCache: false,
    );
    return response['swap'];
  }

  /// Cancel a swap
  Future<Map<String, dynamic>> cancel(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/cancel',
      method: 'POST',
      headers: headers,
      useCache: false,
    );
    return response['swap'];
  }

  /// Fulfill a swap
  Future<Map<String, dynamic>> createFulfillment(
    String id, {
    Map<String, dynamic>? metadata,
    bool? noNotification,
    List<String>? locationId,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/fulfillments',
      method: 'POST',
      body: {
        if (metadata != null) 'metadata': metadata,
        if (noNotification != null) 'no_notification': noNotification,
        if (locationId != null) 'location_id': locationId,
      },
      headers: headers,
      useCache: false,
    );
    return response['swap'];
  }

  /// Cancel swap fulfillment
  Future<Map<String, dynamic>> cancelFulfillment(
    String id,
    String fulfillmentId, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/fulfillments/$fulfillmentId/cancel',
      method: 'POST',
      headers: headers,
      useCache: false,
    );
    return response['swap'];
  }

  /// Process swap payment
  Future<Map<String, dynamic>> processPayment(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/process-payment',
      method: 'POST',
      headers: headers,
      useCache: false,
    );
    return response['swap'];
  }

  /// Search swaps by various criteria
  Future<PaginatedResponse<Map<String, dynamic>>> search({
    String? searchTerm,
    String? status,
    String? orderId,
    String? customerId,
    String? paymentStatus,
    String? fulfillmentStatus,
    DateTime? createdAfter,
    DateTime? createdBefore,
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (searchTerm != null && searchTerm.isNotEmpty) {
      builder.where('q', searchTerm);
    }
    if (status != null) {
      builder.where('status', status);
    }
    if (orderId != null) {
      builder.where('order_id', orderId);
    }
    if (customerId != null) {
      builder.where('customer_id', customerId);
    }
    if (paymentStatus != null) {
      builder.where('payment_status', paymentStatus);
    }
    if (fulfillmentStatus != null) {
      builder.where('fulfillment_status', fulfillmentStatus);
    }
    if (createdAfter != null) {
      builder.where('created_at[gte]', createdAfter.toIso8601String());
    }
    if (createdBefore != null) {
      builder.where('created_at[lte]', createdBefore.toIso8601String());
    }

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['swaps'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// List swaps by order
  Future<PaginatedResponse<Map<String, dynamic>>> listByOrder(
    String orderId, {
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? [])
        .where('order_id', orderId);

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['swaps'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }
}

class _AdminFulfillmentResource extends _AdminResource {
  const _AdminFulfillmentResource(super.client);
  @override
  String get basePath => '/admin/fulfillments';

  /// List fulfillments with advanced filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    int? limit,
    int? offset,
    List<String>? expand,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (query != null) {
      builder.whereAll(query);
    }

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['fulfillments'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Get fulfillment by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query =
        expand != null && expand.isNotEmpty
            ? QueryBuilder().expand(expand).build()
            : <String, dynamic>{};

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );
    return response['fulfillment'];
  }

  /// Cancel a fulfillment
  Future<Map<String, dynamic>> cancel(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/cancel',
      method: 'POST',
      headers: headers,
      useCache: false,
    );
    return response['fulfillment'];
  }

  /// Create shipment for fulfillment
  Future<Map<String, dynamic>> createShipment(
    String id, {
    required String trackingNumber,
    Map<String, dynamic>? trackingUrls,
    bool? noNotification,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/shipment',
      method: 'POST',
      body: {
        'tracking_number': trackingNumber,
        if (trackingUrls != null) 'tracking_urls': trackingUrls,
        if (noNotification != null) 'no_notification': noNotification,
      },
      headers: headers,
      useCache: false,
    );
    return response['fulfillment'];
  }

  /// Search fulfillments by various criteria
  Future<PaginatedResponse<Map<String, dynamic>>> search({
    String? searchTerm,
    String? orderId,
    String? claimOrderId,
    String? swapId,
    String? providerId,
    String? locationId,
    DateTime? createdAfter,
    DateTime? createdBefore,
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (searchTerm != null && searchTerm.isNotEmpty) {
      builder.where('q', searchTerm);
    }
    if (orderId != null) {
      builder.where('order_id', orderId);
    }
    if (claimOrderId != null) {
      builder.where('claim_order_id', claimOrderId);
    }
    if (swapId != null) {
      builder.where('swap_id', swapId);
    }
    if (providerId != null) {
      builder.where('provider_id', providerId);
    }
    if (locationId != null) {
      builder.where('location_id', locationId);
    }
    if (createdAfter != null) {
      builder.where('created_at[gte]', createdAfter.toIso8601String());
    }
    if (createdBefore != null) {
      builder.where('created_at[lte]', createdBefore.toIso8601String());
    }

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['fulfillments'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// List fulfillments by order
  Future<PaginatedResponse<Map<String, dynamic>>> listByOrder(
    String orderId, {
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? [])
        .where('order_id', orderId);

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['fulfillments'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// List fulfillments by provider
  Future<PaginatedResponse<Map<String, dynamic>>> listByProvider(
    String providerId, {
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? [])
        .where('provider_id', providerId);

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['fulfillments'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Get fulfillment options
  Future<List<Map<String, dynamic>>> getFulfillmentOptions({
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/options',
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 30),
    );
    return List<Map<String, dynamic>>.from(
      response['fulfillment_options'] ?? [],
    );
  }
}

class _AdminReservationResource extends _AdminResource {
  const _AdminReservationResource(super.client);
  @override
  String get basePath => '/admin/reservations';

  /// List reservations with advanced filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    int? limit,
    int? offset,
    List<String>? expand,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (query != null) {
      builder.whereAll(query);
    }

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['reservations'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Get reservation by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query =
        expand != null && expand.isNotEmpty
            ? QueryBuilder().expand(expand).build()
            : <String, dynamic>{};

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );
    return response['reservation'];
  }

  /// Create a reservation
  Future<Map<String, dynamic>> create({
    required String inventoryItemId,
    required String locationId,
    required int quantity,
    String? lineItemId,
    String? description,
    Map<String, dynamic>? metadata,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: {
        'inventory_item_id': inventoryItemId,
        'location_id': locationId,
        'quantity': quantity,
        if (lineItemId != null) 'line_item_id': lineItemId,
        if (description != null) 'description': description,
        if (metadata != null) 'metadata': metadata,
      },
      headers: headers,
      useCache: false,
    );
    return response['reservation'];
  }

  /// Update a reservation
  Future<Map<String, dynamic>> update(
    String id, {
    int? quantity,
    String? description,
    Map<String, dynamic>? metadata,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'POST',
      body: {
        if (quantity != null) 'quantity': quantity,
        if (description != null) 'description': description,
        if (metadata != null) 'metadata': metadata,
      },
      headers: headers,
      useCache: false,
    );
    return response['reservation'];
  }

  /// Delete a reservation
  Future<Map<String, dynamic>> delete(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'DELETE',
      headers: headers,
      useCache: false,
    );
    return response;
  }

  /// Search reservations
  Future<PaginatedResponse<Map<String, dynamic>>> search({
    String? inventoryItemId,
    String? locationId,
    String? lineItemId,
    DateTime? createdAfter,
    DateTime? createdBefore,
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (inventoryItemId != null) {
      builder.where('inventory_item_id', inventoryItemId);
    }
    if (locationId != null) {
      builder.where('location_id', locationId);
    }
    if (lineItemId != null) {
      builder.where('line_item_id', lineItemId);
    }
    if (createdAfter != null) {
      builder.where('created_at[gte]', createdAfter.toIso8601String());
    }
    if (createdBefore != null) {
      builder.where('created_at[lte]', createdBefore.toIso8601String());
    }

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['reservations'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// List reservations by inventory item
  Future<PaginatedResponse<Map<String, dynamic>>> listByInventoryItem(
    String inventoryItemId, {
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    return search(
      inventoryItemId: inventoryItemId,
      limit: limit,
      offset: offset,
      expand: expand,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// List reservations by location
  Future<PaginatedResponse<Map<String, dynamic>>> listByLocation(
    String locationId, {
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    return search(
      locationId: locationId,
      limit: limit,
      offset: offset,
      expand: expand,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }
}

class _AdminSalesChannelResource extends _AdminResource {
  const _AdminSalesChannelResource(super.client);
  @override
  String get basePath => '/admin/sales-channels';

  /// List sales channels with advanced filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    int? limit,
    int? offset,
    List<String>? expand,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (query != null) {
      builder.whereAll(query);
    }

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['sales_channels'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Get sales channel by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query =
        expand != null && expand.isNotEmpty
            ? QueryBuilder().expand(expand).build()
            : <String, dynamic>{};

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
    return response['sales_channel'];
  }

  /// Create a sales channel
  Future<Map<String, dynamic>> create({
    required String name,
    String? description,
    bool? isDisabled,
    Map<String, dynamic>? metadata,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: {
        'name': name,
        if (description != null) 'description': description,
        if (isDisabled != null) 'is_disabled': isDisabled,
        if (metadata != null) 'metadata': metadata,
      },
      headers: headers,
      useCache: false,
    );
    return response['sales_channel'];
  }

  /// Update a sales channel
  Future<Map<String, dynamic>> update(
    String id, {
    String? name,
    String? description,
    bool? isDisabled,
    Map<String, dynamic>? metadata,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'POST',
      body: {
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        if (isDisabled != null) 'is_disabled': isDisabled,
        if (metadata != null) 'metadata': metadata,
      },
      headers: headers,
      useCache: false,
    );
    return response['sales_channel'];
  }

  /// Delete a sales channel
  Future<Map<String, dynamic>> delete(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'DELETE',
      headers: headers,
      useCache: false,
    );
    return response;
  }

  /// Add products to sales channel
  Future<Map<String, dynamic>> addProducts(
    String id, {
    required List<String> productIds,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/products/batch',
      method: 'POST',
      body: {'product_ids': productIds},
      headers: headers,
      useCache: false,
    );
    return response['sales_channel'];
  }

  /// Remove products from sales channel
  Future<Map<String, dynamic>> removeProducts(
    String id, {
    required List<String> productIds,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/products/batch',
      method: 'DELETE',
      body: {'product_ids': productIds},
      headers: headers,
      useCache: false,
    );
    return response['sales_channel'];
  }

  /// List products in sales channel
  Future<PaginatedResponse<Map<String, dynamic>>> listProducts(
    String id, {
    int? limit,
    int? offset,
    List<String>? expand,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (query != null) {
      builder.whereAll(query);
    }

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/products',
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['products'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Search sales channels
  Future<PaginatedResponse<Map<String, dynamic>>> search({
    String? searchTerm,
    String? name,
    bool? isDisabled,
    DateTime? createdAfter,
    DateTime? createdBefore,
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (searchTerm != null && searchTerm.isNotEmpty) {
      builder.where('q', searchTerm);
    }
    if (name != null) {
      builder.where('name', name);
    }
    if (isDisabled != null) {
      builder.where('is_disabled', isDisabled);
    }
    if (createdAfter != null) {
      builder.where('created_at[gte]', createdAfter.toIso8601String());
    }
    if (createdBefore != null) {
      builder.where('created_at[lte]', createdBefore.toIso8601String());
    }

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['sales_channels'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// List active sales channels
  Future<PaginatedResponse<Map<String, dynamic>>> listActive({
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    return search(
      isDisabled: false,
      limit: limit,
      offset: offset,
      expand: expand,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get sales channel statistics
  Future<Map<String, dynamic>> getStatistics(
    String id, {
    DateTime? startDate,
    DateTime? endDate,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder();

    if (startDate != null) {
      builder.where('start_date', startDate.toIso8601String());
    }
    if (endDate != null) {
      builder.where('end_date', endDate.toIso8601String());
    }

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/statistics',
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
    return response['statistics'];
  }
}

class _AdminStockLocationResource extends _AdminResource {
  const _AdminStockLocationResource(super.client);
  @override
  String get basePath => '/admin/stock-locations';

  /// List stock locations with advanced filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    int? limit,
    int? offset,
    List<String>? expand,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (query != null) {
      builder.whereAll(query);
    }

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['stock_locations'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Get stock location by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query =
        expand != null && expand.isNotEmpty
            ? QueryBuilder().expand(expand).build()
            : <String, dynamic>{};

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
    return response['stock_location'];
  }

  /// Create a stock location
  Future<Map<String, dynamic>> create({
    required String name,
    Map<String, dynamic>? address,
    Map<String, dynamic>? metadata,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: {
        'name': name,
        if (address != null) 'address': address,
        if (metadata != null) 'metadata': metadata,
      },
      headers: headers,
      useCache: false,
    );
    return response['stock_location'];
  }

  /// Update a stock location
  Future<Map<String, dynamic>> update(
    String id, {
    String? name,
    Map<String, dynamic>? address,
    Map<String, dynamic>? metadata,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'POST',
      body: {
        if (name != null) 'name': name,
        if (address != null) 'address': address,
        if (metadata != null) 'metadata': metadata,
      },
      headers: headers,
      useCache: false,
    );
    return response['stock_location'];
  }

  /// Delete a stock location
  Future<Map<String, dynamic>> delete(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'DELETE',
      headers: headers,
      useCache: false,
    );
    return response;
  }

  /// Get inventory levels for a stock location
  Future<PaginatedResponse<Map<String, dynamic>>> getInventoryLevels(
    String id, {
    int? limit,
    int? offset,
    List<String>? expand,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (query != null) {
      builder.whereAll(query);
    }

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/inventory-levels',
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['inventory_levels'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Update inventory level for a specific item at this location
  Future<Map<String, dynamic>> updateInventoryLevel(
    String id,
    String inventoryItemId, {
    int? stockedQuantity,
    int? incomingQuantity,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/inventory-levels/$inventoryItemId',
      method: 'POST',
      body: {
        if (stockedQuantity != null) 'stocked_quantity': stockedQuantity,
        if (incomingQuantity != null) 'incoming_quantity': incomingQuantity,
      },
      headers: headers,
      useCache: false,
    );
    return response['inventory_level'];
  }

  /// Get fulfillment sets for a stock location
  Future<PaginatedResponse<Map<String, dynamic>>> getFulfillmentSets(
    String id, {
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/fulfillment-sets',
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['fulfillment_sets'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Search stock locations
  Future<PaginatedResponse<Map<String, dynamic>>> search({
    String? searchTerm,
    String? name,
    String? address,
    DateTime? createdAfter,
    DateTime? createdBefore,
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (searchTerm != null && searchTerm.isNotEmpty) {
      builder.where('q', searchTerm);
    }
    if (name != null) {
      builder.where('name', name);
    }
    if (address != null) {
      builder.where('address', address);
    }
    if (createdAfter != null) {
      builder.where('created_at[gte]', createdAfter.toIso8601String());
    }
    if (createdBefore != null) {
      builder.where('created_at[lte]', createdBefore.toIso8601String());
    }

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['stock_locations'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Get stock location analytics
  Future<Map<String, dynamic>> getAnalytics(
    String id, {
    DateTime? startDate,
    DateTime? endDate,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder();

    if (startDate != null) {
      builder.where('start_date', startDate.toIso8601String());
    }
    if (endDate != null) {
      builder.where('end_date', endDate.toIso8601String());
    }

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/analytics',
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
    return response['analytics'];
  }

  /// Transfer inventory between locations
  Future<Map<String, dynamic>> transferInventory({
    required String fromLocationId,
    required String toLocationId,
    required String inventoryItemId,
    required int quantity,
    String? note,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/transfer',
      method: 'POST',
      body: {
        'from_location_id': fromLocationId,
        'to_location_id': toLocationId,
        'inventory_item_id': inventoryItemId,
        'quantity': quantity,
        if (note != null) 'note': note,
      },
      headers: headers,
      useCache: false,
    );
    return response['transfer'];
  }
}

class _AdminWorkflowResource extends _AdminResource {
  const _AdminWorkflowResource(super.client);
  @override
  String get basePath => '/admin/workflows';

  /// List workflows with advanced filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    int? limit,
    int? offset,
    List<String>? expand,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (query != null) {
      builder.whereAll(query);
    }

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['workflows'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Get workflow by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query =
        expand != null && expand.isNotEmpty
            ? QueryBuilder().expand(expand).build()
            : <String, dynamic>{};

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
    return response['workflow'];
  }

  /// Execute a workflow
  Future<Map<String, dynamic>> execute(
    String id, {
    Map<String, dynamic>? input,
    String? transactionId,
    bool? async,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/run',
      method: 'POST',
      body: {
        if (input != null) 'input': input,
        if (transactionId != null) 'transaction_id': transactionId,
        if (async != null) 'async': async,
      },
      headers: headers,
      useCache: false,
    );
    return response['execution'];
  }

  /// Get workflow execution
  Future<Map<String, dynamic>> getExecution(
    String workflowId,
    String executionId, {
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query =
        expand != null && expand.isNotEmpty
            ? QueryBuilder().expand(expand).build()
            : <String, dynamic>{};

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$workflowId/executions/$executionId',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );
    return response['execution'];
  }

  /// List workflow executions
  Future<PaginatedResponse<Map<String, dynamic>>> listExecutions(
    String workflowId, {
    int? limit,
    int? offset,
    List<String>? expand,
    String? status,
    DateTime? createdAfter,
    DateTime? createdBefore,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (status != null) {
      builder.where('status', status);
    }
    if (createdAfter != null) {
      builder.where('created_at[gte]', createdAfter.toIso8601String());
    }
    if (createdBefore != null) {
      builder.where('created_at[lte]', createdBefore.toIso8601String());
    }

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$workflowId/executions',
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['executions'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Cancel workflow execution
  Future<Map<String, dynamic>> cancelExecution(
    String workflowId,
    String executionId, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$workflowId/executions/$executionId/cancel',
      method: 'POST',
      headers: headers,
      useCache: false,
    );
    return response['execution'];
  }

  /// Search workflows
  Future<PaginatedResponse<Map<String, dynamic>>> search({
    String? searchTerm,
    String? name,
    String? status,
    List<String>? tags,
    DateTime? createdAfter,
    DateTime? createdBefore,
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (searchTerm != null && searchTerm.isNotEmpty) {
      builder.where('q', searchTerm);
    }
    if (name != null) {
      builder.where('name', name);
    }
    if (status != null) {
      builder.where('status', status);
    }
    if (tags != null && tags.isNotEmpty) {
      builder.where('tags', tags);
    }
    if (createdAfter != null) {
      builder.where('created_at[gte]', createdAfter.toIso8601String());
    }
    if (createdBefore != null) {
      builder.where('created_at[lte]', createdBefore.toIso8601String());
    }

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['workflows'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Get workflow analytics
  Future<Map<String, dynamic>> getAnalytics(
    String id, {
    DateTime? startDate,
    DateTime? endDate,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder();

    if (startDate != null) {
      builder.where('start_date', startDate.toIso8601String());
    }
    if (endDate != null) {
      builder.where('end_date', endDate.toIso8601String());
    }

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/analytics',
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
    return response['analytics'];
  }

  /// List active workflows
  Future<PaginatedResponse<Map<String, dynamic>>> listActive({
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    return search(
      status: 'active',
      limit: limit,
      offset: offset,
      expand: expand,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }
}

class _AdminApiKeyResource extends _AdminResource {
  const _AdminApiKeyResource(super.client);
  @override
  String get basePath => '/admin/api-keys';

  /// List API keys with advanced filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    int? limit,
    int? offset,
    List<String>? expand,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (query != null) {
      builder.whereAll(query);
    }

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['api_keys'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Get API key by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query =
        expand != null && expand.isNotEmpty
            ? QueryBuilder().expand(expand).build()
            : <String, dynamic>{};

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 30),
    );
    return response['api_key'];
  }

  /// Create an API key
  Future<Map<String, dynamic>> create({
    required String title,
    String? type,
    DateTime? expiresAt,
    List<String>? scopes,
    Map<String, dynamic>? metadata,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: {
        'title': title,
        if (type != null) 'type': type,
        if (expiresAt != null) 'expires_at': expiresAt.toIso8601String(),
        if (scopes != null) 'scopes': scopes,
        if (metadata != null) 'metadata': metadata,
      },
      headers: headers,
      useCache: false,
    );
    return response['api_key'];
  }

  /// Update an API key
  Future<Map<String, dynamic>> update(
    String id, {
    String? title,
    DateTime? expiresAt,
    List<String>? scopes,
    Map<String, dynamic>? metadata,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'POST',
      body: {
        if (title != null) 'title': title,
        if (expiresAt != null) 'expires_at': expiresAt.toIso8601String(),
        if (scopes != null) 'scopes': scopes,
        if (metadata != null) 'metadata': metadata,
      },
      headers: headers,
      useCache: false,
    );
    return response['api_key'];
  }

  /// Delete an API key
  Future<Map<String, dynamic>> delete(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'DELETE',
      headers: headers,
      useCache: false,
    );
    return response;
  }

  /// Revoke an API key
  Future<Map<String, dynamic>> revoke(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/revoke',
      method: 'POST',
      headers: headers,
      useCache: false,
    );
    return response['api_key'];
  }

  /// Search API keys
  Future<PaginatedResponse<Map<String, dynamic>>> search({
    String? searchTerm,
    String? title,
    String? type,
    bool? isRevoked,
    bool? isExpired,
    DateTime? createdAfter,
    DateTime? createdBefore,
    DateTime? expiresAfter,
    DateTime? expiresBefore,
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (searchTerm != null && searchTerm.isNotEmpty) {
      builder.where('q', searchTerm);
    }
    if (title != null) {
      builder.where('title', title);
    }
    if (type != null) {
      builder.where('type', type);
    }
    if (isRevoked != null) {
      builder.where('is_revoked', isRevoked);
    }
    if (isExpired != null) {
      builder.where('is_expired', isExpired);
    }
    if (createdAfter != null) {
      builder.where('created_at[gte]', createdAfter.toIso8601String());
    }
    if (createdBefore != null) {
      builder.where('created_at[lte]', createdBefore.toIso8601String());
    }
    if (expiresAfter != null) {
      builder.where('expires_at[gte]', expiresAfter.toIso8601String());
    }
    if (expiresBefore != null) {
      builder.where('expires_at[lte]', expiresBefore.toIso8601String());
    }

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['api_keys'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// List active API keys
  Future<PaginatedResponse<Map<String, dynamic>>> listActive({
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    return search(
      isRevoked: false,
      isExpired: false,
      limit: limit,
      offset: offset,
      expand: expand,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// List expired API keys
  Future<PaginatedResponse<Map<String, dynamic>>> listExpired({
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    return search(
      isExpired: true,
      limit: limit,
      offset: offset,
      expand: expand,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get API key statistics
  Future<Map<String, dynamic>> getStatistics({
    DateTime? startDate,
    DateTime? endDate,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder();

    if (startDate != null) {
      builder.where('start_date', startDate.toIso8601String());
    }
    if (endDate != null) {
      builder.where('end_date', endDate.toIso8601String());
    }

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/statistics',
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 30),
    );
    return response['statistics'];
  }
}

class _AdminInviteResource extends _AdminResource {
  const _AdminInviteResource(super.client);
  @override
  String get basePath => '/admin/invites';

  /// List invites with advanced filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    int? limit,
    int? offset,
    List<String>? expand,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (query != null) {
      builder.whereAll(query);
    }

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(response['invites'] ?? []),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Get invite by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query =
        expand != null && expand.isNotEmpty
            ? QueryBuilder().expand(expand).build()
            : <String, dynamic>{};

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
    return response['invite'];
  }

  /// Create an invite for a new user
  Future<Map<String, dynamic>> create({
    required String email,
    String? role,
    Map<String, dynamic>? metadata,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: {
        'email': email,
        if (role != null) 'role': role,
        if (metadata != null) 'metadata': metadata,
      },
      headers: headers,
      useCache: false,
    );
    return response['invite'];
  }

  /// Resend an invite
  Future<Map<String, dynamic>> resend(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/resend',
      method: 'POST',
      headers: headers,
      useCache: false,
    );
    return response['invite'];
  }

  /// Delete an invite
  Future<Map<String, dynamic>> delete(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      method: 'DELETE',
      headers: headers,
      useCache: false,
    );
    return response;
  }

  /// Accept an invite
  Future<Map<String, dynamic>> accept(
    String token, {
    required String firstName,
    required String lastName,
    required String password,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/accept',
      method: 'POST',
      body: {
        'token': token,
        'first_name': firstName,
        'last_name': lastName,
        'password': password,
      },
      headers: headers,
      useCache: false,
    );
    return response['user'];
  }

  /// Verify an invite token
  Future<Map<String, dynamic>> verify(
    String token, {
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/verify/$token',
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );
    return response['invite'];
  }

  /// Search invites with advanced filtering
  Future<PaginatedResponse<Map<String, dynamic>>> search({
    String? email,
    String? role,
    String? status,
    DateTime? createdAfter,
    DateTime? createdBefore,
    DateTime? expiresAfter,
    DateTime? expiresBefore,
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder()
        .paginate(limit: limit, offset: offset)
        .expand(expand ?? []);

    if (email != null) {
      builder.where('email', email);
    }
    if (role != null) {
      builder.where('role', role);
    }
    if (status != null) {
      builder.where('status', status);
    }
    if (createdAfter != null) {
      builder.where('created_at[gte]', createdAfter.toIso8601String());
    }
    if (createdBefore != null) {
      builder.where('created_at[lte]', createdBefore.toIso8601String());
    }
    if (expiresAfter != null) {
      builder.where('expires_at[gte]', expiresAfter.toIso8601String());
    }
    if (expiresBefore != null) {
      builder.where('expires_at[lte]', expiresBefore.toIso8601String());
    }

    return list(
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// List pending invites
  Future<PaginatedResponse<Map<String, dynamic>>> listPending({
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    return search(
      status: 'pending',
      limit: limit,
      offset: offset,
      expand: expand,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// List expired invites
  Future<PaginatedResponse<Map<String, dynamic>>> listExpired({
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    return search(
      expiresBefore: DateTime.now(),
      limit: limit,
      offset: offset,
      expand: expand,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// List invites by role
  Future<PaginatedResponse<Map<String, dynamic>>> listByRole(
    String role, {
    int? limit,
    int? offset,
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    return search(
      role: role,
      limit: limit,
      offset: offset,
      expand: expand,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get invite statistics
  Future<Map<String, dynamic>> getStatistics({
    DateTime? dateFrom,
    DateTime? dateTo,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final builder = QueryBuilder();

    if (dateFrom != null) {
      builder.where('date_from', dateFrom.toIso8601String());
    }
    if (dateTo != null) {
      builder.where('date_to', dateTo.toIso8601String());
    }

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/statistics',
      query: builder.build(),
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 15),
    );
    return response['statistics'];
  }

  /// Batch create invites
  Future<Map<String, dynamic>> createBatch({
    required List<Map<String, dynamic>> invites,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/batch',
      method: 'POST',
      body: {'invites': invites},
      headers: headers,
      useCache: false,
    );
    return response;
  }

  /// Batch delete invites
  Future<Map<String, dynamic>> deleteBatch({
    required List<String> inviteIds,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/batch',
      method: 'DELETE',
      body: {'invite_ids': inviteIds},
      headers: headers,
      useCache: false,
    );
    return response;
  }
}

class _AdminUploadResource extends _AdminResource {
  const _AdminUploadResource(super.client);
  @override
  String get basePath => '/admin/uploads';

  /// Upload a file to protected storage
  Future<Map<String, dynamic>> uploadProtected(
    List<int> fileBytes,
    String fileName, {
    String? contentType,
    ClientHeaders? headers,
  }) async {
    final formData = <String, dynamic>{
      'files': {
        'name': fileName,
        'bytes': fileBytes,
        'contentType': contentType ?? 'application/octet-stream',
      },
    };

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/protected',
      method: 'POST',
      body: formData,
      headers: headers,
      useCache: false,
    );
    return response;
  }

  /// Upload a file to public storage
  Future<Map<String, dynamic>> uploadPublic(
    List<int> fileBytes,
    String fileName, {
    String? contentType,
    ClientHeaders? headers,
  }) async {
    final formData = <String, dynamic>{
      'files': {
        'name': fileName,
        'bytes': fileBytes,
        'contentType': contentType ?? 'application/octet-stream',
      },
    };

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: formData,
      headers: headers,
      useCache: false,
    );
    return response;
  }

  /// Delete an uploaded file
  Future<DeleteResponse> delete(
    String fileKey, {
    ClientHeaders? headers,
  }) async {
    return client.fetch<DeleteResponse>(
      basePath,
      method: 'DELETE',
      body: {'file_key': fileKey},
      headers: headers,
      useCache: false,
    );
  }

  /// Get download URL for protected file
  Future<Map<String, dynamic>> getDownloadUrl(
    String fileKey, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/download-url',
      method: 'POST',
      body: {'file_key': fileKey},
      headers: headers,
      useCache: false,
    );
    return response;
  }

  /// Upload multiple files
  Future<Map<String, dynamic>> uploadMultiple(
    List<Map<String, dynamic>> files, {
    bool isProtected = false,
    ClientHeaders? headers,
  }) async {
    final endpoint = isProtected ? '$basePath/protected' : basePath;

    final response = await client.fetch<Map<String, dynamic>>(
      endpoint,
      method: 'POST',
      body: {'files': files},
      headers: headers,
      useCache: false,
    );
    return response;
  }
}

class _AdminNotificationResource extends _AdminResource {
  const _AdminNotificationResource(super.client);
  @override
  String get basePath => '/admin/notifications';

  /// Create a new query builder for notifications
  QueryBuilder query() => QueryBuilder();

  /// List all notifications with filtering and pagination
  Future<PaginatedResponse<Map<String, dynamic>>> list({
    QueryBuilder? queryBuilder,
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final finalQuery = queryBuilder?.build() ?? query;
    return client.fetch<PaginatedResponse<Map<String, dynamic>>>(
      basePath,
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 2),
    );
  }

  /// Get a specific notification by ID
  Future<Map<String, dynamic>> retrieve(
    String id, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );
    return response['notification'];
  }

  /// Resend a notification
  Future<Map<String, dynamic>> resend(
    String id, {
    String? to,
    ClientHeaders? headers,
  }) async {
    final body = <String, dynamic>{};
    if (to != null) body['to'] = to;

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/resend',
      method: 'POST',
      body: body,
      headers: headers,
      useCache: false,
    );
    return response['notification'];
  }

  /// Get unread notifications
  Future<PaginatedResponse<Map<String, dynamic>>> getUnread({
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final unreadQuery =
        QueryBuilder()
            .where('read_at', null)
            .orderBy('created_at', ascending: false)
            .build();

    final finalQuery = {...?query, ...unreadQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Mark notification as read
  Future<Map<String, dynamic>> markAsRead(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/$id/read',
      method: 'POST',
      headers: headers,
      useCache: false,
    );
    return response['notification'];
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead({ClientHeaders? headers}) async {
    await client.fetch<Map<String, dynamic>>(
      '$basePath/read-all',
      method: 'POST',
      headers: headers,
      useCache: false,
    );
  }

  /// Get notifications by type
  Future<PaginatedResponse<Map<String, dynamic>>> getByType(
    String type, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final typeQuery =
        QueryBuilder()
            .where('event_name', type)
            .orderBy('created_at', ascending: false)
            .build();

    final finalQuery = {...?query, ...typeQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get notifications by resource
  Future<PaginatedResponse<Map<String, dynamic>>> getByResource(
    String resourceType,
    String resourceId, {
    QueryParams? query,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final resourceQuery =
        QueryBuilder()
            .where('resource_type', resourceType)
            .where('resource_id', resourceId)
            .orderBy('created_at', ascending: false)
            .build();

    final finalQuery = {...?query, ...resourceQuery};
    return list(
      query: finalQuery,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Get notification statistics
  Future<Map<String, dynamic>> getStats({
    DateTime? dateFrom,
    DateTime? dateTo,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query = <String, dynamic>{};
    if (dateFrom != null) {
      query['date_from'] = dateFrom.toIso8601String();
    }
    if (dateTo != null) {
      query['date_to'] = dateTo.toIso8601String();
    }

    return client.fetch<Map<String, dynamic>>(
      '$basePath/stats',
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 10),
    );
  }
}

class _AdminAuthResource extends _AdminResource {
  const _AdminAuthResource(super.client);
  @override
  String get basePath => '/admin/auth';

  /// Authenticate admin user with email and password
  Future<Map<String, dynamic>> authenticate(
    String email,
    String password, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      method: 'POST',
      body: {'email': email, 'password': password},
      headers: headers,
      useCache: false,
    );
    return response;
  }

  /// Get current authenticated user
  Future<Map<String, dynamic>> getSession({
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );
    return response['user'];
  }

  /// Logout current authenticated user
  Future<void> logout({ClientHeaders? headers}) async {
    await client.fetch<Map<String, dynamic>>(
      '$basePath/logout',
      method: 'POST',
      headers: headers,
      useCache: false,
    );
  }

  /// Create password reset token
  Future<void> createPasswordResetToken(
    String email, {
    ClientHeaders? headers,
  }) async {
    await client.fetch<Map<String, dynamic>>(
      '$basePath/password-token',
      method: 'POST',
      body: {'email': email},
      headers: headers,
      useCache: false,
    );
  }

  /// Reset password with token
  Future<Map<String, dynamic>> resetPassword(
    String token,
    String password, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/reset-password',
      method: 'POST',
      body: {'token': token, 'password': password},
      headers: headers,
      useCache: false,
    );
    return response['user'];
  }

  /// Verify password reset token
  Future<bool> verifyPasswordResetToken(
    String token, {
    ClientHeaders? headers,
  }) async {
    try {
      await client.fetch<Map<String, dynamic>>(
        '$basePath/password-token/$token',
        headers: headers,
        useCache: false,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Create an invitation token for new admin user
  Future<Map<String, dynamic>> createInviteToken(
    String email, {
    String? role,
    ClientHeaders? headers,
  }) async {
    final body = <String, dynamic>{'email': email};
    if (role != null) body['role'] = role;

    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/invite',
      method: 'POST',
      body: body,
      headers: headers,
      useCache: false,
    );
    return response;
  }

  /// Accept invitation and create new admin user
  Future<Map<String, dynamic>> acceptInvite(
    String token,
    String firstName,
    String lastName,
    String password, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/invite/accept',
      method: 'POST',
      body: {
        'token': token,
        'first_name': firstName,
        'last_name': lastName,
        'password': password,
      },
      headers: headers,
      useCache: false,
    );
    return response['user'];
  }

  /// Verify invite token
  Future<bool> verifyInviteToken(String token, {ClientHeaders? headers}) async {
    try {
      await client.fetch<Map<String, dynamic>>(
        '$basePath/invite/$token',
        headers: headers,
        useCache: false,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get current user with expanded relations
  Future<Map<String, dynamic>> getCurrentUserExpanded({
    List<String>? expand,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final query =
        expand != null
            ? QueryBuilder().expand(expand).build()
            : <String, dynamic>{};

    final response = await client.fetch<Map<String, dynamic>>(
      basePath,
      query: query,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl ?? const Duration(minutes: 5),
    );
    return response['user'];
  }
}
