import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/network/api_client.dart';
import 'package:e_commerce_application/data/review/model/add_review_req_model.dart';
import 'package:e_commerce_application/service_locator.dart';

abstract class ReviewApiService {
  Future<Either<String, dynamic>> addReview(AddReviewReqModel addReviewReqModel);
  Future<Either<String, dynamic>> getAllReviews(String productId);
}

class ReviewApiServiceImpl extends ReviewApiService {
  final ApiClient _apiClient = sl<ApiClient>();

  @override
  Future<Either<String, dynamic>> addReview(AddReviewReqModel addReviewReqModel) async {
    return _apiClient.postRequest('/reviews', addReviewReqModel.toMap());
  }

  @override
  Future<Either<String, dynamic>> getAllReviews(String productId) async {
    return _apiClient.getRequest('/reviews/$productId');
  }
}
