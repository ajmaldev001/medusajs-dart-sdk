import 'package:test/test.dart';
import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

void main() {
  group('Exception Tests', () {
    test('MedusaError should have correct properties', () {
      const error = MedusaError('Test error message');
      expect(error.message, equals('Test error message'));
      expect(error.toString(), equals('MedusaError: Test error message'));
    });

    test('AuthenticationError should extend MedusaError', () {
      const error = AuthenticationError('Authentication failed');
      expect(error, isA<MedusaError>());
      expect(error.message, equals('Authentication failed'));
      expect(
        error.toString(),
        equals('AuthenticationError: Authentication failed'),
      );
    });

    test('HttpError should have status code and response', () {
      const error = HttpError(
        'HTTP request failed',
        statusCode: 404,
        response: {'error': 'Not found'},
      );

      expect(error, isA<MedusaError>());
      expect(error.message, equals('HTTP request failed'));
      expect(error.statusCode, equals(404));
      expect(error.response, equals({'error': 'Not found'}));
      expect(error.toString(), contains('HttpError'));
      expect(error.toString(), contains('404'));
    });

    test('ValidationError should extend MedusaError', () {
      const error = ValidationError('Validation failed');
      expect(error, isA<MedusaError>());
      expect(error.message, equals('Validation failed'));
      expect(error.toString(), equals('ValidationError: Validation failed'));
    });

    test('NetworkError should extend MedusaError', () {
      const error = NetworkError('Network connection failed');
      expect(error, isA<MedusaError>());
      expect(error.message, equals('Network connection failed'));
      expect(
        error.toString(),
        equals('NetworkError: Network connection failed'),
      );
    });
  });

  group('Configuration Tests', () {
    test('MedusaConfig should have correct default values', () {
      final config = MedusaConfig(baseUrl: 'https://api.example.com');

      expect(config.baseUrl, equals('https://api.example.com'));
      expect(config.publishableKey, isNull);
      expect(config.apiKey, isNull);
      expect(config.debug, equals(false));
      expect(config.maxRetries, equals(3));
      expect(config.timeout, equals(const Duration(seconds: 30)));
    });

    test('MedusaConfig should accept all parameters', () {
      final config = MedusaConfig(
        baseUrl: 'https://api.example.com',
        publishableKey: 'pk_test_123',
        apiKey: 'sk_test_456',
        debug: true,
        maxRetries: 5,
        timeout: const Duration(seconds: 60),
      );

      expect(config.baseUrl, equals('https://api.example.com'));
      expect(config.publishableKey, equals('pk_test_123'));
      expect(config.apiKey, equals('sk_test_456'));
      expect(config.debug, equals(true));
      expect(config.maxRetries, equals(5));
      expect(config.timeout, equals(const Duration(seconds: 60)));
    });

    test('AuthConfig should have correct default values', () {
      const authConfig = AuthConfig();

      expect(authConfig.type, equals(AuthType.jwt));
    });

    test('AuthConfig should accept session type', () {
      const authConfig = AuthConfig(type: AuthType.session);

      expect(authConfig.type, equals(AuthType.session));
    });
  });

  group('Type Definitions Tests', () {
    test('AuthType enum should have correct values', () {
      expect(AuthType.jwt.toString(), equals('AuthType.jwt'));
      expect(AuthType.session.toString(), equals('AuthType.session'));
    });

    test('FindParams should handle query parameters correctly', () {
      final params = FindParams(
        limit: 10,
        offset: 20,
        fields: ['id', 'name', 'email'],
        expand: ['customer', 'items'],
        order: 'created_at',
      );

      final map = params.toMap();
      expect(map['limit'], equals(10));
      expect(map['offset'], equals(20));
      expect(map['fields'], equals('id,name,email'));
      expect(map['expand'], equals('customer,items'));
      expect(map['order'], equals('created_at'));
    });

    test('SelectParams should handle selection parameters correctly', () {
      final params = SelectParams(
        fields: ['id', 'title', 'status'],
        expand: ['variants', 'images'],
      );

      final map = params.toMap();
      expect(map['fields'], equals('id,title,status'));
      expect(map['expand'], equals('variants,images'));
    });

    test('ClientHeaders should handle headers correctly', () {
      final headers = ClientHeaders({
        'Authorization': 'Bearer token123',
        'Content-Type': 'application/json',
        'X-Custom-Header': 'custom-value',
      });

      expect(headers['Authorization'], equals('Bearer token123'));
      expect(headers['Content-Type'], equals('application/json'));
      expect(headers['X-Custom-Header'], equals('custom-value'));
    });
  });

  group('Integration Tests', () {
    test('Medusa client should be properly initialized', () {
      final medusa = Medusa(
        MedusaConfig(
          baseUrl: 'https://api.medusa-commerce.com',
          publishableKey: 'pk_test_123',
        ),
      );

      expect(medusa, isA<Medusa>());
      expect(medusa.config.baseUrl, equals('https://api.medusa-commerce.com'));
      expect(medusa.config.publishableKey, equals('pk_test_123'));
      expect(medusa.store, isA<MedusaStore>());
      expect(medusa.admin, isA<MedusaAdmin>());
      expect(medusa.auth, isA<MedusaAuth>());
    });

    test('Medusa client should handle admin configuration', () {
      final medusa = Medusa(
        MedusaConfig(
          baseUrl: 'https://api.medusa-commerce.com',
          apiKey: 'sk_test_456',
        ),
      );

      expect(medusa.config.apiKey, equals('sk_test_456'));
      expect(medusa.admin, isA<MedusaAdmin>());
    });

    test('Medusa client should handle both keys', () {
      final medusa = Medusa(
        MedusaConfig(
          baseUrl: 'https://api.medusa-commerce.com',
          publishableKey: 'pk_test_123',
          apiKey: 'sk_test_456',
        ),
      );

      expect(medusa.config.publishableKey, equals('pk_test_123'));
      expect(medusa.config.apiKey, equals('sk_test_456'));
    });
  });
}
