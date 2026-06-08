import 'package:e_commerce_application/domain/cart/usecase/is_product_in_cart_usecase.dart';
 import 'package:e_commerce_application/service_locator.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
 
 class CartStatusCubit extends Cubit<bool> {
   CartStatusCubit() : super(false);
 
   void checkCartStatus(String productId) async {
     if (isClosed) return;
     var result = await sl<IsProductInCartUsecase>().call(params: productId);
     if (isClosed) return;
     result.fold((error) {
       if (!isClosed) emit(false);
     }, (isInCart) {
       if (!isClosed) emit(isInCart);
     });
   }
 
   void markAsAdded() {
     emit(true);
   }
 
   void markAsRemoved() {
     emit(false);
   }
 }