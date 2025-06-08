import 'package:test/test.dart';
import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

void main() {
  group('MedusaStore', () {
    late MedusaStore store;
    late MedusaClient client;

    setUp(() {
      final config = MedusaConfig(
        baseUrl: 'https://test-medusa-backend.com',
        publishableKey: 'pk_test_123',
      );
      client = MedusaClient(config);
      store = MedusaStore(client);
    });

    tearDown(() {
      client.dispose();
    });

    test('should create store instance', () {
      expect(store, isNotNull);
      expect(store, isA<MedusaStore>());
    });

    group('Store Resources', () {
      test('should have product resource', () {
        expect(store.product, isNotNull);
        expect(store.product, isA<StoreProductResource>());
      });

      test('should have cart resource', () {
        expect(store.cart, isNotNull);
        expect(store.cart, isA<StoreCartResource>());
      });

      test('should have region resource', () {
        expect(store.region, isNotNull);
        expect(store.region, isA<StoreRegionResource>());
      });

      test('should have collection resource', () {
        expect(store.collection, isNotNull);
        expect(store.collection, isA<StoreCollectionResource>());
      });

      test('should have category resource', () {
        expect(store.category, isNotNull);
        expect(store.category, isA<StoreCategoryResource>());
      });

      test('should have customer resource', () {
        expect(store.customer, isNotNull);
        expect(store.customer, isA<StoreCustomerResource>());
      });

      test('should have order resource', () {
        expect(store.order, isNotNull);
        expect(store.order, isA<StoreOrderResource>());
      });

      test('should have payment resource', () {
        expect(store.payment, isNotNull);
        expect(store.payment, isA<StorePaymentResource>());
      });

      test('should have fulfillment resource', () {
        expect(store.fulfillment, isNotNull);
        expect(store.fulfillment, isA<StoreFulfillmentResource>());
      });
    });

    group('Store Product Resource', () {
      test('should have correct resource path', () {
        expect(store.product.resourcePath, equals('/store/products'));
      });

      test('should extend StoreResource', () {
        expect(store.product, isA<StoreResource>());
      });
    });

    group('Store Cart Resource', () {
      test('should have correct resource path', () {
        expect(store.cart.resourcePath, equals('/store/carts'));
      });

      test('should extend StoreResource', () {
        expect(store.cart, isA<StoreResource>());
      });
    });

    group('Store Region Resource', () {
      test('should have correct resource path', () {
        expect(store.region.resourcePath, equals('/store/regions'));
      });

      test('should extend StoreResource', () {
        expect(store.region, isA<StoreResource>());
      });
    });

    group('Store Collection Resource', () {
      test('should have correct resource path', () {
        expect(store.collection.resourcePath, equals('/store/collections'));
      });

      test('should extend StoreResource', () {
        expect(store.collection, isA<StoreResource>());
      });
    });

    group('Store Category Resource', () {
      test('should have correct resource path', () {
        expect(store.category.resourcePath, equals('/store/product-categories'));
      });

      test('should extend StoreResource', () {
        expect(store.category, isA<StoreResource>());
      });
    });

    group('Store Customer Resource', () {
      test('should have correct resource path', () {
        expect(store.customer.resourcePath, equals('/store/customers'));
      });

      test('should extend StoreResource', () {
        expect(store.customer, isA<StoreResource>());
      });
    });

    group('Store Order Resource', () {
      test('should have correct resource path', () {
        expect(store.order.resourcePath, equals('/store/orders'));
      });

      test('should extend StoreResource', () {
        expect(store.order, isA<StoreResource>());
      });
    });

    group('Store Payment Resource', () {
      test('should have correct resource path', () {
        expect(store.payment.resourcePath, equals('/store/payment-providers'));
      });

      test('should extend StoreResource', () {
        expect(store.payment, isA<StoreResource>());
      });
    });

    group('Store Fulfillment Resource', () {
      test('should have correct resource path', () {
        expect(store.fulfillment.resourcePath, equals('/store/shipping-options'));
      });

      test('should extend StoreResource', () {
        expect(store.fulfillment, isA<StoreResource>());
      });
    });
  });
}