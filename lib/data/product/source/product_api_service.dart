import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/api_client.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/service_locator.dart';

abstract class ProductApiService {
  Future<Either<String, dynamic>> getTopSelling({dynamic params});
  Future<Either<String, dynamic>> getNewIn({dynamic params});
  Future<Either<String, dynamic>> getProductsByCategoryId(String categoryId, {dynamic params});
  Future<Either<String, dynamic>> getProductsByTitle(String title);
  Future<bool> isFavorite(String productId);
  Future<Either<String, dynamic>> addOrRemoveFavoriteProduct(ProductEntity product);
  Future<Either<String, dynamic>> getFavoritesProducts();
}

class ProductApiServiceImpl extends ProductApiService {
  final ApiClient _apiClient = sl<ApiClient>();

  @override
  Future<Either<String, dynamic>> getTopSelling({dynamic params}) async {
    final page = params?['page'];
    final limit = params?['limit'];
    final pageQuery = page != null ? '&page=$page' : '';
    final limitQuery = limit != null ? '&limit=$limit' : '';
    final query = 'sort=top-selling$pageQuery$limitQuery';
    return _apiClient.getRequest('/products?$query');
  }

  @override
  Future<Either<String, dynamic>> getNewIn({dynamic params}) async {
    final page = params?['page'];
    final limit = params?['limit'];
    final pageQuery = page != null ? '&page=$page' : '';
    final limitQuery = limit != null ? '&limit=$limit' : '';
    final query = 'sort=new-in$pageQuery$limitQuery';
    return _apiClient.getRequest('/products?$query');
  }

  @override
  Future<Either<String, dynamic>> getProductsByCategoryId(String categoryId, {dynamic params}) async {
    final page = params?['page'];
    final limit = params?['limit'];
    final pageQuery = page != null ? '&page=$page' : '';
    final limitQuery = limit != null ? '&limit=$limit' : '';
    final query = 'categoryId=$categoryId$pageQuery$limitQuery';
    return _apiClient.getRequest('/products?$query');
  }

  @override
  Future<Either<String, dynamic>> getProductsByTitle(String title) async {
    return _apiClient.getRequest('/products?search=$title');
  }

  @override
  Future<bool> isFavorite(String productId) async {
    try {
      final response = await _apiClient.get('/products/$productId/is-favorite');
      if (response.statusCode == 200) {
        return response.body == 'true';
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<String, dynamic>> addOrRemoveFavoriteProduct(ProductEntity product) async {
    return _apiClient.postRequest('/products/${product.productId}/toggle-favorite', {});
  }

  @override
  Future<Either<String, dynamic>> getFavoritesProducts() async {
    return _apiClient.getRequest('/products/favorites');
  }
}
