import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/domain/wishlist/repository/wishlist_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class GetWishlistUseCase implements UseCase<Either<String, List<ProductEntity>>, void> {
  @override
  Future<Either<String, List<ProductEntity>>> call({void params}) async {
    return await sl<WishlistRepository>().getWishlist();
  }
}