
import 'package:e_commerce_application/presentation/home/bloc/categories/categories_display_cubit.dart';
import 'package:e_commerce_application/presentation/home/bloc/categories/categories_display_state.dart';
import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/category/entity/category_entity.dart';
import 'package:e_commerce_application/presentation/categories_products/pages/categories_products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:e_commerce_application/common/widgets/please_try_again/please_try_again_widget.dart';

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
        BlocBuilder<CategoriesDisplayCubit, CategoriesDisplayState>(
          builder: (context, state) {
            if (state is CategoriesLoading) {
              return SizedBox(
                height: 40.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (context, index) => SizedBox(width: 15.w),
                  itemBuilder: (context, index) => Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 218, 221, 227),
                    highlightColor: AppColors.colorDivider,
                    child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                        gradient: AppColors.categoryLinercolor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              );
            }
            if (state is CategoriesLoaded) {
              return _categories(state.categories);
            }
            if (state is CategoriesLoadFailure) {
              return PleaseTryAgainWidget(
                errorMessage: "Failed to load categories",
                onRetry: () {
                  context.read<CategoriesDisplayCubit>().displayCategories();
                },
                isFullScreen: false,
              );
            }
            return Container();
          },
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
              buttonTitle: categories[index].title,
            );
          },
          separatorBuilder: (context, index) => SizedBox(width: 15.w),
          itemCount: categories.length),
    );
  }

  Widget _categoryButton({
    required VoidCallback onTap,
    required String buttonImage,
    required String buttonTitle,
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
              buttonImage.toLowerCase().contains('.svg')
                  ? SvgPicture.network(
                      ImageDisplayHelper.generateCategoryImageURL(buttonImage),
                      width: 25,
                      height: 25,
                    )
                  : Image.network(
                      ImageDisplayHelper.generateCategoryImageURL(buttonImage),
                      width: 25,
                      height: 25,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.category,
                        size: 25,
                      ),
                    ),
              Expanded(
                child: Text(
                  buttonTitle,
                  textAlign: TextAlign.center,
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
