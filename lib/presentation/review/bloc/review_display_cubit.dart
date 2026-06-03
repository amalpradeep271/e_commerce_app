import 'package:e_commerce_application/domain/review/usecase/get_review_usecase.dart';
import 'package:e_commerce_application/presentation/review/bloc/review_display_state.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsDisplayCubit extends Cubit<ReviewsDisplayState> {
  ReviewsDisplayCubit() : super(ReviewsLoading());

  void displayReviews(dynamic params) async {
    if (isClosed) return;
    var returnedData = await sl<GetReviewsUsecase>().call(params: params);
    if (isClosed) return;
    returnedData.fold(
      (error) {
        if (!isClosed) emit(ReviewsLoadFailure());
      },
      (data) {
        if (!isClosed) emit(ReviewsLoaded(reviews: data));
      },
    );
  }
}
