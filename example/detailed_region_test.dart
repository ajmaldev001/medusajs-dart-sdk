import 'dart:convert';
import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

/// Test with detailed error tracking to identify the exact type casting issue
Future<void> main() async {
  print('🔍 Detailed Region Parsing Test');
  print('=' * 40);

  final config = MedusaConfig(
    baseUrl: 'http://localhost:9000',
    publishableKey:
        'pk_91b3a86dc075c322be390706c681561c525df7c54f4e54bf574b28e837d78714',
    debug: true,
  );

  final client = MedusaClient(config);

  try {
    print('📡 Step 1: Get raw JSON data...');
    final rawResponse = await client.fetch<Map<String, dynamic>>(
      '/store/regions',
    );
    final regionsData = rawResponse['regions'] as List;
    final firstRegion = regionsData[0] as Map<String, dynamic>;

    print('✅ Raw data retrieved');
    print('   Region keys: ${firstRegion.keys.toList()}');
    print('');

    print('📡 Step 2: Try to parse Region manually...');
    try {
      final region = Region.fromJson(firstRegion);
      print('✅ Region parsed successfully!');
      print('   Region: ${region.name} (${region.currencyCode})');
      print('   Tax Rate: ${region.taxRate}');
    } catch (e, stackTrace) {
      print('❌ Region parsing failed: $e');
      print('   Stack trace: $stackTrace');
      print('');

      // Let's try to identify which field is causing the issue
      print('🔍 Field-by-field analysis:');

      final testFields = {
        'id': firstRegion['id'],
        'name': firstRegion['name'],
        'currency_code': firstRegion['currency_code'],
        'tax_rate': firstRegion['tax_rate'],
        'tax_code': firstRegion['tax_code'],
        'created_at': firstRegion['created_at'],
        'updated_at': firstRegion['updated_at'],
        'deleted_at': firstRegion['deleted_at'],
        'metadata': firstRegion['metadata'],
        'countries': firstRegion['countries'],
      };

      testFields.forEach((key, value) {
        print('   $key: ${value?.runtimeType ?? 'null'} = $value');
      });

      // Check countries array
      if (firstRegion['countries'] is List) {
        final countries = firstRegion['countries'] as List;
        if (countries.isNotEmpty) {
          print('');
          print('🔍 First country analysis:');
          final firstCountry = countries[0] as Map<String, dynamic>;
          firstCountry.forEach((key, value) {
            print('     $key: ${value?.runtimeType ?? 'null'} = $value');
          });
        }
      }
    }
    print('');

    print('📡 Step 3: Test individual components...');

    // Test creating a simplified region without countries
    try {
      final simplifiedRegion = {
        'id': firstRegion['id'],
        'name': firstRegion['name'],
        'currency_code': firstRegion['currency_code'],
        'tax_rate': 0.0, // Provide a default value
      };

      final region = Region.fromJson(simplifiedRegion);
      print('✅ Simplified region works');
    } catch (e) {
      print('❌ Even simplified region fails: $e');
    }
  } finally {
    client.dispose();
  }
}
