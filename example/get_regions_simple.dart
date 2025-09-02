import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

/// Simple example showing how to get regions using direct API calls
Future<void> main() async {
  print('🌍 How to Get Regions - Simple Approach');
  print('=' * 40);

  final config = MedusaConfig(
    baseUrl: 'http://localhost:9000',
    publishableKey:
        'pk_91b3a86dc075c322be390706c681561c525df7c54f4e54bf574b28e837d78714',
  );

  final client = MedusaClient(config);

  try {
    print('📋 Getting regions using direct API call...');

    // Direct API call to get regions
    final response = await client.fetch<Map<String, dynamic>>('/store/regions');

    final regionsList = response['regions'] as List;

    print('✅ Found ${regionsList.length} regions:');
    print('');

    for (final regionData in regionsList) {
      final region = regionData as Map<String, dynamic>;

      print('🌍 Region: ${region['name']}');
      print('   🆔 ID: ${region['id']}');
      print(
        '   💱 Currency: ${region['currency_code']?.toString().toUpperCase() ?? 'N/A'}',
      );
      print(
        '   📊 Tax Rate: ${((region['tax_rate'] ?? 0) * 100).toStringAsFixed(1)}%',
      );

      // Show countries if available
      final countries = region['countries'] as List?;
      if (countries?.isNotEmpty == true) {
        final countryNames = countries!
            .map((c) => c['name'] ?? c['iso_2']?.toString().toUpperCase())
            .where((name) => name != null)
            .join(', ');
        if (countryNames.isNotEmpty) {
          print('   🏳️ Countries: $countryNames');
        }
      }
      print('');
    }

    // Find Thai region
    final thaiRegion = regionsList.firstWhere(
      (region) => (region['currency_code'] as String?)?.toLowerCase() == 'thb',
      orElse: () => null,
    );

    if (thaiRegion != null) {
      print('🇹🇭 Thai Region Found:');
      print('   Name: ${thaiRegion['name']}');
      print('   ID: ${thaiRegion['id']}');
      print('   Currency: ${thaiRegion['currency_code']}');
      print('');

      print('💡 You can use this region ID in your code:');
      print('   const String regionId = "${thaiRegion['id']}";');
      print('');
    }

    print('📋 How to use regions in your code:');
    print('');
    print('// Method 1: Direct API call');
    print('final regions = await client.fetch("/store/regions");');
    print('');
    print('// Method 2: Get specific region');
    print('final region = await client.fetch("/store/regions/REGION_ID");');
    print('');
    print('// Method 3: Use region for products with pricing');
    print('final products = await client.fetch("/store/products", ');
    print('  query: {"region_id": "REGION_ID"});');
    print('');
    print('// Method 4: Create cart with region');
    print('final cart = await client.fetch("/store/carts",');
    print('  method: "POST", body: {"region_id": "REGION_ID"});');
  } catch (e) {
    print('❌ Error: $e');
  }
}
