import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:e_commerce_application/common/bloc/product/product_display_state.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/core/configs/assets/app_gifs.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/presentation/wishlist/widgets/wishlist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Favorites',
      ),
      body: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductsLoaded) {
            return state.products.isEmpty
                ? Center(child: _wishlistIsEmpty())
                : _products(state.products);
          }
          if (state is LoadProductsFailure) {
            return const Center(
              child: Text('Please try again'),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _wishlistIsEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 100.h,
          width: 100.w,
          child: Image.asset(AppGifs.wishlistEmpty),
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          "Wishlist is empty",
          textAlign: TextAlign.center,
          style: AppTextStyles.base.w600.s20,
        )
      ],
    );
  }

  Widget _products(List<ProductEntity> products) {
    return ListView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext context, int index) {
        return WishlistCard(
          productEntity: products[index],
        );
      },
    );
  }
}
