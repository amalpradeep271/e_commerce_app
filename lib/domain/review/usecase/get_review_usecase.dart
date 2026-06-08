import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/review/entity/review_entity.dart';
import 'package:e_commerce_application/domain/review/repository/review_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class GetReviewsUsecase implements UseCase<Either<String, List<ReviewEntity>>, String> {
  @override
  Future<Either<String, List<ReviewEntity>>> call({String? params}) async {
    return await sl<ReviewRepository>().getAllReviews(params!);
  }
}
