import 'package:e_commerce_application/domain/cart/usecase/is_product_in_cart_usecase.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartStatusCubit extends Cubit<bool> {
  CartStatusCubit() : super(false);

  void checkCartStatus(String productId) async {
    var result = await sl<IsProductInCartUsecase>().call(params: productId);
    result.fold((error) {
      emit(false);
    }, (isInCart) {
      emit(isInCart);
    });
  }

  void markAsAdded() {
    emit(true);
  }

  void markAsRemoved() {
    emit(false);
  }
}
