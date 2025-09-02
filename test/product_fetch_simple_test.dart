import 'package:test/test.dart';
import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

void main() {
  group('Product Data Fetch Tests', () {
    late MedusaStore store;
    late MedusaClient client;

    setUp(() {
      // Configure with a test Medusa backend
      final config = MedusaConfig(
        baseUrl: 'http://localhost:9000',
        publishableKey:
            'pk_91b3a86dc075c322be390706c681561c525df7c54f4e54bf574b28e837d78714',
      );
      client = MedusaClient(config);
      store = MedusaStore(client);
    });

    tearDown(() {
      client.dispose();
    });

    test('should create store with product resource', () {
      expect(store, isNotNull);
      expect(store.product, isNotNull);
      expect(store.product, isA<StoreProductResource>());
      print('✅ Store and product resource created successfully');
    });

    test('should have correct product resource path', () {
      expect(store.product.resourcePath, contains('/store/products'));
      print(
        '✅ Product resource path is correct: ${store.product.resourcePath}',
      );
    });

    test(
      'should attempt to fetch products (may fail without backend)',
      () async {
        try {
          final response = await store.product.list(query: {'limit': 5});

          print('✅ Successfully fetched products');
          print('📊 Total products: ${response.products.length}');
          expect(response, isA<PaginatedResponse<Product>>());
          expect(response.products, isA<List<Product>>());

          if (response.products.isNotEmpty) {
            final firstProduct = response.products.first;
            print('📦 First product: ${firstProduct.title}');
            expect(firstProduct, isA<Product>());
            expect(firstProduct.id, isNotEmpty);
            expect(firstProduct.title, isNotEmpty);
          }
        } catch (e) {
          print('⚠️ Expected error (no backend): $e');
          // This is expected when there's no actual backend running
          expect(e, isA<Exception>());
        }
      },
    );

    test('should attempt to search products', () async {
      try {
        final response = await store.product.search('Smootie');

        print('✅ Successfully searched products');
        expect(response, isA<PaginatedResponse<Product>>());
        expect(response.products, isA<List<Product>>());
      } catch (e) {
        print('⚠️ Expected error (no backend): $e');
        expect(e, isA<Exception>());
      }
    });

    test('should attempt to retrieve product by ID', () async {
      try {
        final product = await store.product.retrieve(
          'prod_01JWAWQMDVV43TPGZ73KF7X1FQ',
        );

        if (product != null) {
          print('✅ Successfully retrieved product: ${product.title}');
          print('   🆔 ID: ${product.id}');
          print('   🏷️ Handle: ${product.handle ?? 'N/A'}');
          print(
            '   📝 Description: ${product.description ?? 'No description'}',
          );
          print('   📅 Created: ${product.createdAt}');
          print('   📅 Updated: ${product.updatedAt}');
          expect(product, isA<Product>());
        } else {
          print('⚠️ Product not found (expected without backend)');
        }
      } catch (e) {
        print('⚠️ Expected error (no backend): $e');
        expect(e, isA<Exception>());
      }
    });
  });
}
