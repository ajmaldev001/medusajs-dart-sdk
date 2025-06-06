import 'client/client.dart';
import 'auth/auth.dart';
import 'store/store.dart';
import 'admin/admin.dart';
import 'types/types.dart';
import 'webhooks/webhooks.dart';
import 'cache/cache.dart';
import 'realtime/realtime.dart';

/// Main Medusa SDK client
///
/// This is the primary entry point for interacting with a Medusa application.
/// It provides access to store-front, admin, and authentication operations.
///
/// Example usage:
/// ```dart
/// final medusa = Medusa(MedusaConfig(
///   baseUrl: 'https://your-medusa-backend.com',
///   publishableKey: 'pk_test_...',
/// ));
///
/// // Store operations
/// final products = await medusa.store.product.list();
///
/// // Authentication
/// await medusa.auth.login('customer', 'emailpass', {
///   'email': 'test@example.com',
///   'password': 'password',
/// });
///
/// // Admin operations (requires authentication)
/// final orders = await medusa.admin.order.list();
/// ```
class Medusa {
  final MedusaConfig config;
  final MedusaCache? cache;
  late final MedusaClient _client;
  late final MedusaAuth _auth;
  late final MedusaStore _store;
  late final MedusaAdmin _admin;
  late final MedusaWebhooks _webhooks;
  late final RealtimeManager _realtime;

  /// Create a new Medusa SDK instance
  Medusa(this.config, {this.cache}) {
    _client = MedusaClient(config, cache: cache);
    _auth = MedusaAuth(_client, config);
    _store = MedusaStore(_client);
    _admin = MedusaAdmin(_client);
    _webhooks = MedusaWebhooks(logger: config.logger);
    _realtime = RealtimeManager(_client);
  }

  /// Direct access to the underlying HTTP client
  ///
  /// For advanced use cases where you need to make custom requests
  /// that aren't covered by the SDK's built-in methods.
  MedusaClient get client => _client;

  /// Access to authentication operations
  ///
  /// Handles user/customer authentication, registration, and session management.
  /// Supports multiple authentication methods including email/password, OAuth, etc.
  MedusaAuth get auth => _auth;

  /// Access to store-front operations
  ///
  /// Provides customer-facing functionality like browsing products, managing carts,
  /// placing orders, etc. These operations typically don't require authentication
  /// or use customer-level authentication.
  MedusaStore get store => _store;

  /// Access to admin operations
  ///
  /// Provides administrative functionality like managing products, orders, customers,
  /// etc. These operations require admin-level authentication.
  MedusaAdmin get admin => _admin;

  /// Access to webhook handling
  ///
  /// Provides webhook event handling for real-time updates from the Medusa backend.
  /// Useful for building reactive applications that respond to data changes.
  MedusaWebhooks get webhooks => _webhooks;

  /// Access to real-time features
  ///
  /// Provides Server-Sent Events (SSE) support and real-time data subscriptions
  /// for live updates of products, orders, customers, and other resources.
  RealtimeManager get realtime => _realtime;

  /// Set the authentication token for admin operations
  Future<void> setToken(String token) async {
    await _client.setToken(token);
  }

  /// Clear the authentication token
  Future<void> clearToken() async {
    await _client.clearToken();
  }

  /// Clear the cache
  Future<void> clearCache() async {
    if (cache != null) {
      await cache!.clear();
    }
  }

  /// Get cache statistics
  Map<String, dynamic>? getCacheStats() {
    if (cache != null) {
      return cache!.getStats();
    }
    return null;
  }

  /// Update the configuration
  void updateConfig(MedusaConfig newConfig) {
    // Create a new client with the updated config
    final oldClient = _client;
    final oldRealtime = _realtime;

    _client = MedusaClient(newConfig, cache: cache);
    _auth = MedusaAuth(_client, newConfig);
    _store = MedusaStore(_client);
    _admin = MedusaAdmin(_client);
    _realtime = RealtimeManager(_client);

    // Dispose the old instances
    oldRealtime.dispose();
    oldClient.dispose();
  }

  /// Close the HTTP client and clean up resources
  void dispose() {
    _realtime.dispose();
    _client.dispose();
  }
}
