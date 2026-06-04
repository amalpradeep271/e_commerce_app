import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/api_client.dart';
import 'package:e_commerce_application/service_locator.dart';

abstract class CouponApiService {
  Future<Either<String, dynamic>> validateCoupon(String code, double orderAmount);
}

class CouponApiServiceImpl extends CouponApiService {
  final ApiClient _apiClient = sl<ApiClient>();

  @override
  Future<Either<String, dynamic>> validateCoupon(String code, double orderAmount) async {
    return _apiClient.postRequest('/coupons/validate', {
      'code': code,
      'orderAmount': orderAmount,
    });
  }
}
