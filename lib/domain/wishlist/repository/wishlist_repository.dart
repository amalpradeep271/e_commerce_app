import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';

abstract class WishlistRepository {
  Future<Either<String, List<ProductEntity>>> getWishlist();
  Future<Either<String, void>> toggleWishlist(ProductEntity product);
}