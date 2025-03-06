// import 'package:e_commerce_application/common/bloc/categories/categories_display_cubit.dart';
// import 'package:e_commerce_application/common/bloc/categories/categories_display_state.dart';
// import 'package:e_commerce_application/common/helper/images/images_display.dart';
// import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
// import 'package:e_commerce_application/domain/category/entity/category_entity.dart';
// import 'package:e_commerce_application/presentation/All_categories/pages/all_categories_page.dart';
// import 'package:e_commerce_application/presentation/categories_products/pages/categories_products_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:e_commerce_application/common/bloc/categories/categories_display_cubit.dart';
import 'package:e_commerce_application/common/bloc/categories/categories_display_state.dart';
import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/category/entity/category_entity.dart';
import 'package:e_commerce_application/presentation/categories_products/pages/categories_products_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(context),
        SizedBox(
          height: 20.h,
        ),
        BlocProvider(
          create: (context) => CategoriesDisplayCubit()..displayCategories(),
          child: BlocBuilder<CategoriesDisplayCubit, CategoriesDisplayState>(
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return const CupertinoActivityIndicator();
              }
              if (state is CategoriesLoaded) {
                return _categories(state.categories);
              }
              return Container();
            },
          ),
        )
      ],
    );
  }

  Widget _title(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 14.h,
        ),
        Text(
          "Categories",
          style: AppTextStyles.base.w500.s16,
        ),
      ],
    );
  }

  Widget _categories(List<CategoryEntity> categories) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _categoryButton(
              onTap: () {
                AppNavigator.push(
                  context,
                  CategoryProductsPage(
                    title: categories[index].title,
                    categoryEntity: categories[index],
                  ),
                );
              },
              buttonImage: categories[index].image,
              butttontitle: categories[index].title,
            );
          },
          separatorBuilder: (context, index) => SizedBox(width: 15.w),
          itemCount: categories.length),
    );
  }

  _categoryButton({
    required VoidCallback onTap,
    required String buttonImage,
    required String butttontitle,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 120,
        decoration: BoxDecoration(
            gradient: AppColors.categoryLinercolor,
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.network(
                ImageDisplayHelper.generateCategoryImageURL(buttonImage),
                width: 25,
                height: 25,
              ),
              SizedBox(
                child: Text(
                  butttontitle,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.base.w400.s15,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
