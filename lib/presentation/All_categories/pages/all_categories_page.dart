import 'package:e_commerce_application/common/bloc/categories/categories_display_cubit.dart';
import 'package:e_commerce_application/common/bloc/categories/categories_display_state.dart';
import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/presentation/categories_products/pages/categories_products_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllCategoriesPage extends StatelessWidget {
  const AllCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        hideBack: false,
      ),
      body: BlocProvider(
        create: (context) => CategoriesDisplayCubit()..displayCategories(),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shopByCategories(),
              SizedBox(height: 10.h),
              _categories(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shopByCategories() {
    return const Text(
      'Shop by Categories',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
    );
  }

  Widget _categories() {
    return Expanded(
      child: BlocBuilder<CategoriesDisplayCubit, CategoriesDisplayState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is CategoriesLoaded) {
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    AppNavigator.push(
                      context,
                      CategoryProductsPage(
                        categoryEntity: state.categories[index],
                      ),
                    );
                  },
                  child: Container(
                    height: 70.h,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.secondBackground,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                ImageDisplayHelper.generateCategoryImageURL(
                                    state.categories[index].image),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          state.categories[index].title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
              itemCount: state.categories.length,
            );
          }
          return Container();
        },
      ),
    );
  }
}
