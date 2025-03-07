import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/data/review/model/add_review_req_model.dart';

abstract class ReviewFirebaseService {
  Future<Either> addReview(AddReviewReqModel addReviewReqModel);
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
}
