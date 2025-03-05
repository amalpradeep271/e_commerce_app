import 'dart:developer';

import 'package:e_commerce_application/common/bloc/product/product_display_state.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsDisplayCubit extends Cubit<ProductsDisplayState> {
  final UseCase useCase;
  ProductsDisplayCubit({required this.useCase}) : super(ProductsInitialState());

  void displayProducts({dynamic params, bool showLoading = true}) async {
    log("Fetching updated favorite products...");
    if (showLoading) {
      emit(ProductsLoading());
    }
    var returnedData = await useCase.call(params: params);
    returnedData.fold((error) {
      log("Error fetching favorite products");

      emit(LoadProductsFailure());
    }, (data) {
      log("Favorites updated: ${data.length} products found");

      emit(ProductsLoaded(products: data));
    });
  }

  void displayInitial() {
    emit(ProductsInitialState());
  }
}
