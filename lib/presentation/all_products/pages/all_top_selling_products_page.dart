import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_state.dart';
import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:e_commerce_application/common/bloc/product/product_display_state.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/common/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:e_commerce_application/common/widgets/product/product_card.dart';
import 'package:e_commerce_application/domain/product/usecase/get_topselling_usecase.dart';
import 'package:e_commerce_application/presentation/wishlist/bloc/wishlist_cubit.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllTopSellingProductsPage extends StatelessWidget {
  const AllTopSellingProductsPage({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectivityDisconnected) {
          return const NoInternetScreen();
        }
        return Scaffold(
          appBar: CustomAppBar(
            title: title,
          ),
          body: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    ProductsDisplayCubit(useCase: sl<GetTopSellingUseCase>())
                      ..displayProducts(),
              ),
              BlocProvider(
                create: (context) => WishlistCubit()..loadWishlist(),
              ),
            ],
            child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                if (state is ProductsLoaded) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 5,
                      childAspectRatio: .60,
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: ProductCard(
                          productEntity: state.products[index],
                        ),
                      );
                    },
                    itemCount: state.products.length,
                  );
                }
                return Container();
              },
            ),
          ),
        );
      },
    );
  }
}
