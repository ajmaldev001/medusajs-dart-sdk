import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

/// Complete guide on how to get regions in MedusaJS Dart SDK
Future<void> main() async {
  print('🌍 Complete Guide: Getting Regions in MedusaJS Dart SDK');
  print('=' * 55);

  final config = MedusaConfig(
    baseUrl: 'http://localhost:9000',
    publishableKey:
        'pk_91b3a86dc075c322be390706c681561c525df7c54f4e54bf574b28e837d78714',
    debug: false,
  );

  final client = MedusaClient(config);

  try {
    print('📋 Method 1: Get All Regions (Recommended)');
    print('-' * 45);

    final response = await client.fetch<Map<String, dynamic>>('/store/regions');

    final regionsList = response['regions'] as List;

    print('✅ Found ${regionsList.length} regions:');

    List<Map<String, dynamic>> availableRegions = [];

    for (final regionData in regionsList) {
      final region = regionData as Map<String, dynamic>;
      availableRegions.add(region);

      print('');
      print('🌍 ${region['name']}');
      print('   🆔 ID: ${region['id']}');
      print(
        '   💱 Currency: ${region['currency_code']?.toString().toUpperCase()}',
      );
      print(
        '   📊 Tax Rate: ${((region['tax_rate'] ?? 0) * 100).toStringAsFixed(1)}%',
      );
      print('   🧾 Includes Tax: ${region['includes_tax'] ?? false}');

      final countries = region['countries'] as List?;
      if (countries?.isNotEmpty == true) {
        final countryNames = countries!
            .map((c) => c['name'])
            .where((name) => name != null)
            .join(', ');
        if (countryNames.isNotEmpty) {
          print('   🏳️ Countries: $countryNames');
        }
      }
    }

    print('');
    print('📋 Method 2: Get Specific Region by ID');
    print('-' * 45);

    if (availableRegions.isNotEmpty) {
      final firstRegion = availableRegions.first;
      final regionId = firstRegion['id'] as String;

      final regionResponse = await client.fetch<Map<String, dynamic>>(
        '/store/regions/$regionId',
      );

      final region = regionResponse['region'] as Map<String, dynamic>;

      print('✅ Retrieved specific region:');
      print('   🌍 Name: ${region['name']}');
      print('   🆔 ID: ${region['id']}');
      print('   💱 Currency: ${region['currency_code']}');
    }

    print('');
    print('📋 Method 3: Find Region by Currency');
    print('-' * 45);

    final thbRegion = availableRegions.firstWhere(
      (region) => (region['currency_code'] as String?)?.toLowerCase() == 'thb',
      orElse: () => throw Exception('THB region not found'),
    );

    print('✅ Found THB region:');
    print('   🌍 Name: ${thbRegion['name']}');
    print('   🆔 ID: ${thbRegion['id']}');

    // Store the region ID for use in other operations
    final regionId = thbRegion['id'] as String;

    print('');
    print('📋 Method 4: Use Region for Product Pricing');
    print('-' * 45);

    final productsResponse = await client.fetch<Map<String, dynamic>>(
      '/store/products',
      query: {'region_id': regionId, 'limit': 3},
    );

    final products = productsResponse['products'] as List;
    print('✅ Products with regional pricing:');

    for (final productData in products) {
      final product = productData as Map<String, dynamic>;
      print('   📦 ${product['title']}');

      final variants = product['variants'] as List?;
      if (variants?.isNotEmpty == true) {
        final variant = variants!.first as Map<String, dynamic>;
        final calculatedPrice =
            variant['calculated_price'] as Map<String, dynamic>?;

        if (calculatedPrice != null) {
          final amount = calculatedPrice['original_amount'];
          if (amount != null) {
            print(
              '      💰 Price: ${amount.toStringAsFixed(2)} ${thbRegion['currency_code']?.toString().toUpperCase()}',
            );
          }
        }
      }
    }

    print('');
    print('📋 Code Examples for Your App');
    print('-' * 45);

    print('''
// 1. Get all regions
Future<List<Map<String, dynamic>>> getRegions() async {
  final response = await client.fetch<Map<String, dynamic>>('/store/regions');
  return (response['regions'] as List).cast<Map<String, dynamic>>();
}

// 2. Find region by currency
Map<String, dynamic>? findRegionByCurrency(List<Map<String, dynamic>> regions, String currency) {
  try {
    return regions.firstWhere(
      (region) => (region['currency_code'] as String?)?.toLowerCase() == currency.toLowerCase(),
    );
  } catch (e) {
    return null;
  }
}

// 3. Get products with regional pricing
Future<List<Map<String, dynamic>>> getProductsWithPricing(String regionId) async {
  final response = await client.fetch<Map<String, dynamic>>(
    '/store/products',
    query: {'region_id': regionId},
  );
  return (response['products'] as List).cast<Map<String, dynamic>>();
}

// 4. Create cart with region
Future<Map<String, dynamic>> createCartWithRegion(String regionId) async {
  final response = await client.fetch<Map<String, dynamic>>(
    '/store/carts',
    method: 'POST',
    body: {'region_id': regionId},
  );
  return response['cart'] as Map<String, dynamic>;
}
''');

    print('✅ Summary:');
    print('   • Use direct API calls: client.fetch("/store/regions")');
    print('   • Store region ID as constant for your app');
    print('   • Always include region_id for pricing operations');
    print('   • Current Thai region ID: $regionId');
  } catch (e) {
    print('❌ Error: $e');
    print('');
    print('💡 Troubleshooting:');
    print('   • Check if Medusa backend is running on localhost:9000');
    print('   • Verify publishable key is correct');
    print('   • Ensure at least one region is configured in Medusa Admin');
  }
}
