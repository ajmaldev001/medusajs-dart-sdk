import 'package:json_annotation/json_annotation.dart';

part 'adjustment.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Adjustment {
  final String? id;
  final String? description;
  final int? amount;
  final String? type;
  final Map<String, dynamic>? metadata;

  const Adjustment({
    this.id,
    this.description,
    this.amount,
    this.type,
    this.metadata,
  });

  factory Adjustment.fromJson(Map<String, dynamic> json) =>
      _$AdjustmentFromJson(json);
  Map<String, dynamic> toJson() => _$AdjustmentToJson(this);
}
