import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/order/model/add_to_cart_req_model.dart';
import 'package:e_commerce_application/data/order/model/order_registration_req_model.dart';

abstract class OrderRepository {
  Future<Either> addToCart(AddToCartReq addToCartReq);
  Future<Either> getCartProducts();
  Future<Either> removeCartProduct(String id);
  Future<Either> orderRegistration(OrderRegistrationReqModel order);
  Future<Either> getOrders();
}
