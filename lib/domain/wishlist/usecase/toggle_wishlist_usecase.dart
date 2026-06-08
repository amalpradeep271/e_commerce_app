import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/domain/wishlist/repository/wishlist_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class ToggleWishlistUseCase
    implements UseCase<Either<String, void>, ProductEntity> {
  @override
  Future<Either<String, void>> call({ProductEntity? params}) async {
    if (params == null) return const Left('Invalid product');
    return await sl<WishlistRepository>().toggleWishlist(params);
  }
}
