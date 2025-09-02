import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

/// Represents a customer in the Medusa system
@JsonSerializable(fieldRename: FieldRename.snake)
class Customer {
  /// Unique identifier for the customer
  final String id;

  /// Customer's email address
  final String email;

  /// Customer's first name
  final String? firstName;

  /// Customer's last name
  final String? lastName;

  /// Customer's billing address ID
  final String? billingAddressId;

  /// Customer's phone number
  final String? phone;

  /// Whether the customer has an account (registered) or is a guest
  final bool hasAccount;

  /// Customer's metadata
  final Map<String, dynamic>? metadata;

  /// When the customer was created
  final DateTime createdAt;

  /// When the customer was last updated
  final DateTime updatedAt;

  /// When the customer was deleted (if soft deleted)
  final DateTime? deletedAt;

  const Customer({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.billingAddressId,
    this.phone,
    required this.hasAccount,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  /// Get customer's full name
  String get fullName {
    final first = firstName ?? '';
    final last = lastName ?? '';
    return '$first $last'.trim();
  }

  /// Check if customer has a complete profile
  bool get hasCompleteProfile {
    return firstName != null && lastName != null && phone != null;
  }
}
