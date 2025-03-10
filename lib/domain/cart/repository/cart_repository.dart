import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/cart/model/add_to_cart_req_model.dart';

abstract class CartRepository {
  Future<Either> addToCart(AddToCartReq addToCartReq);
  Future<Either> getCartProducts();
  Future<Either> removeCartProduct(String id);
  Future<Either> isProductInCart(String productId);
}
