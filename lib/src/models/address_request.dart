import 'package:json_annotation/json_annotation.dart';
import 'address.dart';

part 'address_request.g.dart';

/// Request model for creating or updating addresses
@JsonSerializable(fieldRename: FieldRename.snake)
class AddressRequest {
  /// Customer ID (optional for guest checkouts)
  final String? customerId;

  /// Company name
  final String? company;

  /// First name
  final String? firstName;

  /// Last name
  final String? lastName;

  /// Address line 1
  final String? address1;

  /// Address line 2
  final String? address2;

  /// City
  final String? city;

  /// Country code (ISO 2-letter)
  final String? countryCode;

  /// Province/State
  final String? province;

  /// Postal/ZIP code
  final String? postalCode;

  /// Phone number
  final String? phone;

  /// Address metadata
  final Map<String, dynamic>? metadata;

  const AddressRequest({
    this.customerId,
    this.company,
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.countryCode,
    this.province,
    this.postalCode,
    this.phone,
    this.metadata,
  });

  factory AddressRequest.fromJson(Map<String, dynamic> json) =>
      _$AddressRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddressRequestToJson(this);

  /// Create from existing Address
  factory AddressRequest.fromAddress(Address address) {
    return AddressRequest(
      customerId: address.customerId,
      company: address.company,
      firstName: address.firstName,
      lastName: address.lastName,
      address1: address.address1,
      address2: address.address2,
      city: address.city,
      countryCode: address.countryCode,
      province: address.province,
      postalCode: address.postalCode,
      phone: address.phone,
      metadata: address.metadata,
    );
  }

  /// Get full name from first and last name
  String get fullName {
    final first = firstName ?? '';
    final last = lastName ?? '';
    if (first.isEmpty && last.isEmpty) return '';
    if (first.isEmpty) return last;
    if (last.isEmpty) return first;
    return '$first $last';
  }

  /// Get formatted address string
  String get formattedAddress {
    final lines = <String>[];

    if (address1?.isNotEmpty == true) lines.add(address1!);
    if (address2?.isNotEmpty == true) lines.add(address2!);

    final cityProvincePostal = [
      city,
      province,
      postalCode,
    ].where((s) => s?.isNotEmpty == true).join(', ');
    if (cityProvincePostal.isNotEmpty) lines.add(cityProvincePostal);

    if (countryCode?.isNotEmpty == true) lines.add(countryCode!);

    return lines.join('\n');
  }
}
