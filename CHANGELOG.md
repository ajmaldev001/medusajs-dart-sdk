# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.10.0] - 2024-12-07

### Added
- **BREAKING**: Updated to Medusa.js v2.10.0 compatibility
- Added support for Shipping Option Types management
  - New `ShippingOptionType` model with label, description, and code
  - Admin resource `AdminShippingOptionTypeResource` for CRUD operations
  - Updated `ShippingOption` model to include optional `typeId` field
- Added `withDeleted()` method to `QueryBuilder` for querying deleted records (v2.10 feature)
- Enhanced fulfillment models with better type safety using `Map<String, dynamic>`

### Fixed
- Improved type consistency across models following Medusa v2.10 API changes
- Updated shipping option calculations to support new type-based filtering

### Notes
- This version introduces breaking changes from Medusa.js v2.10.0
- Shipping option types enable better categorization (e.g., Standard, Express)
- Query with deleted records now requires explicit `withDeleted()` flag

## [2.8.5] - 2024-12-06

### Added
- Initial release of Medusa.js Dart SDK
- Complete Store API implementation
  - Products, collections, categories
  - Shopping carts and line items
  - Orders and fulfillment
  - Customer management
  - Regions and currencies
  - Payment and shipping options
- Full Admin API support
  - Product management
  - Order administration
  - Customer administration
  - User management
  - Inventory and stock locations
  - Discounts and gift cards
- Authentication system
  - Customer and admin login
  - Token management
  - Session handling
- Real-time support
  - WebSocket connections
  - Event subscriptions
  - Live updates
- Caching functionality
  - Configurable TTL
  - Memory-based cache
  - Request optimization
- Webhook utilities
  - Signature verification
  - Event handling
- Query builder
  - Pagination support
  - Filtering and sorting
  - Field expansion
- Batch operations
  - Bulk API requests
  - Transaction support
- Type-safe models
  - JSON serialization/deserialization
  - Null safety support
  - Generated code for models
- Comprehensive error handling
  - Custom exception types
  - Network error handling
  - API error responses
- Flutter compatibility
  - SharedPreferences integration
  - Mobile-optimized HTTP client

### Technical Details
- Based on Medusa.js JavaScript SDK v2.8.3
- Dart SDK 3.7.2+ compatibility
- Full null safety support
- Code generation for JSON serialization
- HTTP client with retry logic and timeout handling

### Dependencies
- `http`: ^1.2.1 - HTTP client for API requests
- `json_annotation`: ^4.9.0 - JSON serialization annotations
- `shared_preferences`: ^2.2.3 - Local storage for tokens and cache

### Dev Dependencies
- `test`: ^1.25.2 - Testing framework
- `build_runner`: ^2.4.12 - Code generation
- `json_serializable`: ^6.8.0 - JSON serialization generator
- `lints`: ^4.0.0 - Dart linting rules
