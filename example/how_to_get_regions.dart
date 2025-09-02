import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

/// Example showing how to get regions in MedusaJS Dart SDK
Future<void> main() async {
  print('🌍 How to Get Regions in MedusaJS Dart SDK');
  print('=' * 45);

  // Initialize the SDK
  final config = MedusaConfig(
    baseUrl: 'http://localhost:9000',
    publishableKey:
        'pk_91b3a86dc075c322be390706c681561c525df7c54f4e54bf574b28e837d78714',
    debug: false,
  );

  final client = MedusaClient(config);
  final store = MedusaStore(client);

  try {
    print('📋 Method 1: List All Regions (Store API)');
    print('-' * 40);

    // Get all regions using store resource
    final regions = await store.region.list();

    print('✅ Found ${regions.count} regions:');
    for (final region in regions.data) {
      print('   🌍 ${region.name}');
      print('      🆔 ID: ${region.id}');
      print('      💱 Currency: ${region.currencyCode.toUpperCase()}');
      print('      📊 Tax Rate: ${(region.taxRate * 100).toStringAsFixed(1)}%');
      if (region.countries?.isNotEmpty == true) {
        final countries = region.countries!.map((c) => c.name).join(', ');
        print('      🏳️ Countries: $countries');
      }
      print('');
    }

    print('📋 Method 2: Get Specific Region by ID');
    print('-' * 40);

    if (regions.data.isNotEmpty) {
      final firstRegion = regions.data.first;
      final specificRegion = await store.region.retrieve(firstRegion.id);

      if (specificRegion != null) {
        print('✅ Retrieved region: ${specificRegion.name}');
        print('   🆔 ID: ${specificRegion.id}');
        print('   💱 Currency: ${specificRegion.currencyCode}');
        print('   📊 Tax Rate: ${specificRegion.taxRate}');
        print('   🏷️ Tax Code: ${specificRegion.taxCode ?? 'N/A'}');
        print('   🧾 Includes Tax: ${specificRegion.includesTax ?? false}');
      }
    }

    print('📋 Method 3: Direct API Call for Regions');
    print('-' * 40);

    // Direct API call approach
    final apiResponse = await client.fetch<Map<String, dynamic>>(
      '/store/regions',
    );

    final regionsList = apiResponse['regions'] as List;
    print('✅ API returned ${regionsList.length} regions directly');

    for (final regionData in regionsList) {
      print('   🌍 ${regionData['name']} (${regionData['id']})');
    }

    print('📋 Method 4: Find Region by Currency');
    print('-' * 40);

    // Find Thai Baht region
    final thbRegion = regions.data.firstWhere(
      (region) => region.currencyCode.toLowerCase() == 'thb',
      orElse: () => throw Exception('THB region not found'),
    );

    print('✅ Found THB region:');
    print('   🌍 Name: ${thbRegion.name}');
    print('   🆔 ID: ${thbRegion.id}');
    print('   💱 Currency: ${thbRegion.currencyCode}');

    print('📋 Method 5: Using Region for Product Pricing');
    print('-' * 40);

    // Example: Use region for product pricing
    final productsWithPricing = await client.fetch<Map<String, dynamic>>(
      '/store/products',
      query: {'region_id': thbRegion.id, 'limit': 3},
    );

    final products = productsWithPricing['products'] as List;
    print('✅ Products with ${thbRegion.name} pricing:');
    for (final productData in products) {
      print('   📦 ${productData['title']}');
      final variants = productData['variants'] as List?;
      if (variants?.isNotEmpty == true) {
        final variant = variants!.first;
        final calculatedPrice = variant['calculated_price'];
        if (calculatedPrice != null) {
          final amount = calculatedPrice['original_amount'];
          print(
            '      💰 Price: ${amount?.toStringAsFixed(2) ?? 'N/A'} ${thbRegion.currencyCode.toUpperCase()}',
          );
        }
      }
    }

    print('📋 Summary: Ways to Get Regions');
    print('-' * 40);
    print('✅ store.region.list() - Get all regions');
    print('✅ store.region.retrieve(id) - Get specific region');
    print('✅ client.fetch("/store/regions") - Direct API call');
    print('✅ Filter regions by currency/criteria');
    print('✅ Use region ID for pricing and cart operations');
  } catch (e) {
    print('❌ Error getting regions: $e');
    print('');
    print('💡 Make sure:');
    print('   • Medusa backend is running');
    print('   • At least one region is configured');
    print('   • Publishable key is correct');
  }
}
