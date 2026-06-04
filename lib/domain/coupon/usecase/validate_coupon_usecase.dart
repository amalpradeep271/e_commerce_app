import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/coupon/entity/coupon_entity.dart';
import 'package:e_commerce_application/domain/coupon/repository/coupon_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class ValidateCouponParams {
  final String code;
  final double orderAmount;
  ValidateCouponParams({required this.code, required this.orderAmount});
}

class ValidateCouponUseCase extends UseCase<Either<String, CouponEntity>, ValidateCouponParams> {
  @override
  Future<Either<String, CouponEntity>> call({ValidateCouponParams? params}) async {
    return await sl<CouponRepository>().validateCoupon(params!.code, params.orderAmount);
  }
}
