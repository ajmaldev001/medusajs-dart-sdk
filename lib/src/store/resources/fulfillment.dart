import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Store fulfillment resource for shipping options and calculations
class StoreFulfillmentResource extends StoreResource {
  const StoreFulfillmentResource(super.client);

  String get resourcePath => '$basePath/shipping-options';

  /// List shipping options for a cart
  Future<PaginatedResponse<Map<String, dynamic>>> listCartOptions({
    String? cartId,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final queryParams = Map<String, dynamic>.from(query ?? {});
    if (cartId != null) {
      queryParams['cart_id'] = cartId;
    }

    final response = await client.fetch<Map<String, dynamic>>(
      resourcePath,
      query: queryParams,
      headers: headers,
    );

    final shippingOptions = (response['shipping_options'] as List? ?? [])
        .map((json) => json as Map<String, dynamic>)
        .toList();

    return PaginatedResponse(
      data: shippingOptions,
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Calculate shipping option price for a cart
  Future<Map<String, dynamic>?> calculate(
    String shippingOptionId, {
    String? cartId,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final requestBody = Map<String, dynamic>.from(body ?? {});
    if (cartId != null) {
      requestBody['cart_id'] = cartId;
    }

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$shippingOptionId/calculate',
      method: 'POST',
      body: requestBody,
      query: query,
      headers: headers,
    );

    return response['shipping_option'] as Map<String, dynamic>?;
  }

  /// List shipping options for a region
  Future<PaginatedResponse<Map<String, dynamic>>> listForRegion(
    String regionId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['region_id'] = regionId;

    return listCartOptions(query: query, headers: headers);
  }

  /// Get shipping options by provider
  Future<PaginatedResponse<Map<String, dynamic>>> byProvider(
    String providerId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['provider_id'] = providerId;

    return listCartOptions(query: query, headers: headers);
  }

  /// Get cheapest shipping option for cart
  Future<Map<String, dynamic>?> getCheapest({
    String? cartId,
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final options = await listCartOptions(
      cartId: cartId,
      query: additionalFilters,
      headers: headers,
    );

    if (options.data.isEmpty) return null;

    // Find option with lowest calculated price
    Map<String, dynamic>? cheapest;
    double? lowestPrice;

    for (final option in options.data) {
      final calculated = await calculate(
        option['id'] as String,
        cartId: cartId,
        headers: headers,
      );

      if (calculated != null) {
        final price = calculated['calculated_price'] as num?;
        if (price != null && (lowestPrice == null || price < lowestPrice)) {
          lowestPrice = price.toDouble();
          cheapest = calculated;
        }
      }
    }

    return cheapest;
  }

  /// Get fastest shipping option for cart
  Future<Map<String, dynamic>?> getFastest({
    String? cartId,
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['sort'] = 'delivery_time';
    query['order'] = 'asc';

    final options = await listCartOptions(
      cartId: cartId,
      query: query,
      headers: headers,
    );

    return options.data.isNotEmpty ? options.data.first : null;
  }
}