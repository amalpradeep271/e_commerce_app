import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/domain/product/repository/product_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class GetProductsByTitleUseCase implements UseCase<Either<String, List<ProductEntity>>, String> {
  @override
  Future<Either<String, List<ProductEntity>>> call({String? params}) async {
    return await sl<ProductRepository>().getProductsByTitle(params!);
  }
}
