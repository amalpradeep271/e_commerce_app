import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/cart/model/add_to_cart_req_model.dart';
import 'package:e_commerce_application/domain/cart/entity/product_ordered_entity.dart';

abstract class CartRepository {
  Future<Either<String, String>> addToCart(AddToCartReq addToCartReq);
  Future<Either<String, List<ProductOrderedEntity>>> getCartProducts();
  Future<Either<String, String>> removeCartProduct(String id);
  Future<Either<String, bool>> isProductInCart(String productId);
}
