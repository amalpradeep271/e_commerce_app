import 'package:e_commerce_application/presentation/home/bloc/categories/categories_display_state.dart';
import 'package:e_commerce_application/domain/category/usecase/get_category_usecase.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesDisplayCubit extends Cubit<CategoriesDisplayState> {
  CategoriesDisplayCubit() : super(CategoriesLoading());

  void displayCategories() async {
    if (isClosed) return;

    var returnedData = await sl<GetCategoryUseCase>().call();
    if (isClosed) return;

    returnedData.fold(
      (error) {
        emit(CategoriesLoadFailure());
      },
      (data) {
        emit(CategoriesLoaded(categories: data));
      },
    );
  }
}
