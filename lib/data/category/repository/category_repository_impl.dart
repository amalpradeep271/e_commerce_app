import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/category/model/category_model.dart';
import 'package:e_commerce_application/data/category/source/category_firebase_service.dart';
import 'package:e_commerce_application/domain/category/repository/category_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  @override
  Future<Either> getCategories() async {
    var categories = await sl<CategoryFireBaseService>().getCategories();
    return categories.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(
          List.from(data).map(
            (e) => CategoryModel.fromMap(e).toEntity(),
          ).toList(),
        );
      },
    );
  }
}
