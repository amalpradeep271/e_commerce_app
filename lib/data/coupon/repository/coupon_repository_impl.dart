import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/coupon/models/coupon_model.dart';
import 'package:e_commerce_application/data/coupon/source/coupon_api_service.dart';
import 'package:e_commerce_application/domain/coupon/entity/coupon_entity.dart';
import 'package:e_commerce_application/domain/coupon/repository/coupon_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class CouponRepositoryImpl extends CouponRepository {
  final CouponApiService _couponApiService = sl<CouponApiService>();

  @override
  Future<Either<String, CouponEntity>> validateCoupon(String code, double orderAmount) async {
    final response = await _couponApiService.validateCoupon(code, orderAmount);
    return response.fold(
      (error) => Left(error),
      (data) {
        try {
          final model = CouponModel.fromJson(data as Map<String, dynamic>);
          return Right(model);
        } catch (e) {
          return Left(e.toString());
        }
      },
    );
  }
}
