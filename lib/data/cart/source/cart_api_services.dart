import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/api_client.dart';
import 'package:e_commerce_application/data/cart/model/add_to_cart_req_model.dart';
import 'package:e_commerce_application/service_locator.dart';

abstract class CartApiService {
  Future<Either<String, dynamic>> addToCart(AddToCartReq addToCartReq);
  Future<Either<String, dynamic>> getCartProducts();
  Future<Either<String, dynamic>> removeCartProduct(String id);
  Future<Either<String, dynamic>> isProductInCart(String productId);
}

class CartApiServiceImpl extends CartApiService {
  final ApiClient _apiClient = sl<ApiClient>();

  @override
  Future<Either<String, dynamic>> addToCart(AddToCartReq addToCartReq) async {
    return _apiClient.postRequest('/cart', addToCartReq.toMap());
  }

  @override
  Future<Either<String, dynamic>> getCartProducts() async {
    return _apiClient.getRequest('/cart');
  }

  @override
  Future<Either<String, dynamic>> removeCartProduct(String id) async {
    return _apiClient.deleteRequest('/cart/$id');
  }

  @override
  Future<Either<String, dynamic>> isProductInCart(String productId) async {
    return _apiClient.getRequest('/cart/check/$productId');
  }
}
