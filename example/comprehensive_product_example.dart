import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

/// Comprehensive example demonstrating product data fetching with MedusaJS Dart SDK
///
/// This example shows various ways to fetch and work with product data
/// from a MedusaJS backend.
class ProductDataExample {
  late final MedusaStore store;
  late final MedusaClient client;

  ProductDataExample({
    required String baseUrl,
    required String publishableKey,
  }) {
    final config = MedusaConfig(
      baseUrl: baseUrl,
      publishableKey: publishableKey,
      debug: true, // Enable debug logging
    );
    client = MedusaClient(config);
    store = MedusaStore(client);
  }

  /// Example 1: Basic product fetching
  Future<void> basicProductFetch() async {
    print('\n🔄 Example 1: Basic Product Fetching');
    print('=' * 50);

    try {
      // Fetch first page of products
      final response = await store.product.list();

      print('✅ Successfully fetched products');
      print('📊 Products on this page: ${response.data.length}');
      print('📈 Total products: ${response.count}');
      print('📄 Current page: ${response.currentPage}');
      print('📚 Total pages: ${response.totalPages}');
      print('🔄 Has more: ${response.hasMore}');

      // Show first few products
      for (int i = 0; i < response.data.length && i < 3; i++) {
        final product = response.data[i];
        print('📦 ${i + 1}. ${product.title}');
        print('   🆔 ID: ${product.id}');
        print('   🏷️ Handle: ${product.handle ?? 'N/A'}');
        print('   📊 Status: ${product.status}');
        print('   💳 Gift Card: ${product.isGiftcard ? 'Yes' : 'No'}');
      }
    } catch (e) {
      print('❌ Error fetching products: $e');
    }
  }

  /// Example 2: Paginated product fetching
  Future<void> paginatedProductFetch() async {
    print('\n🔄 Example 2: Paginated Product Fetching');
    print('=' * 50);

    try {
      const pageSize = 5;
      var currentOffset = 0;
      var totalFetched = 0;

      while (totalFetched < 15) {
        // Fetch max 15 products across pages
        final response = await store.product.list(
          query: {'limit': pageSize, 'offset': currentOffset},
        );

        print(
          '📄 Page ${response.currentPage}: ${response.data.length} products',
        );

        if (response.data.isEmpty) break;

        for (final product in response.data) {
          print('  📦 ${product.title} (${product.handle})');
          totalFetched++;
        }

        if (!response.hasMore) break;
        currentOffset += pageSize;
      }

      print('✅ Total products fetched: $totalFetched');
    } catch (e) {
      print('❌ Error in paginated fetch: $e');
    }
  }

  /// Example 3: Filtered product search
  Future<void> filteredProductSearch() async {
    print('\n🔄 Example 3: Filtered Product Search');
    print('=' * 50);

    try {
      // Search for published, non-gift-card products
      final response = await store.product.list(
        query: {'status': 'published', 'is_giftcard': false, 'limit': 10},
      );

      print('✅ Found ${response.data.length} published products');

      for (final product in response.data) {
        print('📦 ${product.title}');
        print('   📊 Status: ${product.status}');
        print('   💳 Gift Card: ${product.isGiftcard}');

        // Show additional details if available
        if (product.description != null) {
          final shortDesc =
              product.description!.length > 50
                  ? '${product.description!.substring(0, 50)}...'
                  : product.description!;
          print('   📝 Description: $shortDesc');
        }

        if (product.thumbnail != null) {
          print('   🖼️ Thumbnail: ${product.thumbnail}');
        }
      }
    } catch (e) {
      print('❌ Error in filtered search: $e');
    }
  }

