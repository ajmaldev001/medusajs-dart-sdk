import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin exchange management resource
class AdminExchangeResource extends AdminResource {
  const AdminExchangeResource(super.client);

  String get resourcePath => '$basePath/exchanges';

  /// List exchanges
  Future<PaginatedResponse<Exchange>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<Exchange>(
      endpoint: resourcePath,
      dataKey: 'exchanges',
      fromJson: Exchange.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve an exchange by ID
  Future<Exchange?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<Exchange>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'exchange',
      fromJson: Exchange.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new exchange
  Future<Exchange?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<Exchange>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'exchange',
      fromJson: Exchange.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update an exchange
  Future<Exchange?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<Exchange>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'exchange',
      fromJson: Exchange.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete an exchange
  Future<Map<String, dynamic>> delete(
    String id, {
    ClientHeaders? headers,
  }) async {
    return await deleteGeneric(
      id: id,
      endpoint: '$resourcePath/$id',
      headers: headers,
    );
  }

  /// Cancel an exchange
  Future<Exchange?> cancel(
    String id, {
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<Exchange>(
      id: id,
      body: {'canceled_at': DateTime.now().toIso8601String()},
      endpoint: '$resourcePath/$id/cancel',
      dataKey: 'exchange',
      fromJson: Exchange.fromJson,
      headers: headers,
    );
  }

  /// Confirm an exchange
  Future<Exchange?> confirm(
    String id, {
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<Exchange>(
      id: id,
      body: {},
      endpoint: '$resourcePath/$id/confirm',
      dataKey: 'exchange',
      fromJson: Exchange.fromJson,
      headers: headers,
    );
  }

  /// List exchanges by order
  Future<PaginatedResponse<Exchange>> byOrder(
    String orderId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['order_id'] = orderId;

    return list(query: query, headers: headers);
  }

  /// List exchanges by status
  Future<PaginatedResponse<Exchange>> byStatus(
    String status, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['status'] = status;

    return list(query: query, headers: headers);
  }

  /// Add return items to exchange
  Future<Exchange?> addReturnItems(
    String id,
    Map<String, dynamic> returnData, {
    ClientHeaders? headers,
  }) async {
    return await createGeneric<Exchange>(
      body: returnData,
      endpoint: '$resourcePath/$id/return-items',
      dataKey: 'exchange',
      fromJson: Exchange.fromJson,
      headers: headers,
    );
  }

  /// Add additional items to exchange
  Future<Exchange?> addAdditionalItems(
    String id,
    Map<String, dynamic> itemsData, {
    ClientHeaders? headers,
  }) async {
    return await createGeneric<Exchange>(
      body: itemsData,
      endpoint: '$resourcePath/$id/additional-items',
      dataKey: 'exchange',
      fromJson: Exchange.fromJson,
      headers: headers,
    );
  }

  /// Create fulfillment for exchange
  Future<Exchange?> createFulfillment(
    String id,
    Map<String, dynamic> fulfillmentData, {
    ClientHeaders? headers,
  }) async {
    return await createGeneric<Exchange>(
      body: fulfillmentData,
      endpoint: '$resourcePath/$id/fulfillments',
      dataKey: 'exchange',
      fromJson: Exchange.fromJson,
      headers: headers,
    );
  }

  /// Create shipment for exchange
  Future<Exchange?> createShipment(
    String id,
    Map<String, dynamic> shipmentData, {
    ClientHeaders? headers,
  }) async {
    return await createGeneric<Exchange>(
      body: shipmentData,
      endpoint: '$resourcePath/$id/shipments',
      dataKey: 'exchange',
      fromJson: Exchange.fromJson,
      headers: headers,
    );
  }
}