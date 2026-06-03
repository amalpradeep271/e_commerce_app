import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:e_commerce_application/common/bloc/product/product_display_state.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/product/product_card.dart';
import 'package:e_commerce_application/common/widgets/product/product_heading.dart';
import 'package:e_commerce_application/common/widgets/product/product_grid_shimmer.dart';
import 'package:e_commerce_application/core/usecase/usecase.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_application/common/widgets/please_try_again/please_try_again_widget.dart';

class ProductSection extends StatelessWidget {
  final String heading;
  final UseCase useCase;
  final Widget seeAllPage;

  const ProductSection({
    super.key,
    required this.heading,
    required this.useCase,
    required this.seeAllPage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProductHeading(
          productHeading: heading,
          allProductClick: () {
            AppNavigator.push(context, seeAllPage);
          },
        ),
        SizedBox(
          height: 20.h,
        ),
        BlocProvider(
          create: (context) =>
              ProductsDisplayCubit(useCase: useCase)..displayProducts(),
          child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
            builder: (context, state) {
              if (state is ProductsLoading) {
                return const ProductGridShimmer();
              }
              if (state is ProductsLoaded) {
                return _products(state.products);
              }
              if (state is LoadProductsFailure) {
                return PleaseTryAgainWidget(
                  errorMessage: state.errorMessage,
                  onRetry: () {
                    context.read<ProductsDisplayCubit>().displayProducts();
                  },
                  isFullScreen: false,
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }

  Widget _products(List<ProductEntity> products) {
    return SizedBox(
      height: 280.h,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10.0,
          mainAxisExtent: 300,
        ),
        itemCount: products.length < 2 ? products.length : 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return ProductCard(
            productEntity: products[index],
          );
        },
      ),
    );
  }
}
