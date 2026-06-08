import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/domain/coupon/entity/coupon_entity.dart';

abstract class CouponRepository {
  Future<Either<String, CouponEntity>> validateCoupon(String code, double orderAmount);
}
