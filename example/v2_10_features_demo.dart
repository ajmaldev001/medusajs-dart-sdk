// Example demonstrating Medusa.js v2.10 features in Dart SDK
import '../lib/medusajs_dart_sdk.dart';

void main() async {
  // Initialize Medusa client for v2.10
  final medusa = Medusa(
    MedusaConfig(
      baseUrl: 'https://your-medusa-server.com',
      publishableKey:
          'pk_your_publishable_key', // Required for store operations
      apiKey: 'sk_your_api_key', // Required for admin operations
    ),
  );

  try {
    // Demonstrate new v2.10 withDeleted query feature
    print('\n=== Testing withDeleted Query (v2.10) ===');
    final productsWithDeleted = await medusa.store.product.list(
      query:
          QueryBuilder()
              .withDeleted() // New v2.10 feature
              .expand(['variants', 'categories'])
              .paginate(limit: 5)
              .build(),
    );

    print(
      'Found ${productsWithDeleted.data.length} products (including deleted)',
    );
    for (final product in productsWithDeleted.data) {
      print('- ${product.title} (ID: ${product.id})');
    }

    // Compare with normal query (without deleted records)
    final normalProducts = await medusa.store.product.list(
      query:
          QueryBuilder()
              .expand(['variants', 'categories'])
              .paginate(limit: 5)
              .build(),
    );

    print('\nFound ${normalProducts.data.length} products (active only)');

    // Demonstrate shipping options with v2.10 type support
    print('\n=== Testing Shipping Options with Types (v2.10) ===');
    final regions = await medusa.store.region.list();

    if (regions.data.isNotEmpty) {
      final firstRegion = regions.data.first;

      // Get shipping options for the region
      final shippingOptions = await medusa.store.fulfillment.listForRegion(
        firstRegion.id,
        additionalFilters: {'type_id': 'standard'}, // Filter by shipping type
      );

      print('Shipping options for region ${firstRegion.name}:');
      for (final option in shippingOptions.data) {
        print('- ${option['name']} (Type ID: ${option['type_id'] ?? 'N/A'})');
        print('  Price Type: ${option['price_type']}');
      }
    }

    // Demonstrate admin shipping option type management (v2.10)
    if (medusa.config.apiKey != null) {
      print('\n=== Admin: Managing Shipping Option Types (v2.10) ===');

      try {
        // List existing shipping option types
        final existingTypes = await medusa.admin.shippingOptionType.list();
        print('Existing shipping option types: ${existingTypes.data.length}');

        for (final type in existingTypes.data) {
          print(
            '- ${type.label} (${type.code}): ${type.description ?? 'No description'}',
          );
        }

        // Create a new shipping option type
        final newType = await medusa.admin.shippingOptionType.create(
          CreateShippingOptionTypeRequest(
            label: 'Express Delivery',
            code: 'express',
            description: 'Fast delivery within 24 hours',
          ),
        );

        if (newType != null) {
          print('Created new shipping option type: ${newType.label}');

          // Update the shipping option type
          final updatedType = await medusa.admin.shippingOptionType.update(
            newType.id,
            UpdateShippingOptionTypeRequest(
              description: 'Updated: Fast delivery within 24 hours',
            ),
          );

          if (updatedType != null) {
            print('Updated shipping option type description');
          }

          // Clean up - delete the test type
          await medusa.admin.shippingOptionType.delete(newType.id);
          print('Cleaned up test shipping option type');
        }
      } catch (e) {
        print('Admin operations require valid API key: $e');
      }
    }

    // Demonstrate enhanced query builder with v2.10 features
    print('\n=== Enhanced Query Builder (v2.10) ===');

    final advancedQuery = QueryBuilder()
        .where('status', 'published')
        .expand(['variants', 'images', 'categories'])
        .withDeleted() // Include deleted records
        .orderBy('created_at', ascending: false)
        .paginate(limit: 10, offset: 0)
        .dateRange(
          'created_at',
          from: DateTime.now().subtract(Duration(days: 30)),
          to: DateTime.now(),
        );

    print('Advanced query parameters:');
    final queryParams = advancedQuery.build();
    queryParams.forEach((key, value) {
      print('- $key: $value');
    });

    print('\n=== v2.10 Update Summary ===');
    print('✓ withDeleted() query support added');
    print('✓ Shipping Option Types management');
    print('✓ Enhanced type consistency with Map<String, dynamic>');
    print('✓ Updated to Medusa.js v2.10 compatibility');
  } catch (e) {
    print('Error: $e');
  }
}
