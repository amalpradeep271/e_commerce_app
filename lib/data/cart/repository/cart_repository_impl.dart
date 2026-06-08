import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/mapping_helper.dart';
import 'package:e_commerce_application/data/cart/model/add_to_cart_req_model.dart';
import 'package:e_commerce_application/data/cart/model/product_ordered_model.dart';
import 'package:e_commerce_application/data/cart/source/cart_api_services.dart';
import 'package:e_commerce_application/domain/cart/entity/product_ordered_entity.dart';
import 'package:e_commerce_application/domain/cart/repository/cart_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class CartRepositoryImpl extends CartRepository {
  @override
  Future<Either<String, String>> addToCart(AddToCartReq addToCartReq) async {
    final result = await sl<CartApiService>().addToCart(addToCartReq);
    return result.fold(
      (error) => Left(error),
      (message) => Right(message as String),
    );
  }

  @override
  Future<Either<String, List<ProductOrderedEntity>>> getCartProducts() async {
    final returnedData = await sl<CartApiService>().getCartProducts();
    return mapListResponse<ProductOrderedEntity>(
      returnedData,
      (e) => ProductOrderedModel.fromMap(e).toEntity(),
    );
  }

  @override
  Future<Either<String, String>> removeCartProduct(String id) async {
    final returnedData = await sl<CartApiService>().removeCartProduct(id);
    return returnedData.fold(
      (error) => Left(error),
      (message) => Right(message as String),
    );
  }

  @override
  Future<Either<String, bool>> isProductInCart(String productId) async {
    final result = await sl<CartApiService>().isProductInCart(productId);
    return result.fold(
      (error) => Left(error),
      (data) => Right(data as bool),
    );
  }
}
