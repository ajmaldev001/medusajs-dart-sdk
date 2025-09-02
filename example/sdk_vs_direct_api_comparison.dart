import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

/// Compare SDK methods vs Direct API calls for the same operations
Future<void> main() async {
  const backendUrl = 'http://localhost:9000';
  const publishableKey =
      'pk_91b3a86dc075c322be390706c681561c525df7c54f4e54bf574b28e837d78714';
  const regionId = 'reg_01JXY3EF2XR07SRHE5PER76F3V';

  print('🔍 SDK Methods vs Direct API Calls Comparison');
  print('=' * 60);

  final config = MedusaConfig(
    baseUrl: backendUrl,
    publishableKey: publishableKey,
    debug: false,
  );

  final client = MedusaClient(config);
  final store = MedusaStore(client);

  try {
    print('\n📋 OPERATION 1: Fetching Products');
    print('-' * 40);

    // SDK Method
    print('🔧 Using SDK Method:');
    final sdkStartTime = DateTime.now();
    final productResponse = await store.product.list(
      query: {'region_id': regionId, 'handle': 'kale'},
    );
    final sdkEndTime = DateTime.now();
    final sdkDuration = sdkEndTime.difference(sdkStartTime);

    if (productResponse.products.isNotEmpty) {
      final product = productResponse.products.first;
      print('   ✅ Found: ${product.title}');
      print('   📦 Type safety: Product object with proper types');
      print('   ⏱️  Duration: ${sdkDuration.inMilliseconds}ms');
    }

    // Direct API Call
    print('\n🔧 Using Direct API Call:');
    final apiStartTime = DateTime.now();
    final apiResponse = await client.fetch<Map<String, dynamic>>(
      '/store/products',
      query: {'region_id': regionId, 'handle': 'kale'},
    );
    final apiEndTime = DateTime.now();
    final apiDuration = apiEndTime.difference(apiStartTime);

    if (apiResponse['products'] != null &&
        (apiResponse['products'] as List).isNotEmpty) {
      final productData = (apiResponse['products'] as List).first;
      print('   ✅ Found: ${productData['title']}');
      print('   📦 Type safety: Raw Map<String, dynamic>');
      print('   ⏱️  Duration: ${apiDuration.inMilliseconds}ms');
    }

    print('\n📋 OPERATION 2: Creating and Managing Cart');
    print('-' * 40);

    // SDK Method for Cart Creation
    print('🔧 Creating Cart with SDK:');
    final cartSdkStart = DateTime.now();
    final cart = await store.cart.create({'region_id': regionId});
    final cartSdkEnd = DateTime.now();
    final cartSdkDuration = cartSdkEnd.difference(cartSdkStart);

    if (cart != null) {
      print('   ✅ Cart created: ${cart.id}');
      print('   📦 Type: Cart object with nullable fields handled');
      print('   ⏱️  Duration: ${cartSdkDuration.inMilliseconds}ms');
    }

    // Direct API for Cart Creation
    print('\n🔧 Creating Cart with Direct API:');
    final cartApiStart = DateTime.now();
    final cartApiResponse = await client.fetch<Map<String, dynamic>>(
      '/store/carts',
      method: 'POST',
      body: {'region_id': regionId},
    );
    final cartApiEnd = DateTime.now();
    final cartApiDuration = cartApiEnd.difference(cartApiStart);

    final cartId2 = cartApiResponse['cart']['id'] as String;
    print('   ✅ Cart created: $cartId2');
    print('   📦 Type: Raw JSON, manual type casting needed');
    print('   ⏱️  Duration: ${cartApiDuration.inMilliseconds}ms');

    print('\n📋 OPERATION 3: Adding Items to Cart');
    print('-' * 40);

    final kaleVariant = productResponse.products.first.variants!.first;

    // SDK Method for Adding Items
    print('🔧 Adding item with SDK:');
    final addSdkStart = DateTime.now();
    final cartWithItem = await store.cart.createLineItem(cart!.id, {
      'variant_id': kaleVariant.id,
      'quantity': 1,
    });
    final addSdkEnd = DateTime.now();
    final addSdkDuration = addSdkEnd.difference(addSdkStart);

    if (cartWithItem != null) {
      print(
        '   ✅ Item added, total: ${cartWithItem.total?.toStringAsFixed(2) ?? 'N/A'} THB',
      );
      print('   📦 Type: Cart object with calculated totals');
      print('   ⏱️  Duration: ${addSdkDuration.inMilliseconds}ms');
    }

    // Direct API for Adding Items
    print('\n🔧 Adding item with Direct API:');
    final addApiStart = DateTime.now();
    final addApiResponse = await client.fetch<Map<String, dynamic>>(
      '/store/carts/$cartId2/line-items',
      method: 'POST',
      body: {'variant_id': kaleVariant.id, 'quantity': 1},
    );
    final addApiEnd = DateTime.now();
    final addApiDuration = addApiEnd.difference(addApiStart);

    final total = addApiResponse['cart']['total'] as num;
    print('   ✅ Item added, total: ${total.toStringAsFixed(2)} THB');
    print('   📦 Type: Raw JSON, manual number conversion');
    print('   ⏱️  Duration: ${addApiDuration.inMilliseconds}ms');

    print('\n📋 OPERATION 4: Applying Promotions');
    print('-' * 40);

    // SDK Method for Promotions
    print('🔧 Applying promotion with SDK:');
    final promoSdkStart = DateTime.now();
    Cart? cartWithPromo;

    try {
      // Try applyDiscount first (if supported)
      cartWithPromo = await store.cart.applyDiscount(cart.id, '7DOT7');
      print('   ✅ Applied using applyDiscount method');
    } catch (e) {
      // Fallback to update method
      cartWithPromo = await store.cart.update(cart.id, {
        'promo_codes': ['7DOT7'],
      });
      print('   ✅ Applied using update method with promo_codes');
    }

    final promoSdkEnd = DateTime.now();
    final promoSdkDuration = promoSdkEnd.difference(promoSdkStart);

    if (cartWithPromo != null) {
      print(
        '   💰 Final total: ${cartWithPromo.total?.toStringAsFixed(2) ?? 'N/A'} THB',
      );
      print('   📦 Type: Cart object with discount handling');
      print('   ⏱️  Duration: ${promoSdkDuration.inMilliseconds}ms');
    }

    // Direct API for Promotions
    print('\n🔧 Applying promotion with Direct API:');
    final promoApiStart = DateTime.now();
    final promoApiResponse = await client.fetch<Map<String, dynamic>>(
      '/store/carts/$cartId2',
      method: 'POST',
      body: {
        'promo_codes': ['7DOT7'],
      },
    );
    final promoApiEnd = DateTime.now();
    final promoApiDuration = promoApiEnd.difference(promoApiStart);

    final finalTotal = promoApiResponse['cart']['total'] as num;
    print('   ✅ Promotion applied');
    print('   💰 Final total: ${finalTotal.toStringAsFixed(2)} THB');
    print('   📦 Type: Raw JSON response');
    print('   ⏱️  Duration: ${promoApiDuration.inMilliseconds}ms');

    print('\n📊 SUMMARY');
    print('=' * 60);
    print('🏆 SDK Methods Benefits:');
    print('   ✅ Type safety with proper model objects');
    print('   ✅ Built-in error handling and validation');
    print('   ✅ Cleaner, more readable code');
    print('   ✅ Automatic JSON parsing and model conversion');
    print('   ✅ Nullable field handling');
    print('   ✅ IDE autocompletion and intellisense');

    print('\n⚡ Direct API Benefits:');
    print('   ✅ More control over request/response');
    print('   ✅ Can handle edge cases not covered by SDK');
    print('   ✅ Slightly faster (no model conversion overhead)');
    print('   ✅ Direct access to raw API responses');

    print('\n💡 Recommendation:');
    print('   Use SDK methods for standard operations');
    print('   Use direct API calls for custom or edge cases');
  } catch (e, stackTrace) {
    print('❌ Comparison failed: $e');
    print('Stack trace: $stackTrace');
  }
}
