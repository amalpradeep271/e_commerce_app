import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/domain/wishlist/usecase/get_wishlist_usecase.dart';
import 'package:e_commerce_application/domain/wishlist/usecase/toggle_wishlist_usecase.dart';
import 'package:e_commerce_application/presentation/wishlist/bloc/wishlist_state.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistLoading());

  void loadWishlist() async {
    if (isClosed) return;
    emit(WishlistLoading());
    var result = await sl<GetWishlistUseCase>().call();
    if (isClosed) return;
    result.fold(
      (error) => emit(WishlistError(error)),
      (data) => emit(WishlistLoaded(data)),
    );
  }

  void toggleWishlist(ProductEntity product) async {
    if (isClosed) return;
    var result = await sl<ToggleWishlistUseCase>().call(params: product);
    if (isClosed) return;
    result.fold(
      (error) => emit(WishlistError(error)),
      (_) => loadWishlist(),
    );
  }
}
