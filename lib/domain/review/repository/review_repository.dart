import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/review/model/add_review_req_model.dart';
import 'package:e_commerce_application/domain/review/entity/review_entity.dart';

abstract class ReviewRepository {
  Future<Either<String, String>> addReview(AddReviewReqModel addReviewReqModel);
  Future<Either<String, List<ReviewEntity>>> getAllReviews(String productId);
}
