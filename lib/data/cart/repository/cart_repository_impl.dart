import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/cart/model/add_to_cart_req_model.dart';
import 'package:e_commerce_application/data/cart/model/product_ordered_model.dart';
import 'package:e_commerce_application/data/cart/source/cart_firebase_services.dart';
import 'package:e_commerce_application/domain/cart/repository/cart_repository.dart';

import '../../../service_locator.dart';

class CartRepositoryImpl extends CartRepository {
  @override
  Future<Either> addToCart(AddToCartReq addToCartReq) async {
    return await sl<CartFirebaseServices>().addToCart(addToCartReq);
  }

  @override
  Future<Either> getCartProducts() async {
    var returnedData = await sl<CartFirebaseServices>().getCartProducts();
    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      return Right(List.from(data)
          .map((e) => ProductOrderedModel.fromMap(e).toEntity())
          .toList());
    });
  }

  @override
  Future<Either> removeCartProduct(String id) async {
    var returnedData = await sl<CartFirebaseServices>().removeCartProduct(id);
    return returnedData.fold((error) {
      return Left(error);
    }, (message) {
      return Right(message);
    });
  }
}
