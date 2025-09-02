import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

/// Verify the 7DOT7 promotion is working correctly using SDK methods
Future<void> main() async {
  const backendUrl = 'http://localhost:9000';
  const publishableKey =
      'pk_91b3a86dc075c322be390706c681561c525df7c54f4e54bf574b28e837d78714';
  const regionId = 'reg_01JXY3EF2XR07SRHE5PER76F3V';

  print('✅ 7DOT7 Promotion Verification Test (SDK Methods)');
  print('=' * 50);

  final config = MedusaConfig(
    baseUrl: backendUrl,
    publishableKey: publishableKey,
    debug: false,
  );

  final client = MedusaClient(config);
  final store = MedusaStore(client);

  try {
    print('🔍 Step 1: Finding Kale product using SDK...');

    // Get Kale using SDK method
    final productResponse = await store.product.list(
      query: {'region_id': regionId, 'handle': 'kale'},
    );

    if (productResponse.products.isEmpty) {
      throw Exception('Kale product not found');
    }

    final kaleProduct = productResponse.products.first;
    final kaleVariant = kaleProduct.variants!.first;

    print('   ✅ Found Kale: ${kaleProduct.title}');
    print(
      '   💰 Variant price: ${kaleVariant.calculatedPrice?.calculatedAmount?.toStringAsFixed(2) ?? 'N/A'} THB',
    );

    print('\n🛒 Step 2: Creating cart using SDK...');

    // Create cart using SDK method
    final cart = await store.cart.create({'region_id': regionId});

    if (cart == null) {
      throw Exception('Failed to create cart');
    }

    final cartId = cart.id;
    print('   ✅ Cart created: $cartId');

    print('\n➕ Step 3: Adding Kale to cart using SDK...');

    // Add item to cart using SDK method
    final cartWithItem = await store.cart.createLineItem(cartId, {
      'variant_id': kaleVariant.id,
      'quantity': 1,
    });

    if (cartWithItem == null) {
      throw Exception('Failed to add item to cart');
    }

    print('   ✅ Kale added to cart');

    // Get cart state before promotion
    final cartBefore = await store.cart.retrieve(cartId);

    if (cartBefore == null) {
      throw Exception('Failed to retrieve cart');
    }

    final originalTotal = cartBefore.total ?? 0.0;
    final originalSubtotal = cartBefore.subtotal ?? 0.0;

    print('\n📊 BEFORE 7DOT7:');
    print('   Subtotal: ${originalSubtotal.toStringAsFixed(2)} THB');
    print('   Total: ${originalTotal.toStringAsFixed(2)} THB');

    print('\n🎯 Step 4: Applying 7DOT7 promotion using SDK...');

    // Apply 7DOT7 using SDK method - try discount first, then promo_codes
    Cart? cartAfterPromo;

    try {
      // First try the applyDiscount method
      cartAfterPromo = await store.cart.applyDiscount(cartId, '7DOT7');
      print('   ✅ Applied promotion using applyDiscount method');
    } catch (e) {
      print('   ⚠️  applyDiscount failed: $e');
      print('   🔄 Trying update method with promo_codes...');

      // If that fails, try the update method with promo_codes
      cartAfterPromo = await store.cart.update(cartId, {
        'promo_codes': ['7DOT7'],
      });
      print('   ✅ Applied promotion using update method with promo_codes');
    }

    if (cartAfterPromo == null) {
      throw Exception('Failed to apply 7DOT7 promotion');
    }

    final newTotal = cartAfterPromo.total ?? 0.0;
    final newSubtotal = cartAfterPromo.subtotal ?? 0.0;
    final discountTotal = cartAfterPromo.discountTotal ?? 0.0;

    print('\n📊 AFTER 7DOT7:');
    print('   Subtotal: ${newSubtotal.toStringAsFixed(2)} THB');
    print('   Discount Total: ${discountTotal.toStringAsFixed(2)} THB');
    print('   Final Total: ${newTotal.toStringAsFixed(2)} THB');

    // Calculate actual discount
    final actualDiscount = originalTotal - newTotal;
    final discountPercentage = (actualDiscount / originalTotal) * 100;

    print('\n🎯 VERIFICATION:');
    print('   💰 Price reduction: ${actualDiscount.toStringAsFixed(2)} THB');
    print(
      '   📊 Discount percentage: ${discountPercentage.toStringAsFixed(2)}%',
    );

    if ((discountPercentage - 7.0).abs() < 0.5) {
      print('   ✅ CORRECT: 7DOT7 gives exactly 7% discount!');
    } else {
      print(
        '   ❌ INCORRECT: Expected 7%, got ${discountPercentage.toStringAsFixed(2)}%',
      );
    }

    // Show calculation
    print('\n🧮 CALCULATION DETAILS:');
    print(
      '   ${originalTotal.toStringAsFixed(2)} × 7% = ${(originalTotal * 0.07).toStringAsFixed(2)} THB expected discount',
    );
    print(
      '   ${originalTotal.toStringAsFixed(2)} - ${actualDiscount.toStringAsFixed(2)} = ${(originalTotal - actualDiscount).toStringAsFixed(2)} THB expected final price',
    );
    print('   Actual final price: ${newTotal.toStringAsFixed(2)} THB');

    print('\n✅ All operations completed using SDK methods successfully!');
  } catch (e, stackTrace) {
    print('❌ Test failed: $e');
    print('Stack trace: $stackTrace');
  }
}
