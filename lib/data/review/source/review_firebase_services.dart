import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/review/model/add_review_req_model.dart';

abstract class ReviewFirebaseService {
  Future<Either> addReview(AddReviewReqModel addReviewReqModel);
  Future<Either> getAllReviews();
}

class ReviewFirebaseServiceImpl extends ReviewFirebaseService {
  @override
  Future<Either> addReview(AddReviewReqModel addReviewReqModel) async {
    try {
      await FirebaseFirestore.instance.collection('Reviews').add(
            addReviewReqModel.toMap(),
          );
      return const Right('Review Added successfully');
    } catch (e) {
      return const Left('Please try again.');
    }
  }

  @override
  Future<Either> getAllReviews() async {
    try {
      var reviews =
          await FirebaseFirestore.instance.collection('Reviews').get();
      return Right(reviews.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left('Please try again.');
    }
  }
}
