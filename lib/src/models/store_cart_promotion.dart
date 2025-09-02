import 'package:json_annotation/json_annotation.dart';

part 'store_cart_promotion.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class StoreCartPromotion {
  final String id;
  final String? code;
  final String? description;
  final int? amount;

  StoreCartPromotion({
    required this.id,
    this.code,
    this.description,
    this.amount,
  });

  factory StoreCartPromotion.fromJson(Map<String, dynamic> json) =>
      _$StoreCartPromotionFromJson(json);
  Map<String, dynamic> toJson() => _$StoreCartPromotionToJson(this);
}
