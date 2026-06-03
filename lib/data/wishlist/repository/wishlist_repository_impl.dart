import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/product/model/product_model.dart';
import 'package:e_commerce_application/data/wishlist/source/wishlist_api_service.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/domain/wishlist/repository/wishlist_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class WishlistRepositoryImpl extends WishlistRepository {
  final WishlistApiService service = sl<WishlistApiService>();

  @override
  Future<Either<String, List<ProductEntity>>> getWishlist() async {
    final result = await service.getWishlist();
    return result.fold(
      (error) => Left(error),
      (data) {
        try {
          final list = List.from(data)
              .where((e) => e['productId'] != null)
              .map((e) => ProductModel.fromMap(Map<String, dynamic>.from(e)).toEntity())
              .toList();
          return Right(list);
        } catch (e) {
          return Left('Parsing error: ${e.toString()}');
        }
      },
    );
  }

  @override
  Future<Either<String, void>> toggleWishlist(ProductEntity product) async {
    final result = await service.toggleWishlist(product.productId);
    return result.fold(
      (error) => Left(error),
      (_) => const Right(null),
    );
  }
}