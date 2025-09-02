import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

/// Example demonstrating how to fetch product data using MedusaJS Dart SDK
class ProductFetchExample {
  late final MedusaStore store;
  late final MedusaClient client;

  ProductFetchExample({
    required String baseUrl,
    required String publishableKey,
  }) {
    final config = MedusaConfig(
      baseUrl: baseUrl,
      publishableKey: publishableKey,
    );
    client = MedusaClient(config);
    store = MedusaStore(client);
  }

  /// Fetch all products with basic pagination
  Future<void> fetchAllProducts() async {
    try {
      print('🔄 Fetching all products...');

      final response = await store.product.list();

      print('✅ Successfully fetched ${response.products.length} products');
      print(
        '📊 Total products available: ${response.hasMore ? 'More than ${response.products.length}' : response.products.length}',
      );

      for (final product in response.products) {
        print('📦 ${product.title} (${product.handle}) - ${product.status}');
      }
    } catch (e) {
      print('❌ Error fetching products: $e');
      rethrow;
    }
  }

  /// Fetch products with pagination
  Future<List<Product>> fetchProductsWithPagination({
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      print('📄 Fetching products (limit: $limit, offset: $offset)...');

      final response = await store.product.list(
        query: {'limit': limit, 'offset': offset},
      );

      print('✅ Fetched ${response.products.length} products');
      return response.products;
    } catch (e) {
      print('❌ Error fetching paginated products: $e');
      rethrow;
    }
  }

  /// Fetch published products only
  Future<List<Product>> fetchPublishedProducts() async {
    try {
      print('🔄 Fetching published products...');

      final response = await store.product.list(
        query: {'status': 'published', 'is_giftcard': false},
      );

      final publishedProducts =
          response.products
              .where((product) => product.status == ProductStatus.published)
              .toList();

      print('✅ Found ${publishedProducts.length} published products');
      return publishedProducts;
    } catch (e) {
      print('❌ Error fetching published products: $e');
      rethrow;
    }
  }

  /// Fetch a specific product by ID
  Future<Product?> fetchProductById(String productId) async {
    try {
      print('🔍 Fetching product with ID: $productId');

      final product = await store.product.retrieve(productId);

      if (product != null) {
        print('✅ Found product: ${product.title}');
        print('📝 Description: ${product.description ?? 'No description'}');
        print('💰 Gift card: ${product.isGiftcard ? 'Yes' : 'No'}');
        print('📊 Status: ${product.status}');
      } else {
        print('⚠️ Product not found');
      }

      return product;
    } catch (e) {
      print('❌ Error fetching product by ID: $e');
      rethrow;
    }
  }

  /// Fetch product with full details (variants, images, options)
  Future<Product?> fetchProductWithDetails(String productId) async {
    try {
      print('🔍 Fetching detailed product: $productId');

      final product = await store.product.retrieve(
        productId,
        query: {'expand': 'variants,images,options,tags,type,collection'},
      );

      if (product != null) {
        print('✅ Product: ${product.title}');

        // Display variants
        if (product.variants != null && product.variants!.isNotEmpty) {
          print('💎 Variants (${product.variants!.length}):');
          for (final variant in product.variants!) {
            final price =
                variant.prices?.isNotEmpty == true
                    ? variant.prices!.first.amount.toString()
                    : 'No price';
            print('  - ${variant.title}: $price');
          }
        }

        // Display images
        if (product.images != null && product.images!.isNotEmpty) {
          print('🖼️ Images (${product.images!.length}):');
          for (final image in product.images!) {
            print('  - ${image.url}');
          }
        }

        // Display options
        if (product.options != null && product.options!.isNotEmpty) {
          print('⚙️ Options (${product.options!.length}):');
          for (final option in product.options!) {
            print('  - ${option.title}');
          }
        }

        // Display tags
        if (product.tags != null && product.tags!.isNotEmpty) {
          print(
            '🏷️ Tags: ${product.tags!.map((tag) => tag.value).join(', ')}',
          );
        }

        // Display type
        if (product.type != null) {
          print('📂 Type: ${product.type!.value}');
        }

        // Display collection
        if (product.collection != null) {
          print('📚 Collection: ${product.collection!.title}');
        }
      }

      return product;
    } catch (e) {
      print('❌ Error fetching detailed product: $e');
      rethrow;
    }
  }

