import 'package:e_commerce_application/domain/product/entity/product_entity.dart';

abstract class WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<ProductEntity> wishlistedItems;
  WishlistLoaded(this.wishlistedItems);
}

class WishlistError extends WishlistState {
  final String message;
  WishlistError(this.message);
}
