import 'package:dartz/dartz.dart';

import 'package:e_commerce_application/domain/category/entity/category_entity.dart';

abstract class CategoryRepository {
  Future<Either<String, List<CategoryEntity>>> getCategories();
  void clearCache();
}