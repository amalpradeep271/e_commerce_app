import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/mapping_helper.dart';
import 'package:e_commerce_application/data/category/model/category_model.dart';
import 'package:e_commerce_application/data/category/source/category_api_service.dart';
import 'package:e_commerce_application/domain/category/entity/category_entity.dart';
import 'package:e_commerce_application/domain/category/repository/category_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  List<CategoryEntity>? _cachedCategories;

  @override
  void clearCache() {
    _cachedCategories = null;
  }

  @override
  Future<Either<String, List<CategoryEntity>>> getCategories() async {
    if (_cachedCategories != null) {
      return Right(_cachedCategories!);
    }
    var categories = await sl<CategoryApiService>().getCategories();
    var result = mapListResponse<CategoryEntity>(
      categories,
      (e) => CategoryModel.fromMap(e).toEntity(),
    );
    result.fold(
      (error) => null,
      (data) => _cachedCategories = data,
    );
    return result;
  }
}
