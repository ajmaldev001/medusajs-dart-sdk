import 'package:test/test.dart';
import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

void main() {
  group('Medusa SDK v2.10.1 Features', () {
    test('QueryBuilder supports withDeleted() method', () {
      final query =
          QueryBuilder()
              .expand(['variants', 'images'])
              .paginate(limit: 20, offset: 0)
              .orderBy('created_at', ascending: false)
              .withDeleted() // v2.10.1 feature
              .build();

      expect(query['expand'], equals('variants,images'));
      expect(query['limit'], equals(20));
      expect(query['offset'], equals(0));
      expect(query['order'], equals('-created_at'));
      expect(query['with_deleted'], equals(true));
    });

    test('Models support flexible Map<String, dynamic> for metadata', () {
      final productData = {
        'id': 'prod_123',
        'title': 'Test Product',
        'description': 'A test product',
        'handle': 'test-product',
        'is_giftcard': false,
        'status': 'published',
        'discountable': true,
        'metadata': {
          'custom_field_1': 'value1',
          'custom_field_2': 'value2',
          'nested_data': {
            'sub_field': 'sub_value',
            'numbers': [1, 2, 3],
          },
        },
        'created_at': '2024-01-01T00:00:00Z',
        'updated_at': '2024-01-01T00:00:00Z',
      };

      final product = Product.fromJson(productData);

      expect(product.id, equals('prod_123'));
      expect(product.title, equals('Test Product'));
      expect(product.metadata, isA<Map<String, dynamic>>());
      expect(product.metadata?['custom_field_1'], equals('value1'));
      expect(product.metadata?['nested_data'], isA<Map<String, dynamic>>());
      expect(
        (product.metadata?['nested_data'] as Map)['sub_field'],
        equals('sub_value'),
      );
      expect(
        (product.metadata?['nested_data'] as Map)['numbers'],
        equals([1, 2, 3]),
      );
    });

    test('ShippingOptionType model supports v2.10 shipping categorization', () {
      final shippingTypeData = {
        'id': 'sot_123',
        'label': 'Express Delivery',
        'description': 'Fast shipping option',
        'code': 'express',
        'created_at': '2024-01-01T00:00:00Z',
        'updated_at': '2024-01-01T00:00:00Z',
      };

      final shippingType = ShippingOptionType.fromJson(shippingTypeData);

      expect(shippingType.id, equals('sot_123'));
      expect(shippingType.label, equals('Express Delivery'));
      expect(shippingType.description, equals('Fast shipping option'));
      expect(shippingType.code, equals('express'));
    });

    test('TaxRegion model supports flexible metadata', () {
      final taxRegionData = {
        'id': 'txr_123',
        'country_code': 'US',
        'province_code': 'CA',
        'metadata': {
          'tax_authority': 'California State Board of Equalization',
          'special_rules': {'luxury_goods': 0.025, 'essentials': 0.0},
        },
        'created_at': '2024-01-01T00:00:00Z',
        'updated_at': '2024-01-01T00:00:00Z',
      };

      final taxRegion = TaxRegion.fromJson(taxRegionData);

      expect(taxRegion.id, equals('txr_123'));
      expect(taxRegion.countryCode, equals('US'));
      expect(taxRegion.provinceCode, equals('CA'));
      expect(taxRegion.metadata, isA<Map<String, dynamic>>());
      expect(
        taxRegion.metadata?['tax_authority'],
        equals('California State Board of Equalization'),
      );
      expect(taxRegion.metadata?['special_rules'], isA<Map<String, dynamic>>());
    });

    test('SDK configuration supports v2.10.1', () {
      final config = MedusaConfig(
        baseUrl: 'https://medusa-server.com',
        publishableKey: 'pk_test_123',
        apiKey: 'api_test_123',
        debug: true,
        timeout: Duration(seconds: 30),
      );

      expect(config.baseUrl, equals('https://medusa-server.com'));
      expect(config.publishableKey, equals('pk_test_123'));
      expect(config.apiKey, equals('api_test_123'));
      expect(config.debug, isTrue);
      expect(config.timeout, equals(Duration(seconds: 30)));
    });
  });
}
