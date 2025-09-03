import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

/// Demonstrate improved type safety with proper types instead of Map<String, dynamic>
void main() {
  print('=== Medusa.js Dart SDK v2.10.1 - Type Safety Improvements ===\n');

  // 1. Demonstrate improved address handling
  demonstrateAddressTypes();

  // 2. Demonstrate improved product variant options
  demonstrateVariantOptions();

  // 3. Show the difference between proper types and Map<String, dynamic>
  demonstrateTypeSafety();

  print('\n✅ All type safety improvements working correctly!');
}

/// Show improved address type handling
void demonstrateAddressTypes() {
  print('1. Address Type Improvements');
  print('-----------------------------');

  // Before: Using Map<String, dynamic> (loose typing)
  final oldAddressData = <String, dynamic>{
    'firstName': 'John',
    'lastName': 'Doe',
    'address1': '123 Main St',
    'city': 'New York',
    'postalCode': '10001',
    'countryCode': 'US',
  };
  print('❌ Before: Map<String, dynamic> - no compile-time safety');
  print('   ${oldAddressData.runtimeType}');
  // No compile-time validation, typos possible
  print(
    '   firstName: ${oldAddressData['fistName']}',
  ); // Typo! Returns null silently

  // After: Using proper AddressRequest type
  final newAddress = AddressRequest(
    firstName: 'John',
    lastName: 'Doe',
    address1: '123 Main St',
    city: 'New York',
    postalCode: '10001',
    countryCode: 'US',
  );

  print('✅ After: AddressRequest type - full compile-time safety');
  print('   ${newAddress.runtimeType}');
  print('   firstName: ${newAddress.firstName}'); // Compile-time validated
  print('   fullName: ${newAddress.fullName}'); // Helpful getters available
  print(
    '   formattedAddress: ${newAddress.formattedAddress.replaceAll('\n', ', ')}',
  );

  // Can be easily converted to JSON for API calls
  print('   JSON: ${newAddress.toJson()}');
  print('');
}

/// Show improved product variant option handling
void demonstrateVariantOptions() {
  print('2. Product Variant Options Type Improvements');
  print('----------------------------------------------');

  // Before: Using Map<String, dynamic> for options
  final oldOptions = <String, dynamic>{'color': 'red', 'size': 'large'};
  print('❌ Before: Map<String, dynamic> options - no structure validation');
  print('   ${oldOptions.runtimeType}');

  // After: Using proper ProductVariantOptionRequest list
  final newOptions = [
    ProductVariantOptionRequest(optionId: 'opt_color', value: 'red'),
    ProductVariantOptionRequest(
      optionId: 'opt_size',
      value: 'large',
      metadata: {'display_order': 1},
    ),
  ];

  print(
    '✅ After: List<ProductVariantOptionRequest> - structured and validated',
  );
  print('   ${newOptions.runtimeType}');
  print('   Options count: ${newOptions.length}');
  print(
    '   First option: ${newOptions.first.optionId} = ${newOptions.first.value}',
  );
  print('   JSON: ${newOptions.map((o) => o.toJson()).toList()}');
  print('');
}

/// Demonstrate type safety differences
void demonstrateTypeSafety() {
  print('3. Type Safety Benefits');
  print('-----------------------');

  // Create a draft order with proper types
  final draftOrderRequest = CreateDraftOrderRequest(
    email: 'customer@example.com',
    regionId: 'reg_us',
    shippingAddress: AddressRequest(
      firstName: 'Jane',
      lastName: 'Smith',
      address1: '456 Oak Ave',
      city: 'San Francisco',
      countryCode: 'US',
      postalCode: '94102',
    ),
    billingAddress: AddressRequest(
      firstName: 'Jane',
      lastName: 'Smith',
      address1: '456 Oak Ave',
      city: 'San Francisco',
      countryCode: 'US',
      postalCode: '94102',
    ),
    metadata: {'order_source': 'web'},
  );

  print('✅ Type-safe draft order creation:');
  print('   Customer: ${draftOrderRequest.email}');
  print('   Shipping: ${draftOrderRequest.shippingAddress?.fullName}');
  print('   Billing: ${draftOrderRequest.billingAddress?.fullName}');
  print(
    '   Same address: ${draftOrderRequest.shippingAddress?.formattedAddress == draftOrderRequest.billingAddress?.formattedAddress}',
  );

  // Create product variant with proper option types
  final variantRequest = CreateProductVariantRequest(
    title: 'Red Large T-Shirt',
    sku: 'TSHIRT-RED-L',
    options: [
      ProductVariantOptionRequest(optionId: 'opt_color', value: 'red'),
      ProductVariantOptionRequest(optionId: 'opt_size', value: 'large'),
    ],
  );

  print('\n✅ Type-safe variant creation:');
  print('   Title: ${variantRequest.title}');
  print('   SKU: ${variantRequest.sku}');
  print(
    '   Options: ${variantRequest.options?.map((o) => '${o.optionId}=${o.value}').join(', ')}',
  );

  print('\n🎯 Benefits of proper typing:');
  print('   • Compile-time error detection');
  print('   • IDE autocompletion and hints');
  print('   • Better code documentation');
  print('   • Easier refactoring');
  print('   • Runtime type safety');
  print('   • Helpful utility methods');
}
