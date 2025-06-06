import 'package:test/test.dart';
import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

void main() {
  group('Model Serialization Tests', () {
    group('Customer Model', () {
      test('should serialize and deserialize correctly', () {
        final customerJson = {
          'id': 'cust_01234567890123456789012345',
          'email': 'test@example.com',
          'first_name': 'John',
          'last_name': 'Doe',
          'has_account': true,
          'phone': '+1234567890',
          'created_at': '2023-01-01T00:00:00.000Z',
          'updated_at': '2023-01-01T00:00:00.000Z',
        };

        final customer = Customer.fromJson(customerJson);
        expect(customer.id, equals('cust_01234567890123456789012345'));
        expect(customer.email, equals('test@example.com'));
        expect(customer.firstName, equals('John'));
        expect(customer.lastName, equals('Doe'));
        expect(customer.hasAccount, equals(true));
        expect(customer.phone, equals('+1234567890'));

        final serialized = customer.toJson();
        expect(serialized['id'], equals('cust_01234567890123456789012345'));
        expect(serialized['email'], equals('test@example.com'));
        expect(serialized['first_name'], equals('John'));
        expect(serialized['last_name'], equals('Doe'));
        expect(serialized['has_account'], equals(true));
      });

      test('should handle optional fields', () {
        final minimalJson = {
          'id': 'cust_123',
          'email': 'test@example.com',
          'has_account': false,
          'created_at': '2023-01-01T00:00:00.000Z',
          'updated_at': '2023-01-01T00:00:00.000Z',
        };

        final customer = Customer.fromJson(minimalJson);
        expect(customer.id, equals('cust_123'));
        expect(customer.email, equals('test@example.com'));
        expect(customer.firstName, isNull);
        expect(customer.lastName, isNull);
        expect(customer.phone, isNull);
        expect(customer.hasAccount, equals(false));
      });
    });

    group('Product Model', () {
      test('should serialize and deserialize correctly', () {
        final productJson = {
          'id': 'prod_01234567890123456789012345',
          'title': 'Test Product',
          'subtitle': 'A test product',
          'description': 'This is a test product description',
          'handle': 'test-product',
          'is_giftcard': false,
          'status': 'published',
          'weight': 500,
          'length': 10,
          'height': 5,
          'width': 8,
          'hs_code': '1234567890',
          'origin_country': 'US',
          'mid_code': 'MID123',
          'material': 'Cotton',
          'created_at': '2023-01-01T00:00:00.000Z',
          'updated_at': '2023-01-01T00:00:00.000Z',
        };

        final product = Product.fromJson(productJson);
        expect(product.id, equals('prod_01234567890123456789012345'));
        expect(product.title, equals('Test Product'));
        expect(product.subtitle, equals('A test product'));
        expect(
          product.description,
          equals('This is a test product description'),
        );
        expect(product.handle, equals('test-product'));
        expect(product.isGiftcard, equals(false));
        expect(product.status, equals(ProductStatus.published));
        expect(product.weight, equals(500));

        final serialized = product.toJson();
        expect(serialized['id'], equals('prod_01234567890123456789012345'));
        expect(serialized['title'], equals('Test Product'));
        expect(serialized['status'], equals('published'));
      });

      test('should handle all product statuses', () {
        final statuses = ['draft', 'proposed', 'published', 'rejected'];
        final expectedEnums = [
          ProductStatus.draft,
          ProductStatus.proposed,
          ProductStatus.published,
          ProductStatus.rejected,
        ];

        for (int i = 0; i < statuses.length; i++) {
          final json = {
            'id': 'prod_$i',
            'title': 'Product $i',
            'handle': 'product-$i',
            'status': statuses[i],
            'is_giftcard': false,
            'created_at': '2023-01-01T00:00:00.000Z',
            'updated_at': '2023-01-01T00:00:00.000Z',
          };

          final product = Product.fromJson(json);
          expect(product.status, equals(expectedEnums[i]));
        }
      });
    });

    group('Cart Model', () {
      test('should serialize and deserialize correctly', () {
        final cartJson = {
          'id': 'cart_01234567890123456789012345',
          'email': 'customer@example.com',
          'billing_address_id': 'addr_billing_123',
          'shipping_address_id': 'addr_shipping_123',
          'region_id': 'reg_123',
          'customer_id': 'cust_123',
          'payment_id': 'pay_123',
          'type': 'default',
          'completed_at': null,
          'payment_authorized_at': null,
          'subtotal': 1000,
          'tax_total': 100,
          'shipping_total': 500,
          'discount_total': 200,
          'gift_card_total': 0,
          'total': 1400,
          'created_at': '2023-01-01T00:00:00.000Z',
          'updated_at': '2023-01-01T00:00:00.000Z',
        };

        final cart = Cart.fromJson(cartJson);
        expect(cart.id, equals('cart_01234567890123456789012345'));
        expect(cart.email, equals('customer@example.com'));
        expect(cart.type, equals(CartType.defaultCart));
        expect(cart.subtotal, equals(1000));
        expect(cart.taxTotal, equals(100));
        expect(cart.shippingTotal, equals(500));
        expect(cart.total, equals(1400));

        final serialized = cart.toJson();
        expect(serialized['id'], equals('cart_01234567890123456789012345'));
        expect(serialized['email'], equals('customer@example.com'));
        expect(serialized['type'], equals('default'));
      });

      test('should handle different cart types', () {
        final types = [
          'default',
          'swap',
          'draft_order',
          'payment_link',
          'claim',
        ];
        final expectedEnums = [
          CartType.defaultCart,
          CartType.swap,
          CartType.draftOrder,
          CartType.paymentLink,
          CartType.claim,
        ];

        for (int i = 0; i < types.length; i++) {
          final json = {
            'id': 'cart_$i',
            'type': types[i],
            'total': 0,
            'subtotal': 0,
            'tax_total': 0,
            'created_at': '2023-01-01T00:00:00.000Z',
            'updated_at': '2023-01-01T00:00:00.000Z',
          };

          final cart = Cart.fromJson(json);
          expect(cart.type, equals(expectedEnums[i]));
        }
      });
    });

    group('Order Model', () {
      test('should serialize and deserialize correctly', () {
        final orderJson = {
          'id': 'order_01234567890123456789012345',
          'display_id': 1001,
          'status': 'pending',
          'fulfillment_status': 'not_fulfilled',
          'payment_status': 'awaiting',
          'currency_code': 'usd',
          'email': 'customer@example.com',
          'region_id': 'reg_123',
          'customer_id': 'cust_123',
          'cart_id': 'cart_123',
          'subtotal': 1000,
          'tax_total': 100,
          'shipping_total': 500,
          'discount_total': 200,
          'gift_card_total': 0,
          'total': 1400,
          'created_at': '2023-01-01T00:00:00.000Z',
          'updated_at': '2023-01-01T00:00:00.000Z',
        };

        final order = Order.fromJson(orderJson);
        expect(order.id, equals('order_01234567890123456789012345'));
        expect(order.displayId, equals(1001));
        expect(order.status, equals(OrderStatus.pending));
        expect(order.fulfillmentStatus, equals(FulfillmentStatus.notFulfilled));
        expect(order.paymentStatus, equals(PaymentStatus.awaiting));
        expect(order.currencyCode, equals('usd'));
        expect(order.total, equals(1400));

        final serialized = order.toJson();
        expect(serialized['id'], equals('order_01234567890123456789012345'));
        expect(serialized['display_id'], equals(1001));
        expect(serialized['status'], equals('pending'));
      });
    });

    group('Address Model', () {
      test('should serialize and deserialize correctly', () {
        final addressJson = {
          'id': 'addr_01234567890123456789012345',
          'customer_id': 'cust_123',
          'first_name': 'John',
          'last_name': 'Doe',
          'phone': '+1234567890',
          'company': 'Acme Corp',
          'address_1': '123 Main St',
          'address_2': 'Apt 4B',
          'city': 'New York',
          'country_code': 'us',
          'province': 'NY',
          'postal_code': '10001',
          'created_at': '2023-01-01T00:00:00.000Z',
          'updated_at': '2023-01-01T00:00:00.000Z',
        };

        final address = Address.fromJson(addressJson);
        expect(address.id, equals('addr_01234567890123456789012345'));
        expect(address.firstName, equals('John'));
        expect(address.lastName, equals('Doe'));
        expect(address.address1, equals('123 Main St'));
        expect(address.city, equals('New York'));
        expect(address.countryCode, equals('us'));
        expect(address.postalCode, equals('10001'));

        final serialized = address.toJson();
        expect(serialized['id'], equals('addr_01234567890123456789012345'));
        expect(serialized['first_name'], equals('John'));
        expect(serialized['address_1'], equals('123 Main St'));
      });
    });

    group('PaginatedResponse Model', () {
      test('should serialize and deserialize correctly', () {
        final responseJson = {
          'data': [
            {'id': '1', 'name': 'Item 1'},
            {'id': '2', 'name': 'Item 2'},
          ],
          'count': 2,
          'offset': 0,
          'limit': 20,
        };

        final response = PaginatedResponse<Map<String, dynamic>>.fromJson(
          responseJson,
          (json) => json as Map<String, dynamic>,
        );

        expect(response.data.length, equals(2));
        expect(response.count, equals(2));
        expect(response.offset, equals(0));
        expect(response.limit, equals(20));
        expect(response.data[0]['id'], equals('1'));
        expect(response.data[1]['name'], equals('Item 2'));

        final serialized = response.toJson((item) => item);
        expect(serialized['data'], isA<List>());
        expect(serialized['count'], equals(2));
        expect(serialized['offset'], equals(0));
        expect(serialized['limit'], equals(20));
      });
    });

    group('DeleteResponse Model', () {
      test('should serialize and deserialize correctly', () {
        final responseJson = {
          'id': 'deleted_123',
          'object': 'product',
          'deleted': true,
        };

        final response = DeleteResponse.fromJson(responseJson);
        expect(response.id, equals('deleted_123'));
        expect(response.object, equals('product'));
        expect(response.deleted, equals(true));

        final serialized = response.toJson();
        expect(serialized['id'], equals('deleted_123'));
        expect(serialized['object'], equals('product'));
        expect(serialized['deleted'], equals(true));
      });
    });
  });
}
