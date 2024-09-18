import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';

abstract class ProductRepository {
  Future<Either> getTopSelling();
  Future<Either> getNewIn();
  Future<Either> getproductsbyCategoryId(String categoryId);
  Future<Either> getProductsByTitle(String title);
  Future<bool> isFavorite(String productId);
  Future<Either> addOrRemoveFavoriteProduct(ProductEntity product);
  Future<Either> getFavoritesProducts();

}
