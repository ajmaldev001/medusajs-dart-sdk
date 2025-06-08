import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin inventory item resource for managing inventory items
class AdminInventoryItemResource extends AdminResource {
  const AdminInventoryItemResource(super.client);

  String get resourcePath => '$basePath/inventory-items';

  /// List inventory items
  Future<PaginatedResponse<InventoryItem>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<InventoryItem>(
      endpoint: resourcePath,
      dataKey: 'inventory_items',
      fromJson: InventoryItem.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve an inventory item by ID
  Future<InventoryItem?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<InventoryItem>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'inventory_item',
      fromJson: InventoryItem.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create an inventory item
  Future<InventoryItem?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<InventoryItem>(
      endpoint: resourcePath,
      body: body,
      dataKey: 'inventory_item',
      fromJson: InventoryItem.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update an inventory item
  Future<InventoryItem?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<InventoryItem>(
      id: id,
      endpoint: '$resourcePath/$id',
      body: body,
      dataKey: 'inventory_item',
      fromJson: InventoryItem.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete an inventory item
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

  /// Get inventory levels for an item
  Future<PaginatedResponse<Map<String, dynamic>>> getInventoryLevels(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/location-levels',
      query: query,
      headers: headers,
    );

    final levels = (response['inventory_levels'] as List? ?? [])
        .map((json) => json as Map<String, dynamic>)
        .toList();

    return PaginatedResponse(
      data: levels,
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Update inventory level at location
  Future<Map<String, dynamic>> updateInventoryLevel(
    String id,
    String locationId,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/location-levels/$locationId',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    return response;
  }

  /// Create inventory level at location
  Future<Map<String, dynamic>> createInventoryLevel(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/location-levels',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    return response;
  }

  /// Delete inventory level at location
  Future<Map<String, dynamic>> deleteInventoryLevel(
    String id,
    String locationId, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/location-levels/$locationId',
      method: 'DELETE',
      headers: headers,
    );

    return response;
  }

  /// Search inventory items by SKU
  Future<PaginatedResponse<InventoryItem>> bySku(
    String sku, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['sku'] = sku;

    return list(query: query, headers: headers);
  }

  /// Get inventory items by location
  Future<PaginatedResponse<InventoryItem>> byLocation(
    String locationId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['location_id'] = locationId;

    return list(query: query, headers: headers);
  }
}