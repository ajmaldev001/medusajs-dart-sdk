import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin region management resource
class AdminRegionResource extends AdminResource {
  const AdminRegionResource(super.client);

  String get resourcePath => '$basePath/regions';

  /// List regions
  Future<PaginatedResponse<Region>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<Region>(
      endpoint: resourcePath,
      dataKey: 'regions',
      fromJson: Region.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a region by ID
  Future<Region?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<Region>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'region',
      fromJson: Region.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new region
  Future<Region?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<Region>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'region',
      fromJson: Region.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a region
  Future<Region?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<Region>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'region',
      fromJson: Region.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a region
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

  /// Add countries to region
  Future<Region?> addCountries(
    String id,
    List<String> countryCodes, {
    ClientHeaders? headers,
  }) async {
    final body = {'countries': countryCodes};

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/countries',
      method: 'POST',
      body: body,
      headers: headers,
    );

    final regionData = response['region'];
    return regionData != null
        ? Region.fromJson(regionData as Map<String, dynamic>)
        : null;
  }

  /// Remove countries from region
  Future<Region?> removeCountries(
    String id,
    List<String> countryCodes, {
    ClientHeaders? headers,
  }) async {
    final body = {'countries': countryCodes};

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/countries',
      method: 'DELETE',
      body: body,
      headers: headers,
    );

    final regionData = response['region'];
    return regionData != null
        ? Region.fromJson(regionData as Map<String, dynamic>)
        : null;
  }

  /// Add payment providers to region
  Future<Region?> addPaymentProviders(
    String id,
    List<String> providerIds, {
    ClientHeaders? headers,
  }) async {
    final body = {'provider_ids': providerIds};

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/payment-providers',
      method: 'POST',
      body: body,
      headers: headers,
    );

    final regionData = response['region'];
    return regionData != null
        ? Region.fromJson(regionData as Map<String, dynamic>)
        : null;
  }

  /// Remove payment providers from region
  Future<Region?> removePaymentProviders(
    String id,
    List<String> providerIds, {
    ClientHeaders? headers,
  }) async {
    final body = {'provider_ids': providerIds};

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/payment-providers',
      method: 'DELETE',
      body: body,
      headers: headers,
    );

    final regionData = response['region'];
    return regionData != null
        ? Region.fromJson(regionData as Map<String, dynamic>)
        : null;
  }

  /// Add fulfillment providers to region
  Future<Region?> addFulfillmentProviders(
    String id,
    List<String> providerIds, {
    ClientHeaders? headers,
  }) async {
    final body = {'provider_ids': providerIds};

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/fulfillment-providers',
      method: 'POST',
      body: body,
      headers: headers,
    );

    final regionData = response['region'];
    return regionData != null
        ? Region.fromJson(regionData as Map<String, dynamic>)
        : null;
  }

  /// Remove fulfillment providers from region
  Future<Region?> removeFulfillmentProviders(
    String id,
    List<String> providerIds, {
    ClientHeaders? headers,
  }) async {
    final body = {'provider_ids': providerIds};

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/fulfillment-providers',
      method: 'DELETE',
      body: body,
      headers: headers,
    );

    final regionData = response['region'];
    return regionData != null
        ? Region.fromJson(regionData as Map<String, dynamic>)
        : null;
  }
}