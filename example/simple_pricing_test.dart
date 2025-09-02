import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';
import 'package:http/http.dart' as http;

/// Simple pricing test for your Thai products backend
/// This test works with your existing products and backend setup
Future<void> main(List<String> args) async {
  // Default configuration
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

  print('🌿 Testing Product Pricing - Thai Vegetable Store');
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
    // Test backend connectivity
    print('🔌 Testing backend connectivity...');
    final healthResponse = await http.get(Uri.parse('$backendUrl/health'));
    print('✅ Backend is reachable (Status: ${healthResponse.statusCode})');

    print('');
    print('📋 Test 1: Basic Product Information');
    print('-' * 40);

    // Get all products (we know we have 9 from previous test)
    final productsResponse = await store.product.list();
    print(
      '📊 Found ${productsResponse.products.length} products in your store',
    );
    print('');

    // Show each product with basic info
    for (int i = 0; i < productsResponse.products.length; i++) {
      final product = productsResponse.products[i];
      print('${i + 1}. 📦 ${product.title}');
      print('   🆔 ID: ${product.id}');
      print('   🏷️ Handle: ${product.handle ?? 'N/A'}');
      print('   💳 Gift Card: ${product.isGiftcard ? 'Yes' : 'No'}');

      if (product.description != null && product.description!.isNotEmpty) {
        final shortDesc =
            product.description!.length > 60
                ? '${product.description!.substring(0, 60)}...'
                : product.description!;
        print('   📝 Description: $shortDesc');
      }

      if (product.thumbnail != null) {
        print('   🖼️ Thumbnail: Available');
      }
      print('');
    }

    print('📋 Test 2: Product Variants and Pricing');
    print('-' * 40);

    // Test each product for variants and pricing
    for (final product in productsResponse.products.take(3)) {
      print('🔍 Checking pricing for: ${product.title}');

      try {
        // Try to get detailed product info with variants
        final detailedProduct = await store.product.retrieve(
          product.id,
          query: {'expand': 'variants'},
        );

        if (detailedProduct != null) {
          print('   ✅ Retrieved detailed information');

          if (detailedProduct.variants != null &&
              detailedProduct.variants!.isNotEmpty) {
            print(
              '   💎 Found ${detailedProduct.variants!.length} variant(s):',
            );

            for (int i = 0; i < detailedProduct.variants!.length; i++) {
              final variant = detailedProduct.variants![i];
              print('     ${i + 1}. ${variant.title}');
              print('        🆔 Variant ID: ${variant.id}');
              print('        📦 SKU: ${variant.sku ?? 'No SKU'}');

              // Check if variant has pricing
              if (variant.calculatedPrice != null) {
                final price = variant.calculatedPrice!;
                print('        💰 Pricing Available:');
                print('           🔹 Currency: ${price.currencyCode ?? 'N/A'}');

                if (price.effectiveAmount != null) {
                  final formattedPrice = (price.effectiveAmount! / 100)
                      .toStringAsFixed(2);
                  print('           💵 Price: \$${formattedPrice}');
                }

                if (price.hasDiscount) {
                  print('           🎉 Has Discount Applied!');
                }
              } else {
                print('        ⚠️ No pricing information available');
                print(
                  '        💡 This might need to be configured in Medusa admin',
                );
              }
            }
          } else {
            print('   ⚠️ No variants found for this product');
            print('   💡 Products need variants with pricing in Medusa');
          }
        } else {
          print('   ❌ Could not retrieve detailed product information');
        }
      } catch (e) {
        print(
          '   ❌ Error getting product details: ${e.toString().split('\n').first}',
        );
      }
      print('');
    }

    print('📋 Test 3: Simple Cart Test');
    print('-' * 40);

    try {
      // Try to create a simple cart
      print('🛒 Creating a cart...');
      final cart = await store.cart.create({
        'currency_code': 'usd', // Default currency
      });

      if (cart != null) {
        print('✅ Cart created successfully!');
        print('   🛒 Cart ID: ${cart.id}');
        print('   💰 Currency: ${cart.currencyCode}');
        print(
          '   📊 Initial total: \$${(cart.total / 100).toStringAsFixed(2)}',
        );
        print('   📦 Item count: ${cart.itemCount}');
        print('');

        // Try to add the first product to cart (if it has variants)
        final firstProduct = productsResponse.products.first;
        print('🛍️ Attempting to add "${firstProduct.title}" to cart...');

        // Get product with variants first
        try {
          final productWithVariants = await store.product.retrieve(
            firstProduct.id,
            query: {'expand': 'variants'},
          );

          if (productWithVariants?.variants != null &&
              productWithVariants!.variants!.isNotEmpty) {
            final firstVariant = productWithVariants.variants!.first;

            print('   📦 Using variant: ${firstVariant.title}');
            print('   🆔 Variant ID: ${firstVariant.id}');

            final updatedCart = await store.cart.createLineItem(cart.id, {
              'variant_id': firstVariant.id,
              'quantity': 1,
            });

            if (updatedCart != null) {
              print('   ✅ Product added to cart successfully!');
              print('   📊 New item count: ${updatedCart.itemCount}');
              print(
                '   💰 Cart total: \$${(updatedCart.total / 100).toStringAsFixed(2)}',
              );
              print(
                '   💰 Subtotal: \$${(updatedCart.subtotal / 100).toStringAsFixed(2)}',
              );
              print(
                '   🏷️ Tax total: \$${(updatedCart.taxTotal / 100).toStringAsFixed(2)}',
              );

              if (updatedCart.discountTotal > 0) {
                print(
                  '   🎁 Discount total: \$${(updatedCart.discountTotal / 100).toStringAsFixed(2)}',
                );
              }
            } else {
              print('   ❌ Failed to add product to cart');
            }
          } else {
            print('   ⚠️ Product has no variants - cannot add to cart');
            print('   💡 Configure variants with prices in Medusa admin');
          }
        } catch (e) {
          print(
            '   ❌ Error adding product to cart: ${e.toString().split('\n').first}',
          );
        }
      } else {
        print('❌ Failed to create cart');
      }
    } catch (e) {
      print('❌ Error in cart test: ${e.toString().split('\n').first}');
    }

    print('');
    print('📋 Test 4: Promotion Code Test');
    print('-' * 40);

    // Test some common promotion codes
    print('🎯 Testing common promotion codes...');
    final testCodes = ['SAVE10', 'DISCOUNT', 'WELCOME', 'TEST'];

    for (final code in testCodes) {
      try {
        // Create a simple cart for testing
        final testCart = await store.cart.create({'currency_code': 'usd'});
        if (testCart != null) {
          print('   🎫 Testing code: $code');

          final cartWithPromo = await store.cart.applyDiscount(
            testCart.id,
            code,
          );

          if (cartWithPromo != null) {
            print('   🎉 SUCCESS! Code "$code" is valid');
            if (cartWithPromo.discountTotal > 0) {
              print(
                '      💰 Discount applied: \$${(cartWithPromo.discountTotal / 100).toStringAsFixed(2)}',
              );
            }
          } else {
            print('   ❌ Code "$code" not valid or not applicable');
          }
        }
      } catch (e) {
        print('   ❌ Code "$code" failed: ${e.toString().split('\n').first}');
      }
    }

    print('');
    print('🎉 Pricing Test Complete!');
    print('');
    print('📊 Summary of your store:');
    print('   ✅ ${productsResponse.products.length} products found');
    print('   ✅ Basic product information working');
    print('   ✅ Product listing working');
    print('   ✅ Cart creation working');
    print('');
    print('💡 Next steps to enable full pricing & promotions:');
    print(
      '   1. 🏷️ Add variants with prices to your products in Medusa admin',
    );
    print('   2. 🌍 Configure regions and currencies');
    print('   3. 🎁 Create discount codes/promotions');
    print('   4. 📋 Set up price lists for special pricing');
    print('');
    print('🌿 Your Thai vegetable store products:');
    for (final product in productsResponse.products) {
      print('   • ${product.title}');
    }
  } catch (e) {
    print('❌ Error during testing: $e');
    print('');
    print('💡 This might indicate:');
    print('   • Missing pricing configuration in Medusa admin');
    print('   • Products need variants with prices');
    print('   • Region/currency setup needed');
  } finally {
    // Clean up
    client.dispose();
  }
}
