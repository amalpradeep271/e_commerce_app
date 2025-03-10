import 'package:e_commerce_application/domain/cart/entity/product_ordered_entity.dart';
import 'package:e_commerce_application/domain/cart/usecase/get_cart_products_usecase.dart';
import 'package:e_commerce_application/domain/cart/usecase/remove_cart_products_usecase.dart';
import 'package:e_commerce_application/presentation/cart/bloc/cart_product_display_state.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductsDisplayCubit extends Cubit<CartProductsDisplayState> {
  CartProductsDisplayCubit() : super(CartProductsLoading());

  void displayCartProducts() async {
    var returnedData = await sl<GetCartProductsUseCase>().call();
    returnedData.fold(
      (error) {
        emit(LoadCartProductsFailure(errorMessage: error));
      },
      (data) {
        emit(CartProductsLoaded(products: data));
      },
    );
  }

  Future<void> removeProduct(ProductOrderedEntity product) async {
    emit(CartProductsLoading());
    var returnedData =
        await sl<RemoveCartProductsUseCase>().call(params: product.id);

    returnedData.fold((error) {
      emit(LoadCartProductsFailure(errorMessage: error));
    }, (data) {
      displayCartProducts();
    });
  }
}
