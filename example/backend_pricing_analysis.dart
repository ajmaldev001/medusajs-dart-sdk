import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

/// Backend-specific pricing test that adapts to your Medusa setup
/// This will show what's available and guide you on setting up pricing
Future<void> main(List<String> args) async {
  String backendUrl = 'http://localhost:9000';
  String publishableKey =
      'pk_91b3a86dc075c322be390706c681561c525df7c54f4e54bf574b28e837d78714';

  if (args.length >= 1) {
    backendUrl = args[0];
  }
  if (args.length >= 2) {
    publishableKey = args[1];
  }

  print('🛍️ Backend Pricing Analysis');
  print('=' * 40);
  print('🔗 Backend URL: $backendUrl');
  print('');

  final config = MedusaConfig(
    baseUrl: backendUrl,
    publishableKey: publishableKey,
    debug: true,
  );

  final client = MedusaClient(config);
  final store = MedusaStore(client);

  try {
    print('1️⃣ Analyzing Your Products');
    print('-' * 25);

    // Get products using the basic API
    final productsResponse = await store.product.list(query: {'limit': 10});

    print('📊 Found ${productsResponse.products.length} products');
    print('');

    for (int i = 0; i < productsResponse.products.length; i++) {
      final product = productsResponse.products[i];
      print('${i + 1}. 📦 ${product.title}');
      print('   🆔 ID: ${product.id}');
      print('   🏷️ Handle: ${product.handle ?? 'N/A'}');
      print('   📊 Status: ${product.status}');
      print('   💳 Discountable: ${product.discountable ? 'Yes' : 'No'}');

      if (product.variants != null && product.variants!.isNotEmpty) {
        print('   💎 Variants (${product.variants!.length}):');
        for (final variant in product.variants!) {
          print('     • ${variant.title}');
          print('       🆔 ID: ${variant.id}');
          print('       📦 SKU: ${variant.sku ?? 'No SKU'}');

          // Check if variant has any pricing info
          if (variant.calculatedPrice != null) {
            print('       💰 HAS PRICING! ✅');
            final price = variant.calculatedPrice!;
            print('       💵 Currency: ${price.currencyCode}');
            if (price.effectiveAmount != null) {
              final amount = (price.effectiveAmount! / 100).toStringAsFixed(2);
              print('       💸 Price: \$${amount}');
            }
          } else {
            print('       ⚠️ NO PRICING CONFIGURED');
          }
        }
      } else {
        print('   ⚠️ No variants found');
      }
      print('');
    }

    print('2️⃣ Testing Regional Information');
    print('-' * 30);

    // Check regions and currencies
    try {
      final regionResponse = await client.fetch<Map<String, dynamic>>(
        '/store/regions',
      );
      final regions = regionResponse['regions'] as List<dynamic>?;

      if (regions != null && regions.isNotEmpty) {
        print('🌍 Available regions:');
        for (final regionData in regions) {
          final region = regionData as Map<String, dynamic>;
          print('   • ${region['name']} (${region['currency_code']})');
          print('     🆔 ID: ${region['id']}');
        }
      } else {
        print('⚠️ No regions configured');
      }
    } catch (e) {
      print('❌ Error fetching regions: $e');
    }

    print('');
    print('3️⃣ Testing Cart Creation');
    print('-' * 25);

    try {
      // Try to create a cart
      final cart = await store.cart.create({
        'currency_code': 'thb', // Using your Thai Baht currency
      });

      if (cart != null) {
        print('✅ Cart created successfully!');
        print('   🛒 Cart ID: ${cart.id}');
        print('   💰 Currency: ${cart.currencyCode}');
        print('   🌍 Region: ${cart.regionId}');
        print('   📊 Total: ${cart.formattedTotal}');

        // Try to add a product to the cart
        if (productsResponse.products.isNotEmpty) {
          final product = productsResponse.products.first;
          if (product.variants != null && product.variants!.isNotEmpty) {
            final variant = product.variants!.first;

            print('');
            print('   📦 Adding product to cart:');
            print('   Product: ${product.title}');
            print('   Variant: ${variant.title}');

            try {
              final updatedCart = await store.cart.createLineItem(cart.id, {
                'variant_id': variant.id,
                'quantity': 1,
              });

              if (updatedCart != null) {
                print('   ✅ Product added to cart!');
                print('   📊 Item count: ${updatedCart.itemCount}');
                print('   💰 New total: ${updatedCart.formattedTotal}');

                // Check if pricing information is now available
                if (updatedCart.subtotal > 0) {
                  print('   🎉 PRICING IS WORKING! The cart has a subtotal');
                  print('   💵 Subtotal: ${updatedCart.formattedSubtotal}');
                  print('   🏷️ Tax: ${updatedCart.formattedTaxTotal}');
                } else {
                  print(
                    '   ⚠️ Cart total is 0 - pricing may not be configured',
                  );
                }
              }
            } catch (e) {
              print(
                '   ❌ Failed to add product: ${e.toString().split('\n').first}',
              );
            }
          }
        }
      } else {
        print('❌ Failed to create cart');
      }
    } catch (e) {
      print('❌ Cart test failed: $e');
    }

    print('');
    print('4️⃣ Testing Basic Promotion Features');
    print('-' * 35);

    // Test basic promotion functionality (if cart was created)
    try {
      final cart = await store.cart.create({'currency_code': 'thb'});
      if (cart != null) {
        // Try applying a test discount code
        final testCodes = ['TEST10', 'WELCOME', 'SAVE10'];

        print('🎯 Testing discount codes:');
        for (final code in testCodes) {
          try {
            print('   Testing: $code');
            await store.cart.applyDiscount(cart.id, code);
            print('   ✅ Code "$code" might be valid (no error)');
          } catch (e) {
            print('   ❌ Code "$code": ${e.toString().split('\n').first}');
          }
        }
      }
    } catch (e) {
      print('❌ Promotion test failed: $e');
    }

    print('');
    print('📋 Summary & Next Steps');
    print('=' * 25);

    final hasProducts = productsResponse.products.isNotEmpty;
    final hasVariants =
        hasProducts &&
        productsResponse.products.any((p) => p.variants?.isNotEmpty == true);

    print('✅ Backend Connection: Working');
    print(
      '${hasProducts ? '✅' : '❌'} Products: ${hasProducts ? 'Found ${productsResponse.products.length}' : 'None found'}',
    );
    print(
      '${hasVariants ? '✅' : '❌'} Product Variants: ${hasVariants ? 'Available' : 'Missing'}',
    );

    // Check if any products have pricing
    final hasPricing = productsResponse.products.any(
      (p) => p.variants?.any((v) => v.calculatedPrice != null) == true,
    );
    print(
      '${hasPricing ? '✅' : '⚠️'} Pricing: ${hasPricing ? 'Configured' : 'Needs Setup'}',
    );

    if (!hasPricing) {
      print('');
      print('🔧 To set up pricing:');
      print('   1. Go to your Medusa Admin dashboard');
      print('   2. Navigate to Products');
      print('   3. Edit each product');
      print('   4. Set prices for each variant');
      print('   5. Configure regions and currencies');
      print('   6. Run this test again');
    } else {
      print('');
      print('🎉 Your pricing setup looks good!');
      print('   You can now test promotions and discounts');
    }

    print('');
    print('💡 Medusa Admin typically runs on:');
    print('   http://localhost:7001 or http://localhost:9000/app');
  } catch (e) {
    print('❌ Error during analysis: $e');
  } finally {
    client.dispose();
  }
}
