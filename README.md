# Medusa.js Dart SDK

A comprehensive Dart SDK for [Medusa.js](https://medusajs.com), the open-source headless commerce platform. This SDK provides type-safe access to all Medusa APIs including storefront, admin, and authentication operations.

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## Features

- 🚀 **Complete API Coverage** - Full support for Medusa v2.8.3 APIs
- 🔐 **Authentication** - Built-in auth management with automatic token handling
- 🛍️ **Store Operations** - Products, collections, carts, orders, and more
- ⚙️ **Admin Operations** - Full admin API support for backend management
- 📱 **Flutter Ready** - Works seamlessly with Flutter applications
- 🔄 **Real-time Support** - WebSocket connections for live updates
- 💾 **Caching** - Built-in caching with customizable strategies
- 🎯 **Type Safety** - Fully typed models with JSON serialization
- 🪝 **Webhooks** - Easy webhook signature verification
- 📊 **Batch Operations** - Efficient bulk operations support

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  medusajs_dart_sdk:
    git:
      url: https://github.com/Ligament/medusajs-dart-sdk.git
```

Then run:

```bash
dart pub get
```

## Quick Start

### Initialize the SDK

```dart
import 'package:medusajs_dart_sdk/medusajs_dart_sdk.dart';

final medusa = Medusa(MedusaConfig(
  baseUrl: 'https://your-medusa-backend.com',
  publishableKey: 'pk_test_...', // Optional for store operations
  apiToken: 'your-api-token',     // Optional for admin operations
));
```

### Store Operations

```dart
// List products
final products = await medusa.store.product.list();

// Get a specific product
final product = await medusa.store.product.retrieve('prod_123');

// Create a cart
final cart = await medusa.store.cart.create({
  'region_id': 'reg_123',
});

// Add items to cart
await medusa.store.cart.lineItems.create(cart.id!, {
  'variant_id': 'variant_123',
  'quantity': 2,
});
```

### Authentication

```dart
// Customer login
await medusa.auth.login('customer', 'email_pass', {
  'email': 'customer@example.com',
  'password': 'password',
});

// Admin login
await medusa.auth.login('admin', 'email_pass', {
  'email': 'admin@example.com',
  'password': 'password',
});

// Check authentication status
final isAuthenticated = await medusa.auth.getToken() != null;
```

### Admin Operations

```dart
// List orders (requires admin authentication)
final orders = await medusa.admin.order.list();

// Create a product
final product = await medusa.admin.product.create({
  'title': 'New Product',
  'description': 'Product description',
  'status': 'draft',
});

// Update inventory
await medusa.admin.inventoryItem.update('inv_123', {
  'sku': 'NEW-SKU-123',
});
```

## Advanced Usage

### Custom Configuration

```dart
final medusa = Medusa(MedusaConfig(
  baseUrl: 'https://your-medusa-backend.com',
  publishableKey: 'pk_test_...',
  apiToken: 'your-api-token',
  debug: true,                    // Enable debug logging
  maxRetries: 3,                  // Request retry configuration
  timeout: Duration(seconds: 30), // Request timeout
));
```

### Caching

```dart
// Enable caching with custom configuration
final cache = MedusaCache(
  ttl: Duration(minutes: 10),
  maxSize: 100,
);

final medusa = Medusa(config, cache: cache);
```

### Query Building

```dart
// Use query builder for complex requests
final query = QueryBuilder()
  .expand(['variants', 'images'])
  .limit(20)
  .offset(0)
  .order('created_at')
  .build();

final products = await medusa.store.product.list(query: query);
```

### Real-time Updates

```dart
// Subscribe to real-time events
medusa.realtime.subscribe('orders.*', (event) {
  print('Order updated: ${event.data}');
});

// Connect to real-time server
await medusa.realtime.connect();
```

### Webhook Verification

```dart
// Verify webhook signatures
final isValid = medusa.webhooks.verifySignature(
  payload: requestBody,
  signature: signatureHeader,
  secret: 'your-webhook-secret',
);
```

## API Reference

### Store API

- **Products**: `medusa.store.product`
- **Collections**: `medusa.store.collection`
- **Categories**: `medusa.store.category`
- **Carts**: `medusa.store.cart`
- **Orders**: `medusa.store.order`
- **Customers**: `medusa.store.customer`
- **Regions**: `medusa.store.region`
- **Shipping**: `medusa.store.fulfillment`
- **Payment**: `medusa.store.payment`

### Admin API

- **Products**: `medusa.admin.product`
- **Orders**: `medusa.admin.order`
- **Customers**: `medusa.admin.customer`
- **Users**: `medusa.admin.user`
- **Regions**: `medusa.admin.region`
- **Discounts**: `medusa.admin.discount`
- **Gift Cards**: `medusa.admin.giftCard`
- **Inventory**: `medusa.admin.inventoryItem`
- **Stock Locations**: `medusa.admin.stockLocation`

### Authentication

- **Login**: `medusa.auth.login(actor, provider, payload)`
- **Logout**: `medusa.auth.logout()`
- **Get Token**: `medusa.auth.getToken()`
- **Refresh Token**: `medusa.auth.refresh()`

## Error Handling

The SDK provides comprehensive error handling:

```dart
try {
  final product = await medusa.store.product.retrieve('invalid-id');
} on MedusaException catch (e) {
  print('Medusa error: ${e.message}');
  print('Status code: ${e.statusCode}');
  print('Error code: ${e.code}');
} on NetworkException catch (e) {
  print('Network error: ${e.message}');
} catch (e) {
  print('Unexpected error: $e');
}
```

## Models

The SDK includes fully typed models for all Medusa entities:

- `Product`, `ProductVariant`
- `Cart`, `LineItem`
- `Order`, `Fulfillment`
- `Customer`, `Address`
- `Region`, `Currency`
- `Collection`, `Category`
- `Discount`, `GiftCard`
- And many more...

All models support JSON serialization:

```dart
// From JSON
final product = Product.fromJson(jsonData);

// To JSON
final json = product.toJson();
```

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- 📖 [Medusa.js Documentation](https://docs.medusajs.com)
- 🐛 [Report Issues](https://github.com/Ligament/medusajs-dart-sdk/issues)
- 💬 [Discord Community](https://discord.gg/medusajs)

## Acknowledgments

This SDK is based on the official [Medusa.js JavaScript SDK](https://www.npmjs.com/package/@medusajs/js-sdk) v2.8.3 and follows the same API structure and conventions.
