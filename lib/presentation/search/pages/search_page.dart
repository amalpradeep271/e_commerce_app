import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:e_commerce_application/common/bloc/product/product_display_state.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/common/widgets/product/product_card.dart';
import 'package:e_commerce_application/core/configs/assets/app_vectors.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/domain/product/usecase/get_products_by_title.dart';
import 'package:e_commerce_application/presentation/search/widgets/search_field.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductsDisplayCubit(useCase: sl<GetProductsByTitleUseCase>()),
      child: Scaffold(
        appBar: BasicAppbar(
          height: 80,
          title: SearchField(),
        ),
        body: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (state is ProductsLoaded) {
              return state.products.isEmpty
                  ? _notFound()
                  : _products(state.products);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _notFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppVectors.notFound,
        ),
        Padding(
          padding: EdgeInsets.all(16.w),
          child: const Text(
            "Sorry, we couldn't find any matching result for your Search.",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
        )
      ],
    );
  }

  Widget _products(List<ProductEntity> products) {
    return GridView.builder(
      itemCount: products.length,
      padding: EdgeInsets.all(16.w),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (BuildContext context, int index) {
        return ProductCard(productEntity: products[index]);
      },
    );
  }
}
