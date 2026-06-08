import 'package:e_commerce_application/common/bloc/product/product_display_state.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/common/widgets/product/product_card.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/presentation/wishlist/bloc/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:e_commerce_application/domain/category/entity/category_entity.dart';
import 'package:e_commerce_application/domain/product/usecase/get_product_by_category_id.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:e_commerce_application/common/widgets/product/product_grid_shimmer.dart';
import 'package:e_commerce_application/common/widgets/please_try_again/please_try_again_widget.dart';
import 'package:e_commerce_application/common/widgets/empty/empty_state_widget.dart';
import 'package:e_commerce_application/domain/product/repository/product_repository.dart';

class CategoryProductsPage extends StatelessWidget {
  final CategoryEntity categoryEntity;
  final String title;

  const CategoryProductsPage({
    super.key,
    required this.categoryEntity,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductsDisplayCubit(
                useCase: sl<GetProductsByCategoryIdUseCase>())
              ..displayProducts(params: categoryEntity.categoryId),
          ),
          BlocProvider(
            create: (context) => WishlistCubit()..loadWishlist(),
          ),
        ],
        child: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () async {
                sl<ProductRepository>().clearCache();
                context.read<ProductsDisplayCubit>().displayProducts(params: categoryEntity.categoryId);
              },
              child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
                builder: (context, state) {
                  if (state is ProductsLoading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: ProductGridShimmer(
                        itemCount: 6,
                        shrinkWrap: false,
                        physics: AlwaysScrollableScrollPhysics(),
                      ),
                    );
                  }
                  if (state is ProductsLoaded) {
                    if (state.products.isEmpty) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: EmptyStateWidget(
                            title: "No Products Found",
                            subtitle: "There are no products in this category.",
                            onRefresh: () {
                              sl<ProductRepository>().clearCache();
                              context.read<ProductsDisplayCubit>().displayProducts(params: categoryEntity.categoryId);
                            },
                          ),
                        ),
                      );
                    }
                    return _products(state.products);
                  }
                  if (state is LoadProductsFailure) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: PleaseTryAgainWidget(
                          errorMessage: state.errorMessage,
                          onRetry: () {
                            sl<ProductRepository>().clearCache();
                            context.read<ProductsDisplayCubit>().displayProducts(params: categoryEntity.categoryId);
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
  }

  Widget _products(List<ProductEntity> products) {
    return SizedBox(
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10.0,
          mainAxisExtent: 300,
        ),
        itemCount: products.length,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: ProductCard(
              productEntity: products[index],
            ),
          );
        },
      ),
    );
  }
}
