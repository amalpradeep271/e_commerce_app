import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/cart/entity/product_ordered_entity.dart';
import 'package:e_commerce_application/domain/cart/repository/cart_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class GetCartProductsUseCase implements UseCase<Either<String, List<ProductOrderedEntity>>, dynamic> {
  @override
  Future<Either<String, List<ProductOrderedEntity>>> call({dynamic params}) async {
    return sl<CartRepository>().getCartProducts();
  }
}