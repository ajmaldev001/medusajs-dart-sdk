import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Store region resource for region operations
class StoreRegionResource extends StoreResource {
  const StoreRegionResource(super.client);

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
}