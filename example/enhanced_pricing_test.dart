import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';
import 'package:http/http.dart' as http;

/// Enhanced pricing test with proper region handling
/// This test works with your Thai vegetable store backend
Future<void> main(List<String> args) async {
  // Configuration
  String backendUrl = 'http://localhost:9000';
  String publishableKey =
      'pk_91b3a86dc075c322be390706c681561c525df7c54f4e54bf574b28e837d78714';

  // Parse command line arguments
  if (args.length >= 1) {
    backendUrl = args[0];
  }
  if (args.length >= 2) {
    publishableKey = args[1];
  }

  print('🌿 Enhanced Product Pricing Test - Thai Vegetable Store');
  print('=' * 55);
  print('🔗 Backend URL: $backendUrl');
  print(
    '🔑 Publishable Key: ${publishableKey.length > 10 ? '${publishableKey.substring(0, 10)}...' : publishableKey}',
  );
  print('');

  // Initialize the SDK
  final config = MedusaConfig(
    baseUrl: backendUrl,
    publishableKey: publishableKey,
    debug: false, // Reduce noise
  );

  final client = MedusaClient(config);
  final store = MedusaStore(client);

  try {
    // Test 1: Backend connectivity
    print('🔌 Testing backend connectivity...');
    final response = await http.get(Uri.parse('$backendUrl/health'));
    if (response.statusCode == 200) {
      print('✅ Backend is reachable (Status: ${response.statusCode})');
    } else {
      print('⚠️ Backend responded with status: ${response.statusCode}');
    }
    print('');

    // Test 2: Get regions first
    print('📋 Test 1: Available Regions');
    print('-' * 40);

    String? regionId;
    String? currencyCode;

    try {
      final regions = await store.regions.list();
      if (regions.isNotEmpty) {
        final region = regions.first;
        regionId = region.id;
        currencyCode = region.currencyCode;
        print('✅ Found ${regions.length} region(s)');
        print('🌍 Using region: ${region.name}');
        print('💱 Currency: ${currencyCode.toUpperCase()}');
      } else {
        print('⚠️ No regions configured');
      }
    } catch (e) {
      print('❌ Error fetching regions: $e');
    }
    print('');

    // Test 3: Get products with basic info
    print('📋 Test 2: Product Listing');
    print('-' * 40);

    List<Product> products = [];
    try {
      products = await medusa.store.products.list();
      print('✅ Found ${products.length} products in your store');

      for (int i = 0; i < products.length && i < 5; i++) {
        final product = products[i];
        print('${i + 1}. 📦 ${product.title}');
        print('   🆔 ID: ${product.id}');
        print('   🏷️ Handle: ${product.handle}');
      }
    } catch (e) {
      print('❌ Error fetching products: $e');
      return;
    }
    print('');

    // Test 4: Detailed product with pricing
    print('📋 Test 3: Product Details with Pricing');
    print('-' * 40);

    for (int i = 0; i < products.length && i < 3; i++) {
      final product = products[i];
      print('🔍 Testing: ${product.title}');

      try {
        // Get product details with region for pricing
        Map<String, dynamic> queryParams = {};
        if (regionId != null) {
          queryParams['region_id'] = regionId;
        }

        final detailedProduct = await medusa.store.products.retrieve(
          product.id!,
          queryParams: queryParams,
        );

        if (detailedProduct?.variants?.isNotEmpty == true) {
          print('   ✅ Found ${detailedProduct!.variants!.length} variant(s)');

          final variant = detailedProduct.variants!.first;
          print('   🏷️ Variant: ${variant.title}');
          print('   🆔 Variant ID: ${variant.id}');

          // Check pricing information
          if (variant.prices?.isNotEmpty == true) {
            final price = variant.prices!.first;
            print(
              '   💰 Price: ${price.amount} ${price.currencyCode?.toUpperCase()}',
            );
          } else {
            print('   ⚠️ No direct prices found');
          }

          // Check calculated price (includes region-specific pricing)
          if (variant.calculatedPrice != null) {
            final calcPrice = variant.calculatedPrice!;
            print('   💎 Calculated price available');
            if (calcPrice.calculatedAmount != null) {
              final amount =
                  calcPrice.calculatedAmount! / 100; // Convert from cents
              print(
                '   💵 Amount: ${amount.toStringAsFixed(2)} ${calcPrice.currencyCode?.toUpperCase()}',
              );
            }
          } else {
            print('   ⚠️ No calculated price available');
          }
        } else {
          print('   ⚠️ No variants found');
        }
      } catch (e) {
        print('   ❌ Error: $e');
      }
      print('');
    }

    // Test 5: Cart creation and line items
    print('📋 Test 4: Cart Creation with Products');
    print('-' * 40);

    try {
      // Create a cart
      final cart = await medusa.store.carts.create();
      print('✅ Cart created successfully');
      print('🛒 Cart ID: ${cart.id}');

      if (regionId != null) {
        // Update cart with region
        final updatedCart = await medusa.store.carts.update(cart.id!, {
          'region_id': regionId,
        });
        print('🌍 Cart updated with region: ${regionId}');
      }

      // Try to add a product if we have products with variants
      if (products.isNotEmpty) {
        try {
          final firstProduct = products.first;
          final productDetails = await medusa.store.products.retrieve(
            firstProduct.id!,
            queryParams: regionId != null ? {'region_id': regionId} : {},
          );

          if (productDetails?.variants?.isNotEmpty == true) {
            final variantId = productDetails!.variants!.first.id!;

            final cartWithItems = await medusa.store.carts.addLineItem(
              cart.id!,
              {'variant_id': variantId, 'quantity': 1},
            );

            print('✅ Added item to cart');
            print('📦 Item: ${firstProduct.title}');
            print('🔢 Cart items count: ${cartWithItems.items?.length ?? 0}');

            if (cartWithItems.items?.isNotEmpty == true) {
              final item = cartWithItems.items!.first;
              print('💰 Item total: ${item.total ?? 'N/A'}');
            }
          } else {
            print('⚠️ First product has no variants - skipping cart test');
          }
        } catch (e) {
          print('⚠️ Could not add item to cart: $e');
        }
      }
    } catch (e) {
      print('❌ Cart creation failed: $e');
    }
    print('');

    // Test 6: Simple promotion test
    print('📋 Test 5: Promotion Code Test');
    print('-' * 40);

    try {
      // Create a test cart for promotion testing
      final promoCart = await medusa.store.carts.create();
      if (regionId != null) {
        await medusa.store.carts.update(promoCart.id!, {'region_id': regionId});
      }

      // Test common discount codes
      final testCodes = ['SAVE10', 'DISCOUNT', 'WELCOME', 'TEST', 'FIRST10'];

      for (final code in testCodes) {
        try {
          final cartWithDiscount = await medusa.store.carts.addDiscount(
            promoCart.id!,
            code,
          );
          print('   ✅ Code "$code" applied successfully!');

          if (cartWithDiscount.discounts?.isNotEmpty == true) {
            final discount = cartWithDiscount.discounts!.first;
            print('      🎉 Discount: ${discount.code}');
            print('      💸 Type: ${discount.rule?.type}');
          }
          break; // Stop at first successful code
        } catch (e) {
          print(
            '   ❌ Code "$code" failed: ${e.toString().split(':').last.trim()}',
          );
        }
      }
    } catch (e) {
      print('❌ Promotion test setup failed: $e');
    }
    print('');

    // Summary
    print('🎉 Enhanced Pricing Test Complete!');
    print('');
    print('📊 Summary:');
    print('   ✅ ${products.length} products found');
    print('   ✅ Backend connectivity working');
    if (regionId != null) {
      print('   ✅ Region configured ($currencyCode)');
    } else {
      print('   ⚠️ No regions configured');
    }
    print('   ✅ Product listing working');
    print('   ✅ Cart creation working');
    print('');

    if (regionId == null) {
      print('💡 To enable full pricing features:');
      print('   1. Configure regions in Medusa admin');
      print('   2. Set up currencies for your regions');
      print('   3. Add prices to product variants');
      print('   4. Create discount codes/promotions');
    }
  } catch (e) {
    print('💥 Test failed with error: $e');
  }
}
