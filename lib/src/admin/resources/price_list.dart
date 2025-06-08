import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin price list resource for managing price lists
class AdminPriceListResource extends AdminResource {
  const AdminPriceListResource(super.client);

  String get resourcePath => '$basePath/price-lists';

  /// List price lists
  Future<PaginatedResponse<PriceList>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<PriceList>(
      endpoint: resourcePath,
      dataKey: 'price_lists',
      fromJson: PriceList.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a price list by ID
  Future<PriceList?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<PriceList>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'price_list',
      fromJson: PriceList.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a price list
  Future<PriceList?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<PriceList>(
      endpoint: resourcePath,
      body: body,
      dataKey: 'price_list',
      fromJson: PriceList.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a price list
  Future<PriceList?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<PriceList>(
      id: id,
      endpoint: '$resourcePath/$id',
      body: body,
      dataKey: 'price_list',
      fromJson: PriceList.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a price list
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
}