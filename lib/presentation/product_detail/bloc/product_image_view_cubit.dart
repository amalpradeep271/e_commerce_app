import 'package:flutter_bloc/flutter_bloc.dart';

class ProductImageViewCubit extends Cubit<int> {
  ProductImageViewCubit() : super(0); // Initial selected image index

  void selectImage(int index) {
    emit(index);
  }
}
