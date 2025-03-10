import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/review/model/add_review_req_model.dart';

abstract class ReviewRepository {
  Future<Either> addReview(AddReviewReqModel addReviewReqModel);
  Future<Either> getAllReviews();
}
