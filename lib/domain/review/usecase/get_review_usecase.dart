import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/review/repository/review_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class GetReviewsUsecase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async {
    return await sl<ReviewRepository>().getAllReviews();
  }
}
