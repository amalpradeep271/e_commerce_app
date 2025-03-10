import 'package:dartz/dartz.dart';
import 'package:e_commerce_application/domain/cart/usecase/is_product_in_cart_usecase.dart';
import 'package:e_commerce_application/presentation/cart/bloc/cart_status_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartStatusCubit extends Cubit<CartStatusState> {
  final IsProductInCartUsecase isProductInCartUsecase;

  CartStatusCubit({required this.isProductInCartUsecase}) : super(CartInitial());

  Future<void> checkCartStatus(String productId) async {
    emit(CartLoading()); // Optional: Show loading state if needed

    final Either<dynamic, bool> result = await isProductInCartUsecase.call(params: productId);

    result.fold(
      (failure) => emit(CartError("Error checking cart status")),
      (isInCart) {
        if (isInCart) {
          emit(ProductInCartState());
        } else {
          emit(ProductNotInCartState());
        }
      },
    );
  }

  void markAsAdded() {
    emit(ProductAddedToCartState());
  }

  void markAsRemoved() {
    emit(ProductRemovedFromCartState());
  }
}
