import 'client/client.dart';
import 'auth/auth.dart';
import 'store/store.dart';
import 'admin/admin.dart';
import 'types/types.dart';
import 'webhooks/webhooks.dart';
import 'cache/cache.dart';
import 'realtime/realtime.dart';

/// Refactored Medusa SDK client - Version 2
///
/// This is an improved version of the main Medusa SDK client with:
/// - Better organized resource structure
/// - Cleaner separation of concerns
/// - Enhanced type safety
/// - More consistent API patterns
/// - Improved developer experience
///
/// Example usage:
/// ```dart
/// final medusa = MedusaV2(MedusaConfig(
///   baseUrl: 'https://your-medusa-backend.com',
///   publishableKey: 'pk_test_...',
/// ));
///
/// // Store operations - cleaner API
/// final products = await medusa.store.product.list();
/// final searchResults = await medusa.store.product.search('shirt');
/// final cart = await medusa.store.cart.create({'region_id': 'reg_123'});
///
/// // Admin operations - organized resources
/// final adminProducts = await medusa.admin.product.list();
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

  /// Create a new Medusa SDK instance with improved architecture
  Medusa(this.config, {this.cache}) {
    _client = MedusaClient(config, cache: cache);
    _auth = MedusaAuth(_client, config);
    _store = MedusaStore(_client);
    _admin = MedusaAdmin(_client);
    _webhooks = MedusaWebhooks(logger: config.logger);
    _realtime = RealtimeManager(_client);
  }

  /// Access to store operations with improved resource organization
  MedusaStore get store => _store;

  /// Access to admin operations with better structure
  MedusaAdmin get admin => _admin;

  /// Authentication operations
  MedusaAuth get auth => _auth;

  /// Webhook utilities
  MedusaWebhooks get webhooks => _webhooks;

  /// Real-time connection manager
  RealtimeManager get realtime => _realtime;

  /// Low-level HTTP client for custom requests
  MedusaClient get client => _client;

  /// Configuration for this SDK instance
  MedusaConfig get configuration => config;

  /// Dispose resources when done
  void dispose() {
    _client.dispose();
    _realtime.dispose();
  }
}
