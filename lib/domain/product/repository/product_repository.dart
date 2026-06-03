import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';

abstract class ProductRepository {
  Future<Either<String, List<ProductEntity>>> getTopSelling({dynamic params});
  Future<Either<String, List<ProductEntity>>> getNewIn({dynamic params});
  Future<Either<String, List<ProductEntity>>> getproductsbyCategoryId(String categoryId, {dynamic params});
  Future<Either<String, List<ProductEntity>>> getProductsByTitle(String title);
  Future<bool> isFavorite(String productId);
  Future<Either<String, bool>> addOrRemoveFavoriteProduct(ProductEntity product);
  Future<Either<String, List<ProductEntity>>> getFavoritesProducts();
  void clearCache();
}
