import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit() : super(0);

  void changeTabIndex(int index, BuildContext context) {
    emit(index);
    if (index == 1) {
      print("Switched to Wishlist - Refreshing products");
      context.read<ProductsDisplayCubit>().displayProducts(showLoading: false);
    }
  }
}
