import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:e_commerce_application/common/bloc/product/product_display_state.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/product/product_card.dart';
import 'package:e_commerce_application/common/widgets/product/product_heading.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/domain/product/usecase/get_newin_usecase.dart';
import 'package:e_commerce_application/presentation/all_products/pages/all_new_products_page.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewIn extends StatelessWidget {
  const NewIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _newIn(context),
        SizedBox(
          height: 20.h,
        ),
        BlocProvider(
          create: (context) =>
              ProductsDisplayCubit(useCase: sl<GetNewInUseCase>())
                ..displayProducts(),
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
      ],
    );
  }

  Widget _newIn(context) {
    return ProductHeading(
      productHeading: "New In",
      allProductClick: () {
        AppNavigator.push(
          context,
          const AllNewProductsPage(
            title: "New In",
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
