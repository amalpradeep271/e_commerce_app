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

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectivityDisconnected) {
          return const NoInternetScreen();
        }
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Cart',
          ),
          body: MultiBlocProvider(
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
            child: Builder(
              builder: (context) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<CartProductsDisplayCubit>().displayCartProducts();
                  },
                  child: BlocBuilder<CartProductsDisplayCubit, CartProductsDisplayState>(
                    builder: (context, state) {
                      if (state is CartProductsLoading) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
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
