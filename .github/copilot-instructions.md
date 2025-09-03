# GitHub Copilot Instructions for Medusa Dart SDK

This document provides AI coding agents with comprehensive guidance for contributing to the Medusa Dart SDK project.

## Project Overview

The Medusa Dart SDK is a comprehensive client library for interacting with Medusa.js v2.10+ backends. It provides type-safe access to both Store (customer-facing) and Admin API endpoints with robust error handling, caching, and developer-friendly features.

**Version:** 2.10.1  
**Target:** Medusa.js v2.10+ compatibility  
**Language:** Dart/Flutter  

## Architecture Patterns

### 1. Layered Resource Architecture

The SDK uses a consistent 4-layer pattern:

```dart
Medusa Client → Store/Admin Module → Resource Classes → Base Resource
```

**Core Classes:**
- `Medusa` - Main SDK entry point
- `MedusaStore` - Customer-facing operations
- `MedusaAdmin` - Administrative operations  
- `BaseResource` - Generic CRUD operations
- `StoreResource`/`AdminResource` - Base path providers

### 2. Resource Implementation Pattern

All resources follow this consistent pattern:

```dart
class AdminProductResource extends AdminResource {
  const AdminProductResource(super.client);
  
  String get resourcePath => '$basePath/products';
  
  Future<PaginatedResponse<Product>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<Product>(
      endpoint: resourcePath,
      dataKey: 'products',
      fromJson: Product.fromJson,
      query: query,
      headers: headers,
    );
  }
}
```

**Key Requirements:**
- Extend `AdminResource` or `StoreResource`
- Use `super.client` in constructor
- Define `resourcePath` with proper API endpoint
- Use generic methods from `BaseResource`
- Match `dataKey` with Medusa API response structure

### 3. Generic Base Operations

`BaseResource` provides these generic methods:
- `listGeneric<T>()` - List resources with pagination
- `retrieveGeneric<T>()` - Get single resource by ID
- `createGeneric<T>()` - Create new resource
- `updateGeneric<T>()` - Update existing resource
- `deleteGeneric()` - Delete resource

### 4. Model and JSON Serialization

All models use `json_annotation` with `build_runner`:

```dart
@JsonSerializable(fieldRename: FieldRename.snake)
class Product {
  final String id;
  final String title;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  
  factory Product.fromJson(Map<String, dynamic> json) => 
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
```

**Generation Command:** `dart run build_runner build`

## Development Workflows

### Adding New Resources

1. **Create Model** (`lib/src/models/`)
   - Add `@JsonSerializable` annotations
   - Use `FieldRename.snake` for Medusa API compatibility
   - Export in `models/models.dart`

2. **Create Resource Class** (`lib/src/admin/resources/` or `lib/src/store/resources/`)
   - Extend appropriate base class
   - Implement required CRUD operations
   - Use generic methods from `BaseResource`
   - Export in `resources/resources.dart`

3. **Update Module** (`lib/src/admin/admin.dart` or `lib/src/store/store.dart`)
   - Add `late final resourceName = ResourceClass(_client);`
   - Follow alphabetical organization

4. **Generate Code**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

5. **Add Tests**
   - Create integration tests in `test/`
   - Test CRUD operations and error handling

### Medusa v2.10 Specific Features

**Shipping Option Types:** New in v2.10
```dart
class ShippingOptionType {
  final String id;
  final String label;
  final String code;
  final Map<String, dynamic>? metadata;
}
```

**WithDeleted Query Support:** Enhanced query capabilities
```dart
final query = QueryBuilder()
  .withDeleted(true)  // Include deleted records
  .limit(50)
  .build();
```

**Map<String, dynamic> Usage:** Replace "exit avert" types
- Use `Map<String, dynamic>` for flexible API responses
- Avoid rigid typing where API structure varies
- Particularly important for metadata fields and custom attributes

## Code Conventions

### File Organization
```
lib/src/
├── models/           # Data models with JSON serialization
├── admin/resources/  # Admin API resources
├── store/resources/  # Store API resources  
├── client/          # HTTP client and config
├── types/           # Type definitions and interfaces
├── query/           # Query building utilities
└── exceptions/      # Error handling classes
```

### Naming Conventions
- **Files:** `snake_case.dart`
- **Classes:** `PascalCase`
- **Variables:** `camelCase`
- **Constants:** `lowerCamelCase` or `SCREAMING_SNAKE_CASE`
- **Resource paths:** Match Medusa API exactly (e.g., `/admin/product-categories`)

### Error Handling
```dart
try {
  final result = await resource.operation();
  return result;
} on MedusaException catch (e) {
  // Handle Medusa-specific errors
  rethrow;
} catch (e) {
  // Handle general errors
  throw MedusaException('Operation failed: $e');
}
```

### Async Patterns
- All API operations return `Future<T>`
- Use nullable returns (`T?`) for retrieve operations
- Use `PaginatedResponse<T>` for list operations
- Support optional query parameters and headers

## Testing Guidelines

### Integration Tests
```dart
test('should list products with pagination', () async {
  final medusa = Medusa(MedusaConfig(
    baseUrl: 'https://demo.medusajs.com',
  ));
  
  final result = await medusa.store.product.list();
  
  expect(result.data, isA<List<Product>>());
  expect(result.count, greaterThan(0));
});
```

### Test Structure
- Use `test/` directory for all tests
- Group related tests in test suites
- Test both success and error scenarios
- Mock external dependencies when needed

## Documentation Standards

### Code Comments
```dart
/// Admin shipping option type management resource for v2.10+
/// 
/// Manages shipping option types which define reusable shipping
/// configurations that can be applied across multiple shipping options.
class AdminShippingOptionTypeResource extends AdminResource {
```

### Example Usage
Include practical examples in resource documentation:
```dart
/// Example:
/// ```dart
/// final types = await medusa.admin.shippingOptionType.list();
/// final newType = await medusa.admin.shippingOptionType.create({
///   'label': 'Express Shipping',
///   'code': 'express',
/// });
/// ```
```

## Common Pitfalls to Avoid

1. **Import Paths:** Always use relative imports within the SDK
2. **JSON Keys:** Use `@JsonKey(name: 'field_name')` for API field mapping
3. **Nullable Fields:** Most API fields should be nullable in Dart models
4. **Resource Paths:** Must match Medusa API exactly (including hyphens)
5. **Data Keys:** Response parsing requires correct `dataKey` parameter
6. **Build Generation:** Run `build_runner` after model changes

## Performance Considerations

1. **Caching:** HTTP client supports automatic GET response caching
2. **Pagination:** Use appropriate `limit` and `offset` for large datasets
3. **Query Parameters:** Leverage Medusa's filtering capabilities
4. **Bulk Operations:** Use batch operations where available

## Version Compatibility

**Current Target:** Medusa.js v2.10.1
**Breaking Changes from v2.8:**
- Shipping option types are now required for some operations
- `withDeleted()` must be explicitly called to include deleted records
- Some response structures have changed to use more generic types
- Cart operations performance improvements in v2.10.1

When updating for new Medusa versions:
1. Review Medusa.js changelog for breaking changes
2. Update models to match new API responses
3. Add new endpoints as resource methods
4. Update version in `pubspec.yaml`
5. Test thoroughly with integration tests

## Getting Help

- **Medusa Documentation:** https://docs.medusajs.com/
- **API Reference:** https://docs.medusajs.com/api/
- **Dart Documentation:** https://dart.dev/guides
- **JSON Annotation:** https://pub.dev/packages/json_annotation

This SDK is designed to be maintainable and extensible. Follow these patterns consistently to ensure code quality and developer experience remain high.
