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
    final isTopSelling = heading.toLowerCase().contains("top");

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
          height: 12.h,
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
                if (isTopSelling) {
                  return SizedBox(
                    height: 240.h,
                    child: _products(context, state.products),
                  );
                } else {
                  return _products(context, state.products);
                }
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

  Widget _products(BuildContext context, List<ProductEntity> products) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isTopSelling = heading.toLowerCase().contains("top");
    final maxItems = isTopSelling ? 2 : 4;
    final displayProducts = products.take(maxItems).toList();

    if (displayProducts.isEmpty) {
      return Container(
        height: 60.h,
        alignment: Alignment.center,
        child: Text(
          "No products available",
          style: TextStyle(
            color: Theme.of(context).colorScheme.outline,
            fontSize: 14.sp,
          ),
        ),
      );
    }

    if (isTopSelling) {
      return Row(
        children: [
          Expanded(
            child: ProductCard(
              productEntity: displayProducts[0],
              showRating: true,
              showCartButton: !isDark, // Cart button only in light mode for Top Selling
              badgeText: "Best Seller",
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: displayProducts.length > 1
                ? ProductCard(
                    productEntity: displayProducts[1],
                    showRating: true,
                    showCartButton: !isDark,
                    badgeText: "Best Seller",
                  )
                : const SizedBox(),
          ),
        ],
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: displayProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          mainAxisExtent: 240.h,
        ),
        itemBuilder: (context, index) {
          return ProductCard(
            productEntity: displayProducts[index],
            showRating: false, // New Arrivals has no ratings
            showCartButton: false, // New Arrivals has no cart button
            badgeText: "New",
          );
        },
      );
    }
  }
}
