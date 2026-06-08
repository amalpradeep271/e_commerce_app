import 'package:e_commerce_application/domain/coupon/entity/coupon_entity.dart';

class CouponModel extends CouponEntity {
  CouponModel({
    required super.id,
    required super.code,
    required super.discountType,
    required super.discountValue,
    required super.minOrderAmount,
    required super.discountAmount,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'] as String,
      code: json['code'] as String,
      discountType: json['discountType'] as String,
      discountValue: (json['discountValue'] as num).toDouble(),
      minOrderAmount: (json['minOrderAmount'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'discountType': discountType,
      'discountValue': discountValue,
      'minOrderAmount': minOrderAmount,
      'discountAmount': discountAmount,
    };
  }
}
