import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/api_client.dart';
import 'package:e_commerce_application/service_locator.dart';

abstract class WishlistApiService {
  Future<Either<String, dynamic>> getWishlist();
  Future<Either<String, dynamic>> toggleWishlist(String productId);
}

class WishlistApiServiceImpl extends WishlistApiService {
  final ApiClient _apiClient = sl<ApiClient>();

  @override
  Future<Either<String, dynamic>> getWishlist() async {
    return _apiClient.getRequest('/wishlist');
  }

  @override
  Future<Either<String, dynamic>> toggleWishlist(String productId) async {
    return _apiClient.postRequest('/wishlist/toggle/$productId', {});
  }
}
