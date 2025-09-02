import 'package:json_annotation/json_annotation.dart';

part 'credit_line.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreditLine {
  final String id;
  final String cartId;
  final double amount;
  final String? reference;
  final String? referenceId;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CreditLine({
    required this.id,
    required this.cartId,
    required this.amount,
    this.reference,
    this.referenceId,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreditLine.fromJson(Map<String, dynamic> json) =>
      _$CreditLineFromJson(json);

  Map<String, dynamic> toJson() => _$CreditLineToJson(this);
}