  /// Search products by term
  Future<List<Product>> searchProducts(String searchTerm) async {
    try {
      print('🔍 Searching products for: "$searchTerm"');

      final response = await store.product.search(searchTerm);

      print(
        '✅ Found ${response.products.length} products matching "$searchTerm"',
      );

      for (final product in response.products) {
        print('📦 ${product.title} - ${product.handle}');
      }

      return response.products;
    } catch (e) {
      print('❌ Error searching products: $e');
      rethrow;
    }
  }

  /// Search products with additional filters
  Future<List<Product>> searchProductsWithFilters(
    String searchTerm, {
    bool? isGiftcard,
    ProductStatus? status,
    int? limit,
  }) async {
    try {
      print('🔍 Advanced search for: "$searchTerm"');

      final filters = <String, dynamic>{};

      if (isGiftcard != null) {
        filters['is_giftcard'] = isGiftcard;
      }

      if (status != null) {
        filters['status'] = status.name;
      }

      if (limit != null) {
        filters['limit'] = limit;
      }

      final response = await store.product.search(
        searchTerm,
        additionalFilters: filters,
      );

      print('✅ Advanced search found ${response.products.length} products');
      return response.products;
    } catch (e) {
      print('❌ Error in advanced search: $e');
      rethrow;
    }
  }

  /// Fetch products from a specific collection
  Future<List<Product>> fetchProductsByCollection(String collectionId) async {
    try {
      print('📚 Fetching products from collection: $collectionId');

      final response = await store.product.list(
        query: {'collection_id': collectionId},
      );

      print('✅ Found ${response.products.length} products in collection');
      return response.products;
    } catch (e) {
      print('❌ Error fetching products by collection: $e');
      rethrow;
    }
  }

  /// Fetch products by category
  Future<List<Product>> fetchProductsByCategory(String categoryId) async {
    try {
      print('📂 Fetching products from category: $categoryId');

      final response = await store.product.list(
        query: {'category_id': categoryId},
      );

      print('✅ Found ${response.products.length} products in category');
      return response.products;
    } catch (e) {
      print('❌ Error fetching products by category: $e');
      rethrow;
    }
  }

  /// Clean up resources
  void dispose() {
    client.dispose();
  }
}

/// Example usage
Future<void> main() async {
  // Initialize the product fetch example
  // Replace with your actual Medusa backend URL and publishable key
  final productFetcher = ProductFetchExample(
    baseUrl: 'http://localhost:9000',
    publishableKey: 'pk_test_example',
  );

  try {
    // Example 1: Fetch all products
    await productFetcher.fetchAllProducts();

    print('\n' + '=' * 50 + '\n');

    // Example 2: Fetch with pagination
    final paginatedProducts = await productFetcher.fetchProductsWithPagination(
      limit: 5,
      offset: 0,
    );

    print('\n' + '=' * 50 + '\n');

    // Example 3: Fetch published products only
    final publishedProducts = await productFetcher.fetchPublishedProducts();

    if (publishedProducts.isNotEmpty) {
      print('\n' + '=' * 50 + '\n');

      // Example 4: Fetch product details
      await productFetcher.fetchProductWithDetails(publishedProducts.first.id);

      print('\n' + '=' * 50 + '\n');

      // Example 5: Search products
      await productFetcher.searchProducts('shirt');

      print('\n' + '=' * 50 + '\n');

      // Example 6: Advanced search
      await productFetcher.searchProductsWithFilters(
        'product',
        isGiftcard: false,
        status: ProductStatus.published,
        limit: 3,
      );
    }
  } catch (e) {
    print('❌ Example failed: $e');
  } finally {
    // Clean up
    productFetcher.dispose();
  }
}
