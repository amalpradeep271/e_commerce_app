import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:e_commerce_application/common/bloc/product/product_display_state.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/product/product_card.dart';
import 'package:e_commerce_application/common/widgets/product/product_heading.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/domain/product/usecase/get_topselling_usecase.dart';
import 'package:e_commerce_application/presentation/all_products/pages/all_products_page.dart';
import 'package:e_commerce_application/presentation/wishlist/bloc/wishlist_cubit.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class TopSelling extends StatelessWidget {
  const TopSelling({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _topSelling(context),
        SizedBox(
          height: 20.h,
        ),
        MultiBlocProvider(
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
                return SizedBox(
                  height: 280.h,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10.0,
                      mainAxisExtent: 300,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) => Shimmer.fromColors(
                        baseColor: const Color.fromARGB(255, 218, 221, 227),
                        highlightColor: AppColors.colorDivider,
                        child: Container(
                          height: 150,
                          width: 80,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        )),
                  ),
                );
              }
              if (state is ProductsLoaded) {
                return _products(state.products);
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }

  Widget _topSelling(context) {
    return ProductHeading(
      productHeading: "Top Selling",
      allProductClick: () {
        AppNavigator.push(
          context,
          const AllProductsPage(
            title: "Top Selling",
          ),
        );
      },
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
        itemCount: 2,
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
