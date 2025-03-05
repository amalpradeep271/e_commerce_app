import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/domain/product/usecase/add_or_remove_favourite_product_usecase.dart';
import 'package:e_commerce_application/domain/product/usecase/is_favourite_usecase.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteIconCubit extends Cubit<bool> {
  FavoriteIconCubit() : super(false);

  void isFavorite(String productId) async {
    var result = await sl<IsFavoriteUseCase>().call(params: productId);
    if (!isClosed) emit(result);
  }

  void onTap(ProductEntity product) async {
    var result =
        await sl<AddOrRemoveFavoriteProductUseCase>().call(params: product);
    result.fold((error) {}, (data) {
      if (!isClosed) emit(data);
      print("Favorite button tapped. Updating wishlist...");

      if (!isClosed) {
        if (sl.isRegistered<ProductsDisplayCubit>()) {
          sl<ProductsDisplayCubit>().displayProducts(showLoading: false);
        }
      }
    });
  }
}
