import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin promotion management resource
class AdminPromotionResource extends AdminResource {
  const AdminPromotionResource(super.client);

  String get resourcePath => '$basePath/promotions';

  /// List promotions
  Future<PaginatedResponse<Promotion>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<Promotion>(
      endpoint: resourcePath,
      dataKey: 'promotions',
      fromJson: Promotion.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a promotion by ID
  Future<Promotion?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<Promotion>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'promotion',
      fromJson: Promotion.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new promotion
  Future<Promotion?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<Promotion>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'promotion',
      fromJson: Promotion.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a promotion
  Future<Promotion?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<Promotion>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'promotion',
      fromJson: Promotion.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a promotion
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

  /// Search promotions by code
  Future<PaginatedResponse<Promotion>> search(
    String searchTerm, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['q'] = searchTerm;

    return list(query: query, headers: headers);
  }

  /// Get promotions by code
  Future<PaginatedResponse<Promotion>> byCode(
    String code, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['code'] = code;

    return list(query: query, headers: headers);
  }

  /// Get active promotions
  Future<PaginatedResponse<Promotion>> getActive({
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['is_disabled'] = false;
    
    final now = DateTime.now().toIso8601String();
    query['valid_from'] = {'lte': now};
    
    return list(query: query, headers: headers);
  }

  /// Get promotions by type
  Future<PaginatedResponse<Promotion>> byType(
    String type, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['type'] = type;

    return list(query: query, headers: headers);
  }

  /// Add rule to promotion
  Future<Promotion?> addRule(
    String id,
    Map<String, dynamic> ruleData, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/rules',
      method: 'POST',
      body: ruleData,
      headers: headers,
    );

    final data = response['promotion'];
    return data != null ? Promotion.fromJson(data as Map<String, dynamic>) : null;
  }

  /// Remove rule from promotion
  Future<Promotion?> removeRule(
    String id,
    String ruleId, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/rules/$ruleId',
      method: 'DELETE',
      headers: headers,
    );

    final data = response['promotion'];
    return data != null ? Promotion.fromJson(data as Map<String, dynamic>) : null;
  }
}