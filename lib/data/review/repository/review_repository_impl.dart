import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/review/model/add_review_req_model.dart';
import 'package:e_commerce_application/data/review/source/review_firebase_service.dart';
import 'package:e_commerce_application/domain/review/repository/review_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class ReviewRepositoryImpl extends ReviewRepository {
  @override
  Future<Either> addReview(AddReviewReqModel addReviewReqModel) async {
    return await sl<ReviewFirebaseService>().addReview(addReviewReqModel);
  }
}
