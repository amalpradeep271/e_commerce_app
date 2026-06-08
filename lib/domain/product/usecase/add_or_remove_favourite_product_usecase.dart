import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/domain/product/repository/product_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class AddOrRemoveFavoriteProductUseCase implements UseCase<Either<String, bool>, ProductEntity> {
  @override
  Future<Either<String, bool>> call({ProductEntity? params}) async {
    return await sl<ProductRepository>().addOrRemoveFavoriteProduct(params!);
  }
}