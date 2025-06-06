// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
  id: json['id'] as String,
  customerId: json['customerId'] as String?,
  company: json['company'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  address1: json['address1'] as String,
  address2: json['address2'] as String?,
  city: json['city'] as String,
  countryCode: json['countryCode'] as String,
  province: json['province'] as String?,
  postalCode: json['postalCode'] as String?,
  phone: json['phone'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'id': instance.id,
  'customerId': instance.customerId,
  'company': instance.company,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'address1': instance.address1,
  'address2': instance.address2,
  'city': instance.city,
  'countryCode': instance.countryCode,
  'province': instance.province,
  'postalCode': instance.postalCode,
  'phone': instance.phone,
  'metadata': instance.metadata,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
};