  /// Example 4: Product search by text
  Future<void> textProductSearch() async {
    print('\n🔄 Example 4: Text-based Product Search');
    print('=' * 50);

    final searchTerms = ['shirt', 't-shirt', 'hoodie', 'dress', 'jeans'];

    for (final term in searchTerms) {
      try {
        final response = await store.product.search(term);

        print(
          '🔍 Search results for "$term": ${response.data.length} products',
        );

        if (response.data.isNotEmpty) {
          for (int i = 0; i < response.data.length && i < 3; i++) {
            final product = response.data[i];
            print('  📦 ${product.title}');
          }
          break; // Stop after finding results for one term
        }
      } catch (e) {
        print('❌ Error searching for "$term": $e');
      }
    }
  }

  /// Example 5: Detailed product information
  Future<void> detailedProductInfo() async {
    print('\n🔄 Example 5: Detailed Product Information');
    print('=' * 50);

    try {
      // First get a product ID
      final listResponse = await store.product.list(query: {'limit': 1});

      if (listResponse.data.isEmpty) {
        print('⚠️ No products available');
        return;
      }

      final productId = listResponse.data.first.id;

      // Fetch detailed product with expanded relationships
      final product = await store.product.retrieve(
        productId,
        query: {
          'expand': 'variants,images,options,tags,type,collection,categories',
        },
      );

      if (product == null) {
        print('⚠️ Product not found');
        return;
      }

      print('✅ Detailed Product Information:');
      print('📦 Title: ${product.title}');
      print('🆔 ID: ${product.id}');
      print('📝 Description: ${product.description ?? 'No description'}');
      print('🏷️ Handle: ${product.handle ?? 'No handle'}');
      print('📊 Status: ${product.status}');
      print('💳 Gift Card: ${product.isGiftcard ? 'Yes' : 'No'}');

      // Physical properties
      if (product.weight != null) print('⚖️ Weight: ${product.weight}g');
      if (product.length != null) print('📏 Length: ${product.length}cm');
      if (product.width != null) print('📐 Width: ${product.width}cm');
      if (product.height != null) print('📊 Height: ${product.height}cm');

      // Variants
      if (product.variants != null && product.variants!.isNotEmpty) {
        print('\n💎 Variants (${product.variants!.length}):');
        for (int i = 0; i < product.variants!.length && i < 5; i++) {
          final variant = product.variants![i];
          print('  ${i + 1}. ${variant.title ?? 'Variant ${i + 1}'}');
          print('     🆔 ID: ${variant.id}');
          print('     📦 SKU: ${variant.sku ?? 'No SKU'}');

          if (variant.prices != null && variant.prices!.isNotEmpty) {
            final price = variant.prices!.first;
            print('     💰 Price: ${price.amount} ${price.currencyCode}');
          }
        }
      }

      // Images
      if (product.images != null && product.images!.isNotEmpty) {
        print('\n🖼️ Images (${product.images!.length}):');
        for (int i = 0; i < product.images!.length && i < 3; i++) {
          final image = product.images![i];
          print('  ${i + 1}. ${image.url}');
        }
      }

      // Options
      if (product.options != null && product.options!.isNotEmpty) {
        print('\n⚙️ Options (${product.options!.length}):');
        for (final option in product.options!) {
          print('  📋 ${option.title}');
          if (option.values != null && option.values!.isNotEmpty) {
            print(
              '     Values: ${option.values!.map((v) => v.value).join(', ')}',
            );
          }
        }
      }

      // Tags
      if (product.tags != null && product.tags!.isNotEmpty) {
        print(
          '\n🏷️ Tags: ${product.tags!.map((tag) => tag.value).join(', ')}',
        );
      }

      // Type
      if (product.type != null) {
        print('\n📂 Type: ${product.type!.value}');
      }

      // Collection
      if (product.collection != null) {
        print('\n📚 Collection: ${product.collection!.title}');
      }
    } catch (e) {
      print('❌ Error fetching detailed product info: $e');
    }
  }

