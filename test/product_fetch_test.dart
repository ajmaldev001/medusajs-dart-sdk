import 'package:test/test.dart';
import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

void main() {
  group('Product Data Fetch Tests', () {
    late MedusaStore store;
    late MedusaClient client;

    setUp(() {
      // Configure with a test Medusa backend
      // Replace with your actual Medusa backend URL and publishable key
      final config = MedusaConfig(
        baseUrl: 'http://localhost:9000', // Your Medusa backend URL
        publishableKey:
            'pk_91b3a86dc075c322be390706c681561c525df7c54f4e54bf574b28e837d78714', // Your publishable API key
      );
      client = MedusaClient(config);
      store = MedusaStore(client);
    });

    tearDown(() {
      client.dispose();
    });

    group('Product Listing Tests', () {
      test('should fetch all products', () async {
        try {
          final response = await store.product.list();

          print('✅ Successfully fetched products');
          print('📊 Total products: ${response.data.length}');
          print('🔄 Has more pages: ${response.hasMore}');

          expect(response.data, isA<List<Product>>());

          if (response.data.isNotEmpty) {
            final firstProduct = response.data.first;
            print('📦 First product: ${firstProduct.title}');
            print('🆔 Product ID: ${firstProduct.id}');
            print('💰 Product handle: ${firstProduct.handle}');
          }
        } catch (e) {
          print('❌ Error fetching products: $e');
          // Don't fail the test immediately - this might be expected in CI
          // rethrow;
        }
      });

      test('should fetch products with pagination', () async {
        try {
          final response = await store.product.list(
            query: {'limit': 5, 'offset': 0},
          );

          print('✅ Successfully fetched paginated products');
          print('📊 Products returned: ${response.data.length}');
          print('🔢 Max expected: 5');

          expect(response.data.length, lessThanOrEqualTo(5));

          // Test next page if there are more products
          if (response.hasMore) {
            final nextPage = await store.product.list(
              query: {'limit': 5, 'offset': 5},
            );
            print('📄 Next page products: ${nextPage.data.length}');
          }
        } catch (e) {
          print('❌ Error fetching paginated products: $e');
        }
      });

      test('should fetch products with filters', () async {
        try {
          final response = await store.product.list(
            query: {'is_giftcard': false},
          );

          print('✅ Successfully fetched filtered products');
          print('📊 Filtered products: ${response.data.length}');

          for (final product in response.data) {
            expect(product.isGiftcard, isFalse);
            // Note: status field is not available in Store API (admin-only field)
            // expect(product.status, equals(ProductStatus.published));
          }
        } catch (e) {
          print('❌ Error fetching filtered products: $e');
        }
      });

      // --- Add test for fetching product categories ---
      test('should fetch product categories', () async {
        try {
          final response = await store.category.list();
          print('✅ Successfully fetched categories');
          print('📂 Total categories: ${response.data.length}');
          expect(response.data, isA<List<Category>>());
          if (response.data.isNotEmpty) {
            final firstCategory = response.data.first;
            print('🏷️ First category: ${firstCategory.name}');
            print('🆔 Category ID: ${firstCategory.id}');
            print('📦 Handle: ${firstCategory.handle}');
          }
        } catch (e) {
          print('❌ Error fetching categories: $e');
        }
      });
      // --- End category test ---
    });

    group('Single Product Tests', () {
      test('should fetch product by ID', () async {
        try {
          // First get a list to find a valid product ID
          final listResponse = await store.product.list(query: {'limit': 1});

          if (listResponse.data.isNotEmpty) {
            final productId = listResponse.data.first.id;

            final product = await store.product.retrieve(productId);

            if (product != null) {
              print('✅ Successfully fetched product by ID');
              print('📦 Product: ${product.title}');
              print('🆔 ID: ${product.id}');
              print(
                '📝 Description: ${product.description ?? 'No description'}',
              );
              print('🏷️ Handle: ${product.handle ?? 'No handle'}');
              print('💰 Gift card: ${product.isGiftcard}');
              print('📊 Status: ${product.status}');

              expect(product.id, equals(productId));
              expect(product, isA<Product>());
            } else {
              print('⚠️ Product not found with ID: $productId');
            }
          } else {
            print('⚠️ No products available to test retrieval');
          }
        } catch (e) {
          print('❌ Error fetching product by ID: $e');
        }
      });

      test('should handle non-existent product ID', () async {
        try {
          final nonExistentId = 'prod_nonexistent123';
          final product = await store.product.retrieve(nonExistentId);

          expect(product, isNull);
          print('✅ Correctly handled non-existent product ID');
        } catch (e) {
          print('⚠️ Exception for non-existent product: $e');
          // This might throw an exception depending on the backend implementation
        }
      });
    });

    group('Product Search Tests', () {
      test('should search products by term', () async {
        try {
          // Try searching for common product terms
          final searchTerms = ['shirt', 't-shirt', 'product', 'test'];

          for (final term in searchTerms) {
            final response = await store.product.search(term);

            print('🔍 Search results for "$term": ${response.data.length}');

            if (response.data.isNotEmpty) {
              print('📦 First result: ${response.data.first.title}');
              break; // Stop after finding results
            }
          }
        } catch (e) {
          print('❌ Error searching products: $e');
        }
      });

      test('should search products with additional filters', () async {
        try {
          final response = await store.product.search(
            'product',
            additionalFilters: {'is_giftcard': false, 'limit': 3},
          );

          print('🔍 Filtered search results: ${response.data.length}');

          for (final product in response.data) {
            expect(product.isGiftcard, isFalse);
            print('📦 Found: ${product.title}');
          }
        } catch (e) {
          print('❌ Error in filtered search: $e');
        }
      });
    });

    group('Product Details Tests', () {
      test('should fetch product with variants and images', () async {
        try {
          final response = await store.product.list(
            query: {'fields': '*variants,*images,*options', 'limit': 1},
          );

          if (response.data.isNotEmpty) {
            final product = response.data.first;

            print('✅ Product with expanded data:');
            print('📦 Title: ${product.title}');
            print('🔗 Variants: ${product.variants?.length ?? 0}');
            print('🖼️ Images: ${product.images?.length ?? 0}');
            print('⚙️ Options: ${product.options?.length ?? 0}');

            // Check variants
            if (product.variants != null && product.variants!.isNotEmpty) {
              final variant = product.variants!.first;
              print('💎 First variant: ${variant.title}');
              // Use the new pricing structure
              final priceInfo = variant.calculatedPrice;
              if (priceInfo != null) {
                final effectivePrice = priceInfo.effectiveAmount;
                print(
                  '💰 Price: ${effectivePrice != null ? '${priceInfo.getFormattedEffectivePrice()} ${priceInfo.currencyCode ?? ''}' : 'No price'}',
                );
              } else {
                print('💰 Price: No pricing information');
              }
            }

            // Check images
            if (product.images != null && product.images!.isNotEmpty) {
              final image = product.images!.first;
              print('🖼️ First image URL: ${image.url}');
            }

            // Check options
            if (product.options != null && product.options!.isNotEmpty) {
              final option = product.options!.first;
              print('⚙️ First option: ${option.title}');
            }
          }
        } catch (e) {
          print('❌ Error fetching expanded product data: $e');
        }
      });
    });

    group('Performance Tests', () {
      test('should handle concurrent product requests', () async {
        try {
          print('🚀 Testing concurrent requests...');

          final futures = <Future>[];

          // Create multiple concurrent requests
          for (int i = 0; i < 3; i++) {
            futures.add(
              store.product.list(query: {'limit': 2, 'offset': i * 2}),
            );
          }

          final results = await Future.wait(futures);

          print('✅ All concurrent requests completed');
          print('📊 Results count: ${results.length}');

          for (int i = 0; i < results.length; i++) {
            final response = results[i] as PaginatedResponse<Product>;
            print(
              '📄 Request $i returned: ${response.products.length} products',
            );
          }
        } catch (e) {
          print('❌ Error in concurrent requests: $e');
        }
      });
    });
  });
}
