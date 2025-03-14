import 'dart:developer';
import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/core/configs/assets/app_gifs.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/category/usecase/get_category_usecase.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/domain/product/usecase/get_newin_usecase.dart';
import 'package:e_commerce_application/domain/product/usecase/get_topselling_usecase.dart';
import 'package:e_commerce_application/presentation/wishlist/bloc/wishlist_cubit.dart';
import 'package:e_commerce_application/presentation/wishlist/bloc/wishlist_state.dart';
import 'package:e_commerce_application/presentation/wishlist/widgets/wishlist_card.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WishlistCubit()..loadWishlist(),
        ),
        BlocProvider(
          create: (context) =>
              ProductsDisplayCubit(useCase: sl<GetTopSellingUseCase>())
                ..displayProducts(),
        ),
        BlocProvider(
          create: (context) =>
              ProductsDisplayCubit(useCase: sl<GetNewInUseCase>())
                ..displayProducts(),
        ),
        BlocProvider(
          create: (context) =>
              ProductsDisplayCubit(useCase: sl<GetCategoryUseCase>())
                ..displayProducts(),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'My Favorites',
        ),
        body: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            log("WishlistPage BlocBuilder is rebuilding!"); // Add this line

            if (state is WishlistLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state is WishlistLoaded) {
              return state.wishlistedItems.isEmpty
                  ? Center(
                      child: _wishlistIsEmpty(),
                    )
                  : _products(state.wishlistedItems);
            }
            if (state is WishlistError) {
              return const Center(
                child: Text('Please try again'),
              );
            }
            return Container();
          },
        ),
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