  /// Example 6: Advanced search with filters
  Future<void> advancedSearchExample() async {
    print('\n🔄 Example 6: Advanced Search with Filters');
    print('=' * 50);

    try {
      // Search with multiple filters
      final response = await store.product.search(
        'product', // Search term
        additionalFilters: {
          'is_giftcard': false,
          'status': 'published',
          'limit': 5,
          // Add more filters as needed
          // 'collection_id': 'pcol_...',
          // 'category_id': 'pcat_...',
          // 'price_min': 1000, // Price in cents
          // 'price_max': 5000,
        },
      );

      print('✅ Advanced search found ${response.data.length} products');

      for (final product in response.data) {
        print('📦 ${product.title}');
        print('   🆔 ID: ${product.id}');
        print('   📊 Status: ${product.status}');
        print('   💳 Gift Card: ${product.isGiftcard}');

        // Show variants count if available
        if (product.variants != null) {
          print('   💎 Variants: ${product.variants!.length}');
        }
      }
    } catch (e) {
      print('❌ Error in advanced search: $e');
    }
  }

  /// Example 7: Performance testing with concurrent requests
  Future<void> performanceTest() async {
    print('\n🔄 Example 7: Performance Test - Concurrent Requests');
    print('=' * 50);

    try {
      final stopwatch = Stopwatch()..start();

      // Create multiple concurrent requests
      final futures = <Future<PaginatedResponse<Product>>>[];

      for (int i = 0; i < 5; i++) {
        futures.add(store.product.list(query: {'limit': 3, 'offset': i * 3}));
      }

      final results = await Future.wait(futures);
      stopwatch.stop();

      var totalProducts = 0;
      for (int i = 0; i < results.length; i++) {
        final response = results[i];
        totalProducts += response.data.length;
        print('📄 Request ${i + 1}: ${response.data.length} products');
      }

      print('✅ Concurrent requests completed');
      print('⏱️ Total time: ${stopwatch.elapsedMilliseconds}ms');
      print('📊 Total products fetched: $totalProducts');
      print(
        '🚀 Average per request: ${stopwatch.elapsedMilliseconds / futures.length}ms',
      );
    } catch (e) {
      print('❌ Error in performance test: $e');
    }
  }

  /// Run all examples
  Future<void> runAllExamples() async {
    print('🚀 Starting Product Data Fetch Examples');
    print('=' * 70);

    await basicProductFetch();
    await Future.delayed(Duration(milliseconds: 500));

    await paginatedProductFetch();
    await Future.delayed(Duration(milliseconds: 500));

    await filteredProductSearch();
    await Future.delayed(Duration(milliseconds: 500));

    await textProductSearch();
    await Future.delayed(Duration(milliseconds: 500));

    await detailedProductInfo();
    await Future.delayed(Duration(milliseconds: 500));

    await advancedSearchExample();
    await Future.delayed(Duration(milliseconds: 500));

    await performanceTest();

    print('\n✅ All examples completed!');
  }

  /// Clean up resources
  void dispose() {
    client.dispose();
  }
}

/// Example usage
Future<void> main() async {
  // Configuration - Replace with your actual Medusa backend details
  final example = ProductDataExample(
    baseUrl: 'https://your-medusa-backend.com', // Your Medusa backend URL
    publishableKey: 'pk_your_publishable_key', // Your publishable API key
  );

  try {
    // Run all examples
    await example.runAllExamples();

    print('\n📋 Usage Summary:');
    print('1. Basic listing: store.product.list()');
    print(
      '2. Pagination: store.product.list(query: {\'limit\': 10, \'offset\': 0})',
    );
    print(
      '3. Filtering: store.product.list(query: {\'status\': \'published\'})',
    );
    print('4. Text search: store.product.search(\'search term\')');
    print(
      '5. Detailed fetch: store.product.retrieve(id, query: {\'expand\': \'variants\'})',
    );
    print(
      '6. Advanced search: store.product.search(term, additionalFilters: {...})',
    );
  } catch (e) {
    print('❌ Example failed: $e');
    print('\n💡 Tips:');
    print('- Make sure your Medusa backend is running');
    print('- Verify the backend URL and publishable key');
    print('- Check that products exist in your store');
    print('- Review the network connectivity');
  } finally {
    // Clean up
    example.dispose();
  }
}
