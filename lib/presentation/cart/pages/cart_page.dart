import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_state.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/common/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:e_commerce_application/core/configs/assets/app_gifs.dart';
import 'package:e_commerce_application/domain/cart/entity/product_ordered_entity.dart';
import 'package:e_commerce_application/presentation/cart/bloc/cart_product_display_cubit.dart';
import 'package:e_commerce_application/presentation/cart/bloc/cart_product_display_state.dart';
import 'package:e_commerce_application/presentation/cart/bloc/cart_status_cubit.dart';
import 'package:e_commerce_application/presentation/cart/bloc/payment_cubit.dart';
import 'package:e_commerce_application/presentation/cart/widgets/checkout.dart';
import 'package:e_commerce_application/presentation/cart/widgets/product_ordered_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_application/common/widgets/please_try_again/please_try_again_widget.dart';
import 'package:e_commerce_application/common/widgets/empty/empty_state_widget.dart';
import 'package:shimmer/shimmer.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CartProductsDisplayCubit()..displayCartProducts(),
        ),
        BlocProvider(create: (context) => CartStatusCubit()),
        BlocProvider(
          create: (context) => PaymentCubit(),
        ),
      ],
      child: BlocBuilder<ConnectivityCubit, ConnectivityState>(
        builder: (context, state) {
          if (state is ConnectivityDisconnected) {
            return const NoInternetScreen();
          }
          
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final bgColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF3F4F6);
          
          return Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: BlocBuilder<CartProductsDisplayCubit, CartProductsDisplayState>(
                builder: (context, cartState) {
                  int itemCount = 0;
                  if (cartState is CartProductsLoaded) {
                    itemCount = cartState.products.length;
                  }
                  return Column(
                    children: [
                      Text(
                        'My Cart',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        '$itemCount items',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  );
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.shopping_bag_outlined, color: isDark ? Colors.white : Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
            body: Builder(
              builder: (context) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<CartProductsDisplayCubit>().displayCartProducts();
                  },
                  child: BlocBuilder<CartProductsDisplayCubit, CartProductsDisplayState>(
                    builder: (context, state) {
                      if (state is CartProductsLoading) {
                        return _buildSkeletonLoader(context);
                      }
                      if (state is CartProductsLoaded) {
                        return state.products.isEmpty
                            ? SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.7,
                                  child: EmptyStateWidget(
                                    title: "Cart is empty",
                                    subtitle: "Add items to your cart to check out.",
                                    icon: Image.asset(
                                      AppGifs.cartEmpty,
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                                    onRefresh: () {
                                      context.read<CartProductsDisplayCubit>().displayCartProducts();
                                    },
                                  ),
                                ),
                              )
                            : Stack(
                                children: [
                                  _products(state.products, context),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Checkout(
                                      products: state.products,
                                    ),
                                  )
                                ],
                              );
                      }
                      if (state is LoadCartProductsFailure) {
                        return SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: PleaseTryAgainWidget(
                              errorMessage: state.errorMessage,
                              onRetry: () {
                                context.read<CartProductsDisplayCubit>().displayCartProducts();
                              },
                              isFullScreen: false,
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                );
              }
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkeletonLoader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade700 : Colors.grey.shade100;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final borderColor = isDark ? const Color(0xFF334155) : Colors.grey.shade200;

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      itemCount: 4,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: borderColor),
          ),
          child: Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 65.w,
                  height: 65.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 14.h, width: double.infinity, color: Colors.white),
                      SizedBox(height: 8.h),
                      Container(height: 10.h, width: 100.w, color: Colors.white),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(height: 26.h, width: 80.w, color: Colors.white),
                          Container(height: 14.h, width: 50.w, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _products(
      List<ProductOrderedEntity> products, BuildContext parentContext) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      itemBuilder: (context, index) {
        return ProductOrderedCard(
          productOrderedEntity: products[index],
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 10.h,
      ),
      itemCount: products.length,
    );
  }
}
