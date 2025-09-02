#!/usr/bin/env dart

import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

/// Simple demo script to test product data fetching
///
/// Usage:
/// dart run example/demo_product_fetch.dart [backend_url] [publishable_key]
///
/// Example:
/// dart run example/demo_product_fetch.dart http://localhost:9000 pk_test_123
Future<void> main(List<String> args) async {
  // Default configuration (you can override via command line args)
  String backendUrl = 'http://localhost:9000';
  String publishableKey = 'pk_test_example';

  // Parse command line arguments
  if (args.length >= 1) {
    backendUrl = args[0];
  }
  if (args.length >= 2) {
    publishableKey = args[1];
  }

  print('🚀 MedusaJS Dart SDK - Product Fetch Demo');
  print('=' * 50);
  print('🔗 Backend URL: $backendUrl');
  print(
    '🔑 Publishable Key: ${publishableKey.length > 10 ? '${publishableKey.substring(0, 10)}...' : publishableKey}',
  );
  print('');

  // Initialize the SDK
  final config = MedusaConfig(
    baseUrl: backendUrl,
    publishableKey: publishableKey,
    debug: true,
  );

  final client = MedusaClient(config);
  final store = MedusaStore(client);

  try {
    // Test 1: Basic store initialization
    print('📋 Test 1: Store Initialization');
    print('✅ Store created successfully');
    print('📦 Product resource available: ${store.product.runtimeType}');
    print('🔗 Resource path: ${store.product.resourcePath}');
    print('');

    // Test 2: Try to fetch products
    print('📋 Test 2: Fetch Products List');
    try {
      final response = await store.product.list(query: {'limit': 5});

      print('✅ Successfully connected to backend!');
      print('📊 Products found: ${response.products.length}');
      print('📈 Total products in store: ${response.count}');
      print(
        '📄 Current page: ${response.currentPage} of ${response.totalPages}',
      );
      print('🔄 Has more pages: ${response.hasMore}');
      print('');

      if (response.products.isNotEmpty) {
        print('📦 First few products:');
        for (int i = 0; i < response.products.length && i < 3; i++) {
          final product = response.products[i];
          print('  ${i + 1}. ${product.title}');
          print('     🆔 ID: ${product.id}');
          print('     🏷️ Handle: ${product.handle ?? 'N/A'}');
          print('     📊 Status: ${product.status}');
          print('     💳 Gift Card: ${product.isGiftcard ? 'Yes' : 'No'}');
        }
        print('');

        // Test 3: Try to fetch a specific product
        print('📋 Test 3: Fetch Specific Product');
        final firstProductId = response.products.first.id;

        try {
          final product = await store.product.retrieve(firstProductId);

          if (product != null) {
            print('✅ Successfully fetched product details');
            print('📦 Product: ${product.title}');
            print('📝 Description: ${product.description ?? 'No description'}');
            print('🖼️ Thumbnail: ${product.thumbnail ?? 'No thumbnail'}');

            // Show variants if available
            if (product.variants != null && product.variants!.isNotEmpty) {
              print('💎 Variants: ${product.variants!.length}');
            }

            // Show images if available
            if (product.images != null && product.images!.isNotEmpty) {
              print('🖼️ Images: ${product.images!.length}');
            }
          } else {
            print('⚠️ Product not found');
          }
        } catch (e) {
          print('❌ Error fetching specific product: $e');
        }
        print('');

        // Test 4: Try product search
        print('📋 Test 4: Product Search');
        try {
          final searchResponse = await store.product.search('product');
          print('✅ Search completed');
          print('🔍 Search results: ${searchResponse.products.length}');

          if (searchResponse.products.isNotEmpty) {
            print(
              '📦 First search result: ${searchResponse.products.first.title}',
            );
          }
        } catch (e) {
          print('❌ Error in product search: $e');
        }
      } else {
        print('⚠️ No products found in the store');
        print('💡 Try adding some products to your Medusa store first');
      }
    } catch (e) {
      print('❌ Failed to connect to backend: $e');
      print('');
      print('💡 Troubleshooting tips:');
      print('   • Make sure your Medusa backend is running');
      print('   • Verify the backend URL is correct');
      print('   • Check that the publishable key is valid');
      print('   • Ensure CORS is configured for your domain');
      print('   • Try accessing $backendUrl/health in your browser');
    }

    print('');
    print('🏁 Demo completed!');
  } finally {
    // Clean up
    client.dispose();
  }
}

/// Display usage information
void printUsage() {
  print(
    'Usage: dart run example/demo_product_fetch.dart [backend_url] [publishable_key]',
  );
  print('');
  print('Examples:');
  print('  dart run example/demo_product_fetch.dart');
  print('  dart run example/demo_product_fetch.dart http://localhost:9000');
  print(
    '  dart run example/demo_product_fetch.dart http://localhost:9000 pk_test_123',
  );
  print('');
  print('If no arguments are provided, defaults to:');
  print('  Backend URL: http://localhost:9000');
  print('  Publishable Key: pk_test_example');
}
