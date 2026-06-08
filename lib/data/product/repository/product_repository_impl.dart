import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/mapping_helper.dart';
import 'package:e_commerce_application/data/product/model/product_model.dart';
import 'package:e_commerce_application/data/product/source/product_api_service.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/domain/product/repository/product_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class ProductRepositoryImpl extends ProductRepository {
  List<ProductEntity>? _cachedTopSelling;
  List<ProductEntity>? _cachedNewIn;
  final Map<String, List<ProductEntity>> _cachedCategoryProducts = {};

  @override
  void clearCache() {
    _cachedTopSelling = null;
    _cachedNewIn = null;
    _cachedCategoryProducts.clear();
  }

  @override
  Future<Either<String, List<ProductEntity>>> getTopSelling({dynamic params}) async {
    final hasPagination = params != null && (params['page'] != null || params['limit'] != null);
    if (!hasPagination && _cachedTopSelling != null) {
      return Right(_cachedTopSelling!);
    }
    final returnedData = await sl<ProductApiService>().getTopSelling(params: params);
    final result = mapListResponse<ProductEntity>(
      returnedData,
      (e) => ProductModel.fromMap(e).toEntity(),
    );
    if (!hasPagination) {
      result.fold(
        (error) => null,
        (data) => _cachedTopSelling = data,
      );
    }
    return result;
  }

  @override
  Future<Either<String, List<ProductEntity>>> getNewIn({dynamic params}) async {
    final hasPagination = params != null && (params['page'] != null || params['limit'] != null);
    if (!hasPagination && _cachedNewIn != null) {
      return Right(_cachedNewIn!);
    }
    final returnedData = await sl<ProductApiService>().getNewIn(params: params);
    final result = mapListResponse<ProductEntity>(
      returnedData,
      (e) => ProductModel.fromMap(e).toEntity(),
    );
    if (!hasPagination) {
      result.fold(
        (error) => null,
        (data) => _cachedNewIn = data,
      );
    }
    return result;
  }

  @override
  Future<Either<String, List<ProductEntity>>> getproductsbyCategoryId(String categoryId, {dynamic params}) async {
    final hasPagination = params != null && (params['page'] != null || params['limit'] != null);
    if (!hasPagination && _cachedCategoryProducts.containsKey(categoryId)) {
      return Right(_cachedCategoryProducts[categoryId]!);
    }
    final returnedData = await sl<ProductApiService>().getProductsByCategoryId(categoryId, params: params);
    final result = mapListResponse<ProductEntity>(
      returnedData,
      (e) => ProductModel.fromMap(e).toEntity(),
    );
    if (!hasPagination) {
      result.fold(
        (error) => null,
        (data) => _cachedCategoryProducts[categoryId] = data,
      );
    }
    return result;
  }

  @override
  Future<Either<String, List<ProductEntity>>> getProductsByTitle(String title) async {
    final returnedData = await sl<ProductApiService>().getProductsByTitle(title);
    return mapListResponse<ProductEntity>(
      returnedData,
      (e) => ProductModel.fromMap(e).toEntity(),
    );
  }

  @override
  Future<bool> isFavorite(String productId) async {
    return await sl<ProductApiService>().isFavorite(productId);
  }

  @override
  Future<Either<String, bool>> addOrRemoveFavoriteProduct(ProductEntity product) async {
    final returnedData = await sl<ProductApiService>().addOrRemoveFavoriteProduct(product);
    return returnedData.fold(
      (error) => Left(error),
      (data) => Right(data as bool),
    );
  }

  @override
  Future<Either<String, List<ProductEntity>>> getFavoritesProducts() async {
    final returnedData = await sl<ProductApiService>().getFavoritesProducts();
    return mapListResponse<ProductEntity>(
      returnedData,
      (e) => ProductModel.fromMap(e).toEntity(),
    );
  }
}
