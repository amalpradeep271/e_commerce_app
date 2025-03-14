import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/product/model/product_model.dart';
import 'package:e_commerce_application/data/wishlist/source/wishlist_firebase_service.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/domain/wishlist/repository/wishlist_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class WishlistRepositoryImpl extends WishlistRepository {
  final WishlistFireBaseService service = sl<WishlistFireBaseService>();

  @override
  Future<Either<String, List<ProductEntity>>> getWishlist() async {
    var result = await service.getWishlist();
    return result.fold(
      (error) => Left(error),
      (data) => Right(data
          .where((e) => e['productId'] != null) // Ensure productId exists
          .map((e) => ProductModel.fromMap(e).toEntity())
          .toList()),
    );
  }

  @override
  Future<Either<String, void>> toggleWishlist(ProductEntity product) async {
    return await service.toggleWishlist(product.productId);
  }
}
 