import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

/// Represents an address in the Medusa system
@JsonSerializable()
class Address {
  /// Unique identifier for the address
  final String id;

  /// Customer ID (if address belongs to a customer)
  final String? customerId;

  /// Company name
  final String? company;

  /// First name
  final String? firstName;

  /// Last name
  final String? lastName;

  /// Address line 1
  final String address1;

  /// Address line 2
  final String? address2;

  /// City
  final String city;

  /// Country code (ISO 2 letter code)
  final String countryCode;

  /// Province/state
  final String? province;

  /// Postal/ZIP code
  final String? postalCode;

  /// Phone number
  final String? phone;

  /// Address metadata
  final Map<String, dynamic>? metadata;

  /// When the address was created
  final DateTime createdAt;

  /// When the address was last updated
  final DateTime updatedAt;

  /// When the address was deleted (if soft deleted)
  final DateTime? deletedAt;

  const Address({
    required this.id,
    this.customerId,
    this.company,
    this.firstName,
    this.lastName,
    required this.address1,
    this.address2,
    required this.city,
    required this.countryCode,
    this.province,
    this.postalCode,
    this.phone,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);

  /// Get full name from first and last name
  String get fullName {
    final first = firstName ?? '';
    final last = lastName ?? '';
    return '$first $last'.trim();
  }

  /// Get formatted address string
  String get formattedAddress {
    final parts = <String>[
      if (company != null) company!,
      address1,
      if (address2 != null) address2!,
      '$city${province != null ? ', $province' : ''}${postalCode != null ? ' $postalCode' : ''}',
      countryCode.toUpperCase(),
    ];
    return parts.join('\n');
  }

  /// Get single line address string
  String get singleLineAddress {
    final parts = <String>[
      address1,
      if (address2 != null) address2!,
      city,
      if (province != null) province!,
      if (postalCode != null) postalCode!,
      countryCode.toUpperCase(),
    ];
    return parts.join(', ');
  }

  /// Check if address has complete information
  bool get isComplete {
    return address1.isNotEmpty && city.isNotEmpty && countryCode.isNotEmpty;
  }
}
