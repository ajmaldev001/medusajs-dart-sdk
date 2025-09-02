import '../../resources/base_resource.dart';
import '../../models/fulfillment.dart';
import '../../models/common.dart';
import '../../types/types.dart';

/// Admin shipping option types management resource (added in v2.10)
class AdminShippingOptionTypeResource extends AdminResource {
  const AdminShippingOptionTypeResource(super.client);

  String get resourcePath => '$basePath/shipping-option-types';

  /// List shipping option types
  Future<PaginatedResponse<ShippingOptionType>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<ShippingOptionType>(
      endpoint: resourcePath,
      dataKey: 'shipping_option_types',
      fromJson: ShippingOptionType.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a shipping option type by ID
  Future<ShippingOptionType?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<ShippingOptionType>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'shipping_option_type',
      fromJson: ShippingOptionType.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new shipping option type
  Future<ShippingOptionType?> create(
    CreateShippingOptionTypeRequest request, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<ShippingOptionType>(
      body: request.toJson(),
      endpoint: resourcePath,
      dataKey: 'shipping_option_type',
      fromJson: ShippingOptionType.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a shipping option type
  Future<ShippingOptionType?> update(
    String id,
    UpdateShippingOptionTypeRequest request, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<ShippingOptionType>(
      id: id,
      body: request.toJson(),
      endpoint: '$resourcePath/$id',
      dataKey: 'shipping_option_type',
      fromJson: ShippingOptionType.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a shipping option type
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

  /// Get shipping option type by code
  Future<ShippingOptionType?> byCode(
    String code, {
    ClientHeaders? headers,
  }) async {
    final response = await list(query: {'code': code}, headers: headers);

    return response.data.isNotEmpty ? response.data.first : null;
  }
}
