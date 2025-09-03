import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

/// Demonstrates the v2.10.1 features of the Medusa Dart SDK
///
/// This example shows:
/// 1. Performance improvements in cart operations
/// 2. Enhanced withDeleted() query functionality
/// 3. Improved flexible parameter handling with Map<String, dynamic>
/// 4. Shipping option types management (v2.10 feature)
Future<void> main() async {
  print('🚀 Medusa Dart SDK v2.10.1 Features Demo');
  print('=' * 50);

  // Initialize SDK with v2.10.1 configuration
  final config = MedusaConfig(
    baseUrl: 'https://demo.medusajs.com', // Use demo server for examples
    publishableKey: 'pk_demo_123',
    debug: true,
    timeout: Duration(seconds: 30),
    maxRetries: 3,
  );

  final medusa = Medusa(config);

  print('✅ SDK initialized with v2.10.1 features');
  print('');

  // 1. Demonstrate enhanced query building with withDeleted()
  print('📋 1. Enhanced Query Building (v2.10.1)');
  print('-' * 30);

  // Build a complex query with the new withDeleted() feature
  final advancedQuery =
      QueryBuilder()
          .expand(['variants', 'images', 'options'])
          .paginate(limit: 10, offset: 0)
          .orderBy('updated_at', ascending: false)
          .search('premium')
          .withDeleted() // Include soft-deleted records
          .whereAll({'status': 'published', 'discountable': true})
          .dateRange(
            'created_at',
            from: DateTime.now().subtract(Duration(days: 90)),
          )
          .build();

  print('🔍 Query built with parameters:');
  advancedQuery.forEach((key, value) {
    print('  $key: $value');
  });
  print('');

  // 2. Demonstrate flexible metadata handling
  print('📦 2. Flexible Metadata Handling');
  print('-' * 30);

  // Example of flexible product data with custom metadata
  final flexibleProductData = {
    'title': 'Premium Coffee Beans v2.10.1',
    'description': 'High-quality coffee with custom attributes',
    'status': 'draft',
    'discountable': true,
    'metadata': {
      // Custom business fields
      'roast_level': 'medium',
      'origin_country': 'Colombia',
      'processing_method': 'washed',
      // Nested configuration
      'shipping_config': {
        'weight_class': 'standard',
        'fragile': false,
        'temperature_sensitive': true,
      },
      // Dynamic pricing rules
      'pricing_rules': {
        'bulk_discount_threshold': 10,
        'member_discount': 0.15,
        'seasonal_markup': 0.05,
      },
      // Integration data
      'external_systems': {
        'erp_id': 'ERP-COF-001',
        'warehouse_codes': ['WH-001', 'WH-003'],
        'supplier_info': {
          'supplier_id': 'SUPP-COL-FARM-001',
          'contact': 'farm@colombia-coffee.co',
        },
      },
    },
  };

  print('🔧 Created flexible product data with custom metadata:');
  print('  Title: ${flexibleProductData['title']}');
  print(
    '  Roast Level: ${(flexibleProductData['metadata'] as Map)['roast_level']}',
  );
  print(
    '  Shipping Config: ${(flexibleProductData['metadata'] as Map)['shipping_config']}',
  );
  print(
    '  External ERP ID: ${((flexibleProductData['metadata'] as Map)['external_systems'] as Map)['erp_id']}',
  );
  print('');

  // 3. Demonstrate shipping option types (v2.10 feature)
  print('🚚 3. Shipping Option Types (v2.10 Feature)');
  print('-' * 30);

  final expressShippingType = {
    'label': 'Express Delivery',
    'description': 'Fast shipping option with tracking',
    'code': 'express',
  };

  final standardShippingType = {
    'label': 'Standard Shipping',
    'description': 'Regular shipping option',
    'code': 'standard',
  };

  final overnightShippingType = {
    'label': 'Overnight Express',
    'description': 'Next-day delivery for urgent orders',
    'code': 'overnight',
  };

  print('📦 Shipping option types configured:');
  print(
    '  Express: ${expressShippingType['label']} (${expressShippingType['code']})',
  );
  print(
    '  Standard: ${standardShippingType['label']} (${standardShippingType['code']})',
  );
  print(
    '  Overnight: ${overnightShippingType['label']} (${overnightShippingType['code']})',
  );
  print('');

  // 4. Demonstrate performance-optimized cart operations
  print('🛒 4. Performance-Optimized Cart Operations (v2.10.1)');
  print('-' * 30);

  // Example cart operations that benefit from v2.10.1 performance improvements
  final cartCreateData = {
    'region_id': 'reg_demo',
    'metadata': {
      'session_id': 'sess_${DateTime.now().millisecondsSinceEpoch}',
      'user_agent': 'Dart SDK v2.10.1 Demo',
      'created_from': 'mobile_app',
      'marketing_source': 'email_campaign',
    },
  };

  print('🛍️ Cart creation data prepared:');
  print('  Region: ${cartCreateData['region_id']}');
  print('  Session ID: ${(cartCreateData['metadata'] as Map)['session_id']}');
  print('  Source: ${(cartCreateData['metadata'] as Map)['created_from']}');
  print('');

  // 5. Demonstrate enhanced error handling
  print('⚠️ 5. Enhanced Error Handling');
  print('-' * 30);

  try {
    // Simulate potential API call that benefits from flexible error handling
    print('🔄 Simulating API call with enhanced error handling...');

    // This would be a real API call in practice
    // final result = await medusa.store.product.list(query: advancedQuery);

    print('✅ API call would succeed with proper configuration');
  } on MedusaException catch (e) {
    print('🚨 Medusa-specific error handled gracefully:');
    print('  Error: ${e.message}');
    print('  Status: ${e.statusCode}');
  } catch (e) {
    print('🚨 General error handled: $e');
  }
  print('');

  // 6. Summary of v2.10.1 improvements
  print('📊 6. V2.10.1 Improvements Summary');
  print('-' * 30);
  print('✅ Cart operations performance restored (fixed regression)');
  print('✅ Enhanced withDeleted() query support');
  print('✅ Improved Map<String, dynamic> flexibility');
  print('✅ Shipping option types management (v2.10)');
  print('✅ Better error handling and resilience');
  print('✅ Maintained backward compatibility');
  print('');

  print('🎉 Demo completed! Your Medusa Dart SDK is ready for v2.10.1');

  // Clean up
  medusa.dispose();
}
