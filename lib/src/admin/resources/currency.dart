import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin currency management resource
class AdminCurrencyResource extends AdminResource {
  const AdminCurrencyResource(super.client);

  String get resourcePath => '$basePath/currencies';

  /// List currencies
  Future<PaginatedResponse<Currency>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<Currency>(
      endpoint: resourcePath,
      dataKey: 'currencies',
      fromJson: Currency.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a currency by code
  Future<Currency?> retrieve(
    String code, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<Currency>(
      id: code,
      endpoint: '$resourcePath/$code',
      dataKey: 'currency',
      fromJson: Currency.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a currency
  Future<Currency?> update(
    String code,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<Currency>(
      id: code,
      body: body,
      endpoint: '$resourcePath/$code',
      dataKey: 'currency',
      fromJson: Currency.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Get currency by symbol
  Future<PaginatedResponse<Currency>> bySymbol(
    String symbol, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['symbol'] = symbol;

    return list(query: query, headers: headers);
  }

  /// Get all supported currencies
  Future<List<Currency>> getAllSupported({
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/supported',
      headers: headers,
    );

    final currencies = (response['currencies'] as List? ?? [])
        .map((json) => Currency.fromJson(json as Map<String, dynamic>))
        .toList();

    return currencies;
  }

  /// Add a currency to store
  Future<Currency?> addToStore(
    String code, {
    ClientHeaders? headers,
  }) async {
    return await createGeneric<Currency>(
      body: {'code': code},
      endpoint: '$resourcePath/$code/add',
      dataKey: 'currency',
      fromJson: Currency.fromJson,
      headers: headers,
    );
  }

  /// Remove a currency from store
  Future<Map<String, dynamic>> removeFromStore(
    String code, {
    ClientHeaders? headers,
  }) async {
    return await deleteGeneric(
      id: code,
      endpoint: '$resourcePath/$code/remove',
      headers: headers,
    );
  }
}