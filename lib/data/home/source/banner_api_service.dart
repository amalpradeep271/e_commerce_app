import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/api_client.dart';
import 'package:e_commerce_application/service_locator.dart';

abstract class BannerApiService {
  Future<Either<String, dynamic>> getBanners();
}

class BannerApiServiceImpl extends BannerApiService {
  final ApiClient _apiClient = sl<ApiClient>();

  @override
  Future<Either<String, dynamic>> getBanners() async {
    return _apiClient.getRequest('/banners');
  }
}
