/// Base exception for Medusa SDK errors
class MedusaException implements Exception {
  final String message;
  final int? statusCode;
  final String? statusText;
  final Map<String, dynamic>? data;

  const MedusaException(
    this.message, {
    this.statusCode,
    this.statusText,
    this.data,
  });

  @override
  String toString() {
    return 'MedusaException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
  }
}

/// Exception thrown when HTTP request fails
class FetchError extends MedusaException {
  FetchError(
    String message, {
    int? statusCode,
    String? statusText,
    Map<String, dynamic>? data,
  }) : super(
         message,
         statusCode: statusCode,
         statusText: statusText,
         data: data,
       );
}

/// Exception thrown when authentication fails
class AuthenticationError extends MedusaException {
  AuthenticationError(String message) : super(message);
}

/// Exception thrown when authorization fails
class AuthorizationError extends MedusaException {
  AuthorizationError(String message) : super(message, statusCode: 403);
}

/// Exception thrown when resource is not found
class NotFoundError extends MedusaException {
  NotFoundError(String message) : super(message, statusCode: 404);
}

/// Exception thrown when validation fails
class ValidationError extends MedusaException {
  final List<ValidationErrorDetail>? errors;

  ValidationError(String message, {this.errors, Map<String, dynamic>? data})
    : super(message, statusCode: 400, data: data);
}

/// Exception thrown when rate limit is exceeded
class RateLimitError extends MedusaException {
  final int? retryAfter;

  RateLimitError(String message, {this.retryAfter})
    : super(message, statusCode: 429);
}

/// Exception thrown when server error occurs
class ServerError extends MedusaException {
  ServerError(String message, {int? statusCode, Map<String, dynamic>? data})
    : super(message, statusCode: statusCode ?? 500, data: data);
}

/// Exception thrown when network error occurs
class NetworkError extends MedusaException {
  NetworkError(String message) : super(message);
}

/// Exception thrown when timeout occurs
class TimeoutError extends MedusaException {
  TimeoutError(String message) : super(message);
}

/// Exception thrown when client configuration is invalid
class ConfigurationError extends MedusaException {
  ConfigurationError(String message) : super(message);
}

/// Details for validation errors
class ValidationErrorDetail {
  final String field;
  final String message;
  final String? code;

  const ValidationErrorDetail({
    required this.field,
    required this.message,
    this.code,
  });

  factory ValidationErrorDetail.fromJson(Map<String, dynamic> json) {
    return ValidationErrorDetail(
      field: json['field'] ?? '',
      message: json['message'] ?? '',
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'field': field, 'message': message, if (code != null) 'code': code};
  }
}
