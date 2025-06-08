import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin fulfillment management resource
class AdminFulfillmentResource extends AdminResource {
  const AdminFulfillmentResource(super.client);

  String get resourcePath => '$basePath/fulfillments';

  /// List fulfillments
  Future<PaginatedResponse<Fulfillment>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<Fulfillment>(
      endpoint: resourcePath,
      dataKey: 'fulfillments',
      fromJson: Fulfillment.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a fulfillment by ID
  Future<Fulfillment?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<Fulfillment>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'fulfillment',
      fromJson: Fulfillment.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new fulfillment
  Future<Fulfillment?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<Fulfillment>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'fulfillment',
      fromJson: Fulfillment.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a fulfillment
  Future<Fulfillment?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<Fulfillment>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'fulfillment',
      fromJson: Fulfillment.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Cancel a fulfillment
  Future<Fulfillment?> cancel(
    String id, {
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<Fulfillment>(
      id: id,
      body: {'canceled_at': DateTime.now().toIso8601String()},
      endpoint: '$resourcePath/$id/cancel',
      dataKey: 'fulfillment',
      fromJson: Fulfillment.fromJson,
      headers: headers,
    );
  }

  /// Mark fulfillment as shipped
  Future<Fulfillment?> ship(
    String id, {
    Map<String, dynamic>? trackingData,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<Fulfillment>(
      id: id,
      body: {
        'shipped_at': DateTime.now().toIso8601String(),
        ...?trackingData,
      },
      endpoint: '$resourcePath/$id/ship',
      dataKey: 'fulfillment',
      fromJson: Fulfillment.fromJson,
      headers: headers,
    );
  }

  /// Mark fulfillment as delivered
  Future<Fulfillment?> markDelivered(
    String id, {
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<Fulfillment>(
      id: id,
      body: {'delivered_at': DateTime.now().toIso8601String()},
      endpoint: '$resourcePath/$id/deliver',
      dataKey: 'fulfillment',
      fromJson: Fulfillment.fromJson,
      headers: headers,
    );
  }

  /// List fulfillments by order
  Future<PaginatedResponse<Fulfillment>> byOrder(
    String orderId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['order_id'] = orderId;

    return list(query: query, headers: headers);
  }

  /// List fulfillments by location
  Future<PaginatedResponse<Fulfillment>> byLocation(
    String locationId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['location_id'] = locationId;

    return list(query: query, headers: headers);
  }

  /// List fulfillments by provider
  Future<PaginatedResponse<Fulfillment>> byProvider(
    String providerId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['provider_id'] = providerId;

    return list(query: query, headers: headers);
  }

  /// List fulfillments by status
  Future<PaginatedResponse<Fulfillment>> byStatus(
    String status, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['status'] = status;

    return list(query: query, headers: headers);
  }

  /// Get tracking information for fulfillment
  Future<Map<String, dynamic>> getTracking(
    String id, {
    ClientHeaders? headers,
  }) async {
    return await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/tracking',
      headers: headers,
    );
  }

  /// Update tracking information for fulfillment
  Future<Fulfillment?> updateTracking(
    String id,
    Map<String, dynamic> trackingData, {
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<Fulfillment>(
      id: id,
      body: trackingData,
      endpoint: '$resourcePath/$id/tracking',
      dataKey: 'fulfillment',
      fromJson: Fulfillment.fromJson,
      headers: headers,
    );
  }
}