import 'package:flutter_bloc/flutter_bloc.dart';

class RatingCubit extends Cubit<double> {
  RatingCubit() : super(0); // Initial rating

  void changeRating(double newRating) {
    emit(newRating);
  }
}
