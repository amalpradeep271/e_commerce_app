import 'dart:developer';

import 'package:e_commerce_application/domain/cart/usecase/is_product_in_cart_usecase.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartStatusCubit extends Cubit<bool> {
  CartStatusCubit() : super(false);

  void checkCartStatus(String productId) async {
    print("🔍 Checking cart status for productId: $productId");

    var result = await sl<IsProductInCartUsecase>().call(params: productId);

    result.fold(
      (error) {
        print("❌ Cart check failed: $error");
        emit(false);
      },
      (isInCart) {
        print("✅ Cart check result: $isInCart");

        emit(isInCart);
      },
    );
  }

  void markAsAdded() {
    log("🛒 Marking product as added to cart");

    emit(true);
  }

  void markAsRemoved() {
    log("🗑️ Marking product as removed from cart");

    emit(false);
  }
}
