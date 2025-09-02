import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

/// Demonstrates using the SDK's built-in region resources
/// instead of direct API calls
Future<void> main() async {
  print('🛠️  SDK Regions Demo: Using Built-in Resources');
  print('=' * 50);

  final config = MedusaConfig(
    baseUrl: 'http://localhost:9000',
    publishableKey:
        'pk_91b3a86dc075c322be390706c681561c525df7c54f4e54bf574b28e837d78714',
    debug: false,
  );

  final medusa = Medusa(config);

  try {
    print(
      '📋 Method 1: Using Store Region Resource (Recommended for Storefronts)',
    );
    print('-' * 65);

    // Using the SDK's built-in store region resource
    final regionsResponse = await medusa.store.region.list();

    print('✅ Found ${regionsResponse.data.length} regions via SDK:');

    Region? thaiRegion;

    for (final region in regionsResponse.data) {
      print('');
      print('🌍 ${region.name}');
      print('   🆔 ID: ${region.id}');
      print('   💱 Currency: ${region.currencyCode.toUpperCase()}');
      print('   📊 Tax Rate: ${(region.taxRate * 100).toStringAsFixed(1)}%');
      print('   🧾 Includes Tax: ${region.includesTax}');

      if (region.currencyCode.toLowerCase() == 'thb') {
        thaiRegion = region;
        print('   ⭐ This is our Thai region!');
      }
    }

    print('\n' + '=' * 50);
    print('📋 Method 2: Retrieve Specific Region by ID');
    print('-' * 40);

    if (thaiRegion != null) {
      // Retrieve specific region by ID using SDK
      final specificRegion = await medusa.store.region.retrieve(thaiRegion.id);

      if (specificRegion != null) {
        print('✅ Retrieved Thai region details:');
        print('   🆔 ID: ${specificRegion.id}');
        print('   📍 Name: ${specificRegion.name}');
        print('   💱 Currency: ${specificRegion.currencyCode.toUpperCase()}');
        print(
          '   📊 Tax Rate: ${(specificRegion.taxRate * 100).toStringAsFixed(1)}%',
        );

        // Show countries if available
        if (specificRegion.countries?.isNotEmpty == true) {
          final countryNames = specificRegion.countries!
              .map((c) => c.displayName ?? c.name)
              .join(', ');
          print('   🌏 Countries: $countryNames');
        }
      }
    }

    print('\n' + '=' * 50);
    print('🛒 Method 3: Using Region for Cart Creation');
    print('-' * 42);

    if (thaiRegion != null) {
      print('✅ Creating cart with Thai region using SDK:');

      // Create cart with the region using SDK's cart resource
      final cartResponse = await medusa.store.cart.create({
        'region_id': thaiRegion.id,
      });

      if (cartResponse != null) {
        print('   🆔 Cart ID: ${cartResponse.id}');
        print('   💱 Currency: ${cartResponse.currencyCode.toUpperCase()}');
        print('   📍 Region ID: ${cartResponse.regionId}');
        print(
          '   💰 Total: ${(cartResponse.total ?? 0).toStringAsFixed(2)} ${cartResponse.currencyCode.toUpperCase()}',
        );
      }
    }

    print('\n' + '=' * 50);
    print('🔍 Method 4: Using Query Parameters');
    print('-' * 35);

    // Use query parameters with SDK (expand related data)
    final expandedRegions = await medusa.store.region.list(
      query: {'expand': 'countries,payment_providers,fulfillment_providers'},
    );

    print(
      '✅ Retrieved ${expandedRegions.data.length} regions with expanded data:',
    );

    for (final region in expandedRegions.data) {
      if (region.currencyCode.toLowerCase() == 'thb') {
        print('');
        print('🌍 ${region.name} (Expanded Data):');
        print('   🆔 ID: ${region.id}');
        print('   💱 Currency: ${region.currencyCode.toUpperCase()}');

        if (region.countries?.isNotEmpty == true) {
          print('   🌏 Countries: ${region.countries!.length} countries');
          for (final country in region.countries!) {
            print('      - ${country.displayName ?? country.name}');
          }
        }

        if (region.paymentProviders?.isNotEmpty == true) {
          print(
            '   💳 Payment Providers: ${region.paymentProviders!.length} providers',
          );
        }

        if (region.fulfillmentProviders?.isNotEmpty == true) {
          print(
            '   📦 Fulfillment Providers: ${region.fulfillmentProviders!.length} providers',
          );
        }
      }
    }

    print('\n' + '=' * 50);
    print('💡 Best Practices for Using SDK Region Resources');
    print('-' * 52);
    print('');
    print('1. ✅ Use client.store.region.list() for storefront apps');
    print('2. ✅ Use client.admin.region.list() for admin operations');
    print('3. ✅ Cache region data in your app to avoid repeated calls');
    print('4. ✅ Use expand parameter to get related data in one call');
    print('5. ✅ Handle nullable fields appropriately');
    print('6. ✅ Use region.id for cart creation and product pricing');
    print('');
    print('Example Usage in Your App:');
    print('```dart');
    print('// Get all regions');
    print('final regions = await medusa.store.region.list();');
    print('');
    print('// Find region by currency');
    print('final thbRegion = regions.data.firstWhere(');
    print('  (r) => r.currencyCode.toLowerCase() == "thb",');
    print('  orElse: () => regions.data.first,');
    print(');');
    print('');
    print('// Create cart with region');
    print('final cart = await medusa.store.cart.create({');
    print('  "region_id": thbRegion.id,');
    print('});');
    print('```');
  } catch (e, stackTrace) {
    print('❌ Error occurred: $e');
    print('Stack trace: $stackTrace');
  } finally {
    // Clean up resources
    medusa.dispose();
  }
}
