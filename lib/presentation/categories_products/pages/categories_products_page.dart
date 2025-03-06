import 'package:e_commerce_application/common/bloc/product/product_display_state.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/common/widgets/product/product_card.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:e_commerce_application/domain/category/entity/category_entity.dart';
import 'package:e_commerce_application/domain/product/usecase/get_product_by_category_id.dart';
import 'package:e_commerce_application/service_locator.dart';

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
      body: BlocProvider(
        create: (context) =>
            ProductsDisplayCubit(useCase: sl<GetProductsByCategoryIdUseCase>())
              ..displayProducts(params: categoryEntity.categoryId),
        child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (state is ProductsLoaded) {
              return _products(state.products);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return SizedBox(
        child: GridView.builder(
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
    ));
  }
}
