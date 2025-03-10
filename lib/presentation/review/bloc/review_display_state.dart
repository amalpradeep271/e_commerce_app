import 'package:e_commerce_application/domain/review/entity/review_entity.dart';

abstract class ReviewsDisplayState {}

class ReviewsLoading extends ReviewsDisplayState {}

class ReviewsLoaded extends ReviewsDisplayState {
  final List<ReviewEntity> reviews;

  ReviewsLoaded({required this.reviews});
}

class ReviewsLoadFailure extends ReviewsDisplayState {}
