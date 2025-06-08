import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin payment resource for managing payments
class AdminPaymentResource extends AdminResource {
  const AdminPaymentResource(super.client);

  String get resourcePath => '$basePath/payments';

  /// List payments
  Future<PaginatedResponse<Payment>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<Payment>(
      endpoint: resourcePath,
      dataKey: 'payments',
      fromJson: Payment.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a payment by ID
  Future<Payment?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<Payment>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'payment',
      fromJson: Payment.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Capture a payment
  Future<Payment?> capture(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/capture',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final paymentData = response['payment'] as Map<String, dynamic>?;
    return paymentData != null ? Payment.fromJson(paymentData) : null;
  }

  /// Refund a payment
  Future<Payment?> refund(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/refund',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final paymentData = response['payment'] as Map<String, dynamic>?;
    return paymentData != null ? Payment.fromJson(paymentData) : null;
  }

  /// Cancel a payment
  Future<Payment?> cancel(
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

    final paymentData = response['payment'] as Map<String, dynamic>?;
    return paymentData != null ? Payment.fromJson(paymentData) : null;
  }

  /// Get payments by order
  Future<PaginatedResponse<Payment>> byOrder(
    String orderId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['order_id'] = orderId;

    return list(query: query, headers: headers);
  }

  /// Get payments by status
  Future<PaginatedResponse<Payment>> byStatus(
    String status, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['status'] = status;

    return list(query: query, headers: headers);
  }

  /// Get payments by provider
  Future<PaginatedResponse<Payment>> byProvider(
    String providerId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['provider_id'] = providerId;

    return list(query: query, headers: headers);
  }
}