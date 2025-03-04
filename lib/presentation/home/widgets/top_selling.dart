import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:e_commerce_application/common/bloc/product/product_display_state.dart';
import 'package:e_commerce_application/common/widgets/product/product_card.dart';
import 'package:e_commerce_application/common/widgets/product/product_heading.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/domain/product/usecase/get_topselling_usecase.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopSelling extends StatelessWidget {
  const TopSelling({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _topSelling(),
        SizedBox(
          height: 20.h,
        ),
        BlocProvider(
          create: (context) =>
              ProductsDisplayCubit(useCase: sl<GetTopSellingUseCase>())
                ..displayProducts(),
          child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
            builder: (context, state) {
              if (state is ProductsLoading) {
                return const CupertinoActivityIndicator();
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

  Widget _topSelling() {
    return ProductHeading(
      productHeading: "Top Selling",
      allProductClick: () {},
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
        )
        // ListView.separated(
        //   shrinkWrap: true,
        //   padding: EdgeInsets.symmetric(
        //     horizontal: 16.w,
        //   ),
        //   scrollDirection: Axis.horizontal,
        //   itemBuilder: (context, index) {
        //     return ProductCard(
        //       productEntity: products[index],
        //     );
        //   },
        //   separatorBuilder: (context, index) => SizedBox(
        //     width: 10.w,
        //   ),
        //   itemCount: products.length,
        // ),
        );
  }
}
