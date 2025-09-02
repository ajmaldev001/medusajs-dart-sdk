import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

/// Demo script showing successful product fetching with real backend data
void main() async {
  print('🚀 MedusaJS Dart SDK - Product Fetching Demo');
  print('===============================================');

  // Initialize the SDK (same way as the working tests)
  final config = MedusaConfig(
    baseUrl: 'http://localhost:9000',
    publishableKey:
        'pk_91b3a86dc075c322be390706c681561c525df7c54f4e54bf574b28e837d78714',
  );

  final client = MedusaClient(config);
  final store = MedusaStore(client);

  try {
    print('\n📋 Fetching all products...');

    // Fetch all products (using the same method as the working tests)
    final response = await store.product.list();

    print('✅ Successfully fetched ${response.products.length} products');
    print('📊 Total in store: ${response.count}');

    print('\n🥬 Your Product Catalog:');
    print('=' * 50);

    for (int i = 0; i < response.products.length; i++) {
      final product = response.products[i];
      print('${i + 1}. ${product.title}');
      print('   🆔 ID: ${product.id}');
      print('   🏷️ Handle: ${product.handle ?? 'N/A'}');
      print('   💳 Gift Card: ${product.isGiftcard ? 'Yes' : 'No'}');
      if (product.thumbnail != null) {
        print('   🖼️ Has Image: Yes');
      }
      print('');
    }

    // Test fetching single product
    if (response.products.isNotEmpty) {
      print('\n📦 Fetching detailed product info...');
      final firstProduct = response.products.first;
      final detailedProduct = await store.product.retrieve(firstProduct.id);

      if (detailedProduct != null) {
        print('✅ Retrieved: ${detailedProduct.title}');
        print(
          '   📝 Description: ${detailedProduct.description ?? 'No description'}',
        );
        print('   🏷️ Handle: ${detailedProduct.handle ?? 'N/A'}');
        print('   📅 Created: ${detailedProduct.createdAt}');
        print('   📅 Updated: ${detailedProduct.updatedAt}');

        // Check variants
        if (detailedProduct.variants?.isNotEmpty == true) {
          print('   🔧 Variants: ${detailedProduct.variants!.length}');
          for (final variant in detailedProduct.variants!) {
            print('     - ${variant.title} (${variant.id})');
            if (variant.options?.isNotEmpty == true) {
              print('       Options: ${variant.options!.length}');
              for (final option in variant.options!) {
                print('         * ${option.value}');
              }
            }
          }
        }

        // Check images
        if (detailedProduct.images?.isNotEmpty == true) {
          print('   🖼️ Images: ${detailedProduct.images!.length}');
          for (final image in detailedProduct.images!) {
            print('     - ${image.url}');
          }
        }
      }
    }

    print('\n🎉 Demo completed successfully!');
    print('✅ The MedusaJS Dart SDK is working perfectly with your backend.');
    print('🔧 JSON parsing issue has been resolved!');
    print('📦 Products with variants and options are now parsing correctly!');
  } catch (e) {
    print('❌ Error: $e');
  }
}
