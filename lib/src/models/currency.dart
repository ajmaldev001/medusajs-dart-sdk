import 'package:json_annotation/json_annotation.dart';

part 'currency.g.dart';

/// Represents a currency in the Medusa system
@JsonSerializable()
class Currency {
  /// Currency code (ISO 4217)
  final String code;

  /// Currency symbol
  final String symbol;

  /// Number of decimal places for the currency
  final int symbolNative;

  /// Currency name
  final String name;

  /// Whether tax is included in prices for this currency
  final bool? includesTax;

  const Currency({
    required this.code,
    required this.symbol,
    required this.symbolNative,
    required this.name,
    this.includesTax,
  });

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);

  /// Format an amount according to this currency
  String formatAmount(int amount) {
    final decimal = amount / 100; // Convert from smallest unit
    return '$symbol${decimal.toStringAsFixed(2)}';
  }

  /// Convert amount from major units to minor units (e.g., dollars to cents)
  int toMinorUnits(double amount) {
    return (amount * 100).round();
  }

  /// Convert amount from minor units to major units (e.g., cents to dollars)
  double toMajorUnits(int amount) {
    return amount / 100;
  }
}
