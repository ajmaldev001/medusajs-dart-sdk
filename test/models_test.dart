import 'package:test/test.dart';
import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

void main() {
  group('Models', () {
    group('Product', () {
      test('should create Product instance', () {
        final product = Product(
          id: 'prod_123',
          title: 'Test Product',
          description: 'A test product',
          handle: 'test-product',
          isGiftcard: false,
          status: ProductStatus.published,
          createdAt: DateTime.parse('2023-01-01T00:00:00Z'),
          updatedAt: DateTime.parse('2023-01-01T00:00:00Z'),
        );

        expect(product.id, equals('prod_123'));
        expect(product.title, equals('Test Product'));
        expect(product.description, equals('A test product'));
        expect(product.handle, equals('test-product'));
        expect(product.isGiftcard, equals(false));
        expect(product.status, equals(ProductStatus.published));
        expect(product.createdAt, isNotNull);
        expect(product.updatedAt, isNotNull);
      });

      test('should have convenience getters', () {
        final publishedProduct = Product(
          id: 'prod_published',
          title: 'Published Product',
          status: ProductStatus.published,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final draftProduct = Product(
          id: 'prod_draft',
          title: 'Draft Product',
          status: ProductStatus.draft,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        expect(publishedProduct.isPublished, equals(true));
        expect(publishedProduct.isDraft, equals(false));
        expect(draftProduct.isPublished, equals(false));
        expect(draftProduct.isDraft, equals(true));
      });
    });

    group('Cart', () {
      test('should create Cart instance', () {
        final cart = Cart(
          id: 'cart_123',
          regionId: 'reg_123',
          email: 'test@example.com',
          currencyCode: 'usd',
          total: 1000,
          subtotal: 900,
          taxTotal: 100,
          shippingTotal: 0,
          discountTotal: 0,
          giftCardTotal: 0,
          giftCardTaxTotal: 0,
          itemCount: 2,
          createdAt: DateTime.parse('2023-01-01T00:00:00Z'),
          updatedAt: DateTime.parse('2023-01-01T00:00:00Z'),
        );

        expect(cart.id, equals('cart_123'));
        expect(cart.regionId, equals('reg_123'));
        expect(cart.email, equals('test@example.com'));
        expect(cart.currencyCode, equals('usd'));
        expect(cart.total, equals(1000));
        expect(cart.subtotal, equals(900));
        expect(cart.itemCount, equals(2));
        expect(cart.createdAt, isNotNull);
        expect(cart.updatedAt, isNotNull);
      });

      test('should have convenience getters', () {
        final emptyCart = Cart(
          id: 'cart_empty',
          regionId: 'reg_123',
          currencyCode: 'usd',
          total: 0,
          subtotal: 0,
          taxTotal: 0,
          shippingTotal: 0,
          discountTotal: 0,
          giftCardTotal: 0,
          giftCardTaxTotal: 0,
          itemCount: 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final filledCart = Cart(
          id: 'cart_filled',
          regionId: 'reg_123',
          currencyCode: 'usd',
          total: 1000,
          subtotal: 900,
          taxTotal: 100,
          shippingTotal: 0,
          discountTotal: 0,
          giftCardTotal: 0,
          giftCardTaxTotal: 0,
          itemCount: 3,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        expect(emptyCart.isEmpty, equals(true));
        expect(emptyCart.hasItems, equals(false));
        expect(filledCart.isEmpty, equals(false));
        expect(filledCart.hasItems, equals(true));
      });
    });

    group('Customer', () {
      test('should create Customer instance', () {
        final customer = Customer(
          id: 'cust_123',
          email: 'customer@example.com',
          firstName: 'John',
          lastName: 'Doe',
          phone: '+1234567890',
          hasAccount: true,
          createdAt: DateTime.parse('2023-01-01T00:00:00Z'),
          updatedAt: DateTime.parse('2023-01-01T00:00:00Z'),
        );

        expect(customer.id, equals('cust_123'));
        expect(customer.email, equals('customer@example.com'));
        expect(customer.firstName, equals('John'));
        expect(customer.lastName, equals('Doe'));
        expect(customer.phone, equals('+1234567890'));
        expect(customer.hasAccount, equals(true));
        expect(customer.createdAt, isNotNull);
        expect(customer.updatedAt, isNotNull);
      });
    });

    group('Order', () {
      test('should create Order instance', () {
        final order = Order(
          id: 'order_123',
          displayId: 1001,
          status: OrderStatus.pending,
          fulfillmentStatus: FulfillmentStatus.notFulfilled,
          paymentStatus: PaymentStatus.awaiting,
          regionId: 'reg_123',
          currencyCode: 'usd',
          total: 1000,
          subtotal: 900,
          taxTotal: 100,
          shippingTotal: 0,
          discountTotal: 0,
          giftCardTotal: 0,
          giftCardTaxTotal: 0,
          email: 'customer@example.com',
          createdAt: DateTime.parse('2023-01-01T00:00:00Z'),
          updatedAt: DateTime.parse('2023-01-01T00:00:00Z'),
        );

        expect(order.id, equals('order_123'));
        expect(order.displayId, equals(1001));
        expect(order.status, equals(OrderStatus.pending));
        expect(order.fulfillmentStatus, equals(FulfillmentStatus.notFulfilled));
        expect(order.currencyCode, equals('usd'));
        expect(order.total, equals(1000));
        expect(order.subtotal, equals(900));
        expect(order.email, equals('customer@example.com'));
        expect(order.createdAt, isNotNull);
        expect(order.updatedAt, isNotNull);
      });

      test('should have convenience getters', () {
        final pendingOrder = Order(
          id: 'order_pending',
          displayId: 1001,
          status: OrderStatus.pending,
          fulfillmentStatus: FulfillmentStatus.notFulfilled,
          paymentStatus: PaymentStatus.awaiting,
          regionId: 'reg_123',
          currencyCode: 'usd',
          total: 1000,
          subtotal: 900,
          taxTotal: 100,
          shippingTotal: 0,
          discountTotal: 0,
          giftCardTotal: 0,
          giftCardTaxTotal: 0,
          email: 'customer@example.com',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final completedOrder = Order(
          id: 'order_completed',
          displayId: 1002,
          status: OrderStatus.completed,
          fulfillmentStatus: FulfillmentStatus.fulfilled,
          paymentStatus: PaymentStatus.captured,
          regionId: 'reg_123',
          currencyCode: 'usd',
          total: 1000,
          subtotal: 900,
          taxTotal: 100,
          shippingTotal: 0,
          discountTotal: 0,
          giftCardTotal: 0,
          giftCardTaxTotal: 0,
          email: 'customer@example.com',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        expect(pendingOrder.canEdit, equals(true));
        expect(pendingOrder.isCompleted, equals(false));
        expect(completedOrder.canEdit, equals(false));
        expect(completedOrder.isCompleted, equals(true));
        expect(completedOrder.isFullyFulfilled, equals(true));
        expect(completedOrder.isFullyPaid, equals(true));
      });
    });

    group('Region', () {
      test('should create Region instance', () {
        final region = Region(
          id: 'reg_123',
          name: 'US',
          currencyCode: 'usd',
          taxRate: 8.5,
          createdAt: DateTime.parse('2023-01-01T00:00:00Z'),
          updatedAt: DateTime.parse('2023-01-01T00:00:00Z'),
        );

        expect(region.id, equals('reg_123'));
        expect(region.name, equals('US'));
        expect(region.currencyCode, equals('usd'));
        expect(region.taxRate, equals(8.5));
        expect(region.createdAt, isNotNull);
        expect(region.updatedAt, isNotNull);
      });
    });

    group('Collection', () {
      test('should create Collection instance', () {
        final collection = Collection(
          id: 'pcol_123',
          title: 'Summer Collection',
          handle: 'summer-collection',
          createdAt: DateTime.parse('2023-01-01T00:00:00Z'),
          updatedAt: DateTime.parse('2023-01-01T00:00:00Z'),
        );

        expect(collection.id, equals('pcol_123'));
        expect(collection.title, equals('Summer Collection'));
        expect(collection.handle, equals('summer-collection'));
        expect(collection.createdAt, isNotNull);
        expect(collection.updatedAt, isNotNull);
      });
    });

    group('Category', () {
      test('should create Category instance', () {
        final category = Category(
          id: 'pcat_123',
          name: 'Electronics',
          handle: 'electronics',
          rank: 0,
          isActive: true,
          isInternal: false,
          createdAt: DateTime.parse('2023-01-01T00:00:00Z'),
          updatedAt: DateTime.parse('2023-01-01T00:00:00Z'),
        );

        expect(category.id, equals('pcat_123'));
        expect(category.name, equals('Electronics'));
        expect(category.handle, equals('electronics'));
        expect(category.rank, equals(0));
        expect(category.isActive, equals(true));
        expect(category.isInternal, equals(false));
        expect(category.createdAt, isNotNull);
        expect(category.updatedAt, isNotNull);
      });
    });
  });

  group('PaginatedResponse', () {
    test('should create PaginatedResponse with data', () {
      final products = [
        Product(
          id: 'prod_1',
          title: 'Product 1',
          handle: 'product-1',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        Product(
          id: 'prod_2',
          title: 'Product 2',
          handle: 'product-2',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      final response = PaginatedResponse<Product>(
        data: products,
        count: 2,
        offset: 0,
        limit: 20,
      );

      expect(response.data, hasLength(2));
      expect(response.count, equals(2));
      expect(response.offset, equals(0));
      expect(response.limit, equals(20));
    });

    test('should correctly calculate pagination information', () {
      final products = List.generate(20, (index) => Product(
        id: 'prod_$index',
        title: 'Product $index',
        handle: 'product-$index',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));

      // First page
      final firstPage = PaginatedResponse<Product>(
        data: products,
        count: 100,
        offset: 0,
        limit: 20,
      );

      expect(firstPage.data, hasLength(20));
      expect(firstPage.count, equals(100));
      expect(firstPage.offset, equals(0));
      expect(firstPage.limit, equals(20));

      // Middle page
      final middlePage = PaginatedResponse<Product>(
        data: products,
        count: 100,
        offset: 20,
        limit: 20,
      );

      expect(middlePage.data, hasLength(20));
      expect(middlePage.count, equals(100));
      expect(middlePage.offset, equals(20));
      expect(middlePage.limit, equals(20));

      // Last page
      final lastPage = PaginatedResponse<Product>(
        data: products,
        count: 100,
        offset: 80,
        limit: 20,
      );

      expect(lastPage.data, hasLength(20));
      expect(lastPage.count, equals(100));
      expect(lastPage.offset, equals(80));
      expect(lastPage.limit, equals(20));
    });

    test('should handle model types correctly', () {
      final customers = [
        Customer(
          id: 'cust_1',
          email: 'customer1@example.com',
          firstName: 'John',
          lastName: 'Doe',
          hasAccount: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        Customer(
          id: 'cust_2',
          email: 'customer2@example.com',
          firstName: 'Jane',
          lastName: 'Smith',
          hasAccount: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      final response = PaginatedResponse<Customer>(
        data: customers,
        count: 2,
        offset: 0,
        limit: 20,
      );

      expect(response.data, hasLength(2));
      expect(response.data.every((item) => item is Customer), equals(true));
      expect(response.data[0].firstName, equals('John'));
      expect(response.data[1].firstName, equals('Jane'));
    });
  });
}