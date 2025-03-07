import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/data/review/model/add_review_req_model.dart';
import 'package:e_commerce_application/domain/review/repository/review_repository.dart';

import '../../../service_locator.dart';

class AddReviewUseCase implements UseCase<Either, AddReviewReqModel> {
  @override
  Future<Either> call({AddReviewReqModel? params}) async {
    return await sl<ReviewRepository>().addReview(params!);
  }
}
