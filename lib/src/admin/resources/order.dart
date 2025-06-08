import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin order management resource
class AdminOrderResource extends AdminResource {
  const AdminOrderResource(super.client);

  String get resourcePath => '$basePath/orders';

  /// List orders
  Future<PaginatedResponse<Order>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<Order>(
      endpoint: resourcePath,
      dataKey: 'orders',
      fromJson: Order.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve an order by ID
  Future<Order?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<Order>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'order',
      fromJson: Order.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update an order
  Future<Order?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<Order>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'order',
      fromJson: Order.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Cancel an order
  Future<Order?> cancel(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/cancel',
      method: 'POST',
      query: query,
      headers: headers,
    );

    final orderData = response['order'];
    return orderData != null 
        ? Order.fromJson(orderData as Map<String, dynamic>) 
        : null;
  }

  /// Complete an order
  Future<Order?> complete(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/complete',
      method: 'POST',
      query: query,
      headers: headers,
    );

    final orderData = response['order'];
    return orderData != null 
        ? Order.fromJson(orderData as Map<String, dynamic>) 
        : null;
  }

  /// Archive an order
  Future<Order?> archive(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/archive',
      method: 'POST',
      query: query,
      headers: headers,
    );

    final orderData = response['order'];
    return orderData != null 
        ? Order.fromJson(orderData as Map<String, dynamic>) 
        : null;
  }

  /// Capture payment for an order
  Future<Order?> capturePayment(
    String id, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/capture',
      method: 'POST',
      body: body ?? {},
      query: query,
      headers: headers,
    );

    final orderData = response['order'];
    return orderData != null 
        ? Order.fromJson(orderData as Map<String, dynamic>) 
        : null;
  }

  /// Create fulfillment for an order
  Future<Order?> createFulfillment(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/fulfillments',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final orderData = response['order'];
    return orderData != null 
        ? Order.fromJson(orderData as Map<String, dynamic>) 
        : null;
  }

  /// Create shipment for fulfillment
  Future<Order?> createShipment(
    String id,
    String fulfillmentId,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/fulfillments/$fulfillmentId/shipments',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final orderData = response['order'];
    return orderData != null 
        ? Order.fromJson(orderData as Map<String, dynamic>) 
        : null;
  }
}