import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/review/model/add_review_req_model.dart';
import 'package:e_commerce_application/data/review/model/review_model.dart';
import 'package:e_commerce_application/data/review/source/review_firebase_services.dart';
import 'package:e_commerce_application/domain/review/repository/review_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class ReviewRepositoryImpl extends ReviewRepository {
  @override
  Future<Either> addReview(AddReviewReqModel addReviewReqModel) async {
    return await sl<ReviewFirebaseService>().addReview(addReviewReqModel);
  }
  
  @override
  Future<Either> getAllReviews(String productId) async{
  var reviews = await sl<ReviewFirebaseService>().getAllReviews(productId);
    return reviews.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(
          List.from(data).map(
            (e) => ReviewModel.fromMap(e).toEntity(),
          ).toList(),
        );
      },
    );
  }
}
