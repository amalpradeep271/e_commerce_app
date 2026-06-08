import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/mapping_helper.dart';
import 'package:e_commerce_application/data/review/model/add_review_req_model.dart';
import 'package:e_commerce_application/data/review/model/review_model.dart';
import 'package:e_commerce_application/data/review/source/review_api_services.dart';
import 'package:e_commerce_application/domain/review/entity/review_entity.dart';
import 'package:e_commerce_application/domain/review/repository/review_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class ReviewRepositoryImpl extends ReviewRepository {
  @override
  Future<Either<String, String>> addReview(AddReviewReqModel addReviewReqModel) async {
    final result = await sl<ReviewApiService>().addReview(addReviewReqModel);
    return result.fold(
      (error) => Left(error),
      (data) => Right(data as String),
    );
  }
  
  @override
  Future<Either<String, List<ReviewEntity>>> getAllReviews(String productId) async {
    final reviews = await sl<ReviewApiService>().getAllReviews(productId);
    return mapListResponse<ReviewEntity>(
      reviews,
      (e) => ReviewModel.fromMap(e).toEntity(),
    );
  }
}
