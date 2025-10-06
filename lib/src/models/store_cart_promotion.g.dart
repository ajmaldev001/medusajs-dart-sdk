// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_cart_promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreCartPromotion _$StoreCartPromotionFromJson(Map<String, dynamic> json) =>
    StoreCartPromotion(
      id: json['id'] as String,
      code: json['code'] as String?,
      description: json['description'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StoreCartPromotionToJson(StoreCartPromotion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'description': instance.description,
      'amount': instance.amount,
    };
