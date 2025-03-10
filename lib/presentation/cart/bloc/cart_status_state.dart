abstract class CartStatusState {}

class CartInitial extends CartStatusState {}

class CartLoading extends CartStatusState {}

class ProductInCartState extends CartStatusState {}

class ProductNotInCartState extends CartStatusState {}

class ProductAddedToCartState extends CartStatusState {}

class ProductRemovedFromCartState extends CartStatusState {}

class CartError extends CartStatusState {
  final String message;
  CartError(this.message);
}
