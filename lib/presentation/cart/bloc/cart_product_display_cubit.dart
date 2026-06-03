import 'dart:developer';

import 'package:e_commerce_application/domain/cart/entity/product_ordered_entity.dart';
import 'package:e_commerce_application/domain/cart/usecase/get_cart_products_usecase.dart';
import 'package:e_commerce_application/domain/cart/usecase/remove_cart_products_usecase.dart';
import 'package:e_commerce_application/presentation/cart/bloc/cart_product_display_state.dart';
import 'package:e_commerce_application/presentation/cart/bloc/cart_status_cubit.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductsDisplayCubit extends Cubit<CartProductsDisplayState> {
  CartProductsDisplayCubit() : super(CartProductsLoading());

  void displayCartProducts() async {
    if (isClosed) return;
    var returnedData = await sl<GetCartProductsUseCase>().call();
    if (isClosed) return;
    returnedData.fold(
      (error) {
        if (!isClosed) emit(LoadCartProductsFailure(errorMessage: error));
      },
      (data) {
        if (!isClosed) emit(CartProductsLoaded(products: data));
      },
    );
  }

  Future<void> removeProduct(
      ProductOrderedEntity product, BuildContext context) async {
    log("🛑 Removing product: ${product.id}");

    if (isClosed) return;
    emit(CartProductsLoading());
    var returnedData =
        await sl<RemoveCartProductsUseCase>().call(params: product.id);
    if (isClosed) return;

    returnedData.fold((error) {
      log("❌ Failed to remove product: $error");
      if (!isClosed) emit(LoadCartProductsFailure(errorMessage: error));
    }, (data) {
      log("✅ Product removed successfully!");
      displayCartProducts();
      if (context.mounted) {
        context
            .read<CartStatusCubit>()
            .checkCartStatus(product.productId); // ✅ Refresh UI after removal
      }
    });
  }
}
