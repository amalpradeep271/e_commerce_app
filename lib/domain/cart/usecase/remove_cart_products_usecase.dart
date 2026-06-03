import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/cart/repository/cart_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class RemoveCartProductsUseCase implements UseCase<Either<String, String>, String> {
  @override
  Future<Either<String, String>> call({String? params}) async {
    return sl<CartRepository>().removeCartProduct(params!);
  }
}
