import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/domain/product/repository/product_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class GetNewInUseCase implements UseCase<Either<String, List<ProductEntity>>, dynamic> {
  @override
  Future<Either<String, List<ProductEntity>>> call({dynamic params}) async {
    return await sl<ProductRepository>().getNewIn(params: params);
  }
}
