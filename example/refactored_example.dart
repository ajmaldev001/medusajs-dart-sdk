import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

/// Example demonstrating the refactored MedusaJS Dart SDK
void main() async {
  // Initialize the refactored SDK (recommended for new projects)
  final medusa = MedusaV2(MedusaConfig(
    baseUrl: 'https://your-medusa-backend.com',
    publishableKey: 'pk_test_...',
  ));

  try {
    // === STORE OPERATIONS (Customer-facing) ===
    
    print('=== Store Operations ===');
    
    // Browse products with clean API
    final products = await medusa.store.product.list(
      query: {'limit': 10},
    );
    print('Found ${products.count} products');
    
    // Search for products
    final searchResults = await medusa.store.product.search(
      'shirt',
      additionalFilters: {'category_id': 'cat_123'},
    );
    print('Search found ${searchResults.count} products');
    
    // Get products in a specific price range
    final priceFiltered = await medusa.store.product.inPriceRange(
      10.0, // min price
      100.0, // max price
    );
    print('Found ${priceFiltered.count} products in price range');
    
    // Get featured products
    final featured = await medusa.store.product.featured();
    print('Found ${featured.count} featured products');
    
    // Cart operations
    final cart = await medusa.store.cart.create({
      'region_id': 'reg_123',
      'currency_code': 'usd',
    });
    print('Created cart: ${cart?.id}');
    
    if (cart != null) {
      // Add item to cart
      final updatedCart = await medusa.store.cart.createLineItem(
        cart.id,
        {
          'variant_id': 'variant_123',
          'quantity': 2,
        },
      );
      print('Added item to cart: ${updatedCart?.id}');
      
      // Apply discount
      final discountedCart = await medusa.store.cart.applyDiscount(
        cart.id,
        'SUMMER20',
      );
      print('Applied discount to cart: ${discountedCart?.id}');
    }
    
    // === ADMIN OPERATIONS (Administrative) ===
    
    print('\n=== Admin Operations ===');
    
    // Authenticate as admin user first
    await medusa.auth.login('admin', 'emailpass', {
      'email': 'admin@example.com',
      'password': 'password',
    });
    
    // List products in admin
    final adminProducts = await medusa.admin.product.list(
      query: {'expand': 'variants,images'},
    );
    print('Admin found ${adminProducts.count} products');
    
    // Create a new product
    final newProduct = await medusa.admin.product.create({
      'title': 'New Product',
      'description': 'A great new product',
      'status': 'published',
    });
    print('Created product: ${newProduct?.id}');
    
    // Search admin products
    final adminSearch = await medusa.admin.product.search(
      'shirt',
      additionalFilters: {'status': 'published'},
    );
    print('Admin search found ${adminSearch.count} products');
    
    // List orders
    final orders = await medusa.admin.order.list(
      query: {'status': 'pending'},
    );
    print('Found ${orders.count} pending orders');
    
    // Batch operations
    final batch = medusa.admin.createBatch(maxBatchSize: 100);
    print('Created batch manager with max size 100');
    
    final productBatch = medusa.admin.batchProducts();
    print('Created product batch builder');
    
    // === UTILITIES ===
    
    print('\n=== Utilities ===');
    
    // Access configuration
    print('Base URL: ${medusa.configuration.baseUrl}');
    print('Has publishable key: ${medusa.configuration.publishableKey != null}');
    
    // Access low-level client for custom requests
    final customResponse = await medusa.client.get('/store/regions');
    print('Custom request returned ${customResponse.length} keys');
    
  } catch (e) {
    print('Error: $e');
  } finally {
    // Clean up resources
    medusa.dispose();
  }
}

/// Example comparing old vs new API patterns
void comparisonExample() {
  print('=== API Comparison ===');
  
  // OLD WAY (still works for backward compatibility)
  print('''
  // Old monolithic approach:
  final medusa = Medusa(config);
  final products = await medusa.store.product.listWithParams(query: {...});
  
  // Less organized, harder to discover features
  ''');
  
  // NEW WAY (recommended)
  print('''
  // New organized approach:
  final medusa = MedusaV2(config);
  final products = await medusa.store.product.list(query: {...});
  final featured = await medusa.store.product.featured();
  final search = await medusa.store.product.search('query');
  
  // Clean resources, better organization, more discoverable
  ''');
}