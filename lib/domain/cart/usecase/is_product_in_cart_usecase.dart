import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/cart/repository/cart_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class IsProductInCartUsecase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) {
    return sl<CartRepository>().isProductInCart(params!);
  }
}
