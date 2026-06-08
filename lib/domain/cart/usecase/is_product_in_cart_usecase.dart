import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/cart/repository/cart_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class IsProductInCartUsecase implements UseCase<Either<String, bool>, String> {
  @override
  Future<Either<String, bool>> call({String? params}) async {
    return sl<CartRepository>().isProductInCart(params!);
  }
}