import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/data/cart/model/add_to_cart_req_model.dart';
import 'package:e_commerce_application/domain/cart/repository/cart_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class AddToCartUseCase implements UseCase<Either, AddToCartReq> {
  @override
  Future<Either> call({AddToCartReq? params}) async {
    return await sl<CartRepository>().addToCart(params!);
  }
}
