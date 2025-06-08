import '../client/client.dart';
import '../batch/batch.dart';
import 'resources/resources.dart';

/// Refactored Admin module for administrative operations
///
/// Provides access to all administrative functionality with improved organization:
/// - Cleaner resource structure
/// - Better separation of concerns
/// - Consistent API patterns
/// - Enhanced type safety
///
/// All admin operations require proper authentication and authorization.
class MedusaAdmin {
  final MedusaClient _client;

  MedusaAdmin(this._client);

  // Core Resources - Most commonly used

  /// Product management operations
  late final product = AdminProductResource(_client);

  /// Order management operations
  late final order = AdminOrderResource(_client);

  /// Customer management operations
  late final customer = AdminCustomerResource(_client);

  /// Category management operations
  late final category = AdminCategoryResource(_client);

  /// Collection management operations
  late final collection = AdminCollectionResource(_client);

  // Additional Resources

  /// API key management operations
  late final apiKey = AdminApiKeyResource(_client);

  /// Campaign management operations
  late final campaign = AdminCampaignResource(_client);

  /// Claim management operations
  late final claim = AdminClaimResource(_client);

  /// Currency management operations
  late final currency = AdminCurrencyResource(_client);

  /// Customer group management operations
  late final customerGroup = AdminCustomerGroupResource(_client);

  /// Draft order management operations
  late final draftOrder = AdminDraftOrderResource(_client);

  /// Exchange management operations
  late final exchange = AdminExchangeResource(_client);

  /// Fulfillment management operations
  late final fulfillment = AdminFulfillmentResource(_client);

  /// Fulfillment provider management operations
  late final fulfillmentProvider = AdminFulfillmentProviderResource(_client);

  /// Fulfillment set management operations
  late final fulfillmentSet = AdminFulfillmentSetResource(_client);

  /// Inventory item management operations
  late final inventoryItem = AdminInventoryItemResource(_client);

  /// User invite management operations
  late final invite = AdminInviteResource(_client);

  /// Notification management operations
  late final notification = AdminNotificationResource(_client);

  /// Order edit management operations
  late final orderEdit = AdminOrderEditResource(_client);

  /// Payment management operations
  late final payment = AdminPaymentResource(_client);

  /// Payment collection management operations
  late final paymentCollection = AdminPaymentCollectionResource(_client);

  /// Plugin management operations
  late final plugin = AdminPluginResource(_client);

  /// Price list management operations
  late final priceList = AdminPriceListResource(_client);

  /// Price preference management operations
  late final pricePreference = AdminPricePreferenceResource(_client);

  /// Product tag management operations
  late final productTag = AdminProductTagResource(_client);

  /// Product type management operations
  late final productType = AdminProductTypeResource(_client);

  /// Product variant management operations
  late final productVariant = AdminProductVariantResource(_client);

  /// Promotion management operations
  late final promotion = AdminPromotionResource(_client);

  /// Refund reason management operations
  late final refundReason = AdminRefundReasonResource(_client);

  /// Reservation management operations
  late final reservation = AdminReservationResource(_client);

  /// Return management operations
  late final returnResource = AdminReturnResource(_client);

  /// Return reason management operations
  late final returnReason = AdminReturnReasonResource(_client);

  /// Sales channel management operations
  late final salesChannel = AdminSalesChannelResource(_client);

  /// Shipping option management operations
  late final shippingOption = AdminShippingOptionResource(_client);

  /// Shipping profile management operations
  late final shippingProfile = AdminShippingProfileResource(_client);

  /// Stock location management operations
  late final stockLocation = AdminStockLocationResource(_client);

  /// Store management operations
  late final store = AdminStoreResource(_client);

  /// Tax provider management operations
  late final taxProvider = AdminTaxProviderResource(_client);

  /// Tax rate management operations
  late final taxRate = AdminTaxRateResource(_client);

  /// Tax region management operations
  late final taxRegion = AdminTaxRegionResource(_client);

  /// Upload management operations
  late final upload = AdminUploadResource(_client);

  /// Workflow execution management operations
  late final workflowExecution = AdminWorkflowExecutionResource(_client);

  // Utility Methods

  /// Create a new batch manager for bulk operations
  BatchManager createBatch({int maxBatchSize = 50}) {
    return BatchManager(_client, maxBatchSize: maxBatchSize);
  }

  /// Create a product batch builder
  ProductBatchBuilder batchProducts({int maxBatchSize = 50}) {
    final manager = createBatch(maxBatchSize: maxBatchSize);
    return ProductBatchBuilder(manager);
  }

  /// Create an order batch builder
  OrderBatchBuilder batchOrders({int maxBatchSize = 50}) {
    final manager = createBatch(maxBatchSize: maxBatchSize);
    return OrderBatchBuilder(manager);
  }

  /// Create an auto-batching manager
  AutoBatchManager createAutoBatch({
    Duration batchDelay = const Duration(milliseconds: 100),
    int maxBatchSize = 50,
  }) {
    return AutoBatchManager(
      _client,
      batchDelay: batchDelay,
      maxBatchSize: maxBatchSize,
    );
  }
}
