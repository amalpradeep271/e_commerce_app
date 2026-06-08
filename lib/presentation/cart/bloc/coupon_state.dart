import 'package:e_commerce_application/domain/coupon/entity/coupon_entity.dart';

abstract class CouponState {}

class CouponInitial extends CouponState {}

class CouponLoading extends CouponState {}

class CouponValidationSuccess extends CouponState {
  final CouponEntity coupon;
  CouponValidationSuccess({required this.coupon});
}

class CouponValidationFailure extends CouponState {
  final String errorMessage;
  CouponValidationFailure({required this.errorMessage});
}
