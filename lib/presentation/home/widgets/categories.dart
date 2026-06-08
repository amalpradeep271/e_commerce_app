import 'package:e_commerce_application/presentation/home/bloc/categories/categories_display_cubit.dart';
import 'package:e_commerce_application/presentation/home/bloc/categories/categories_display_state.dart';
import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
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
          height: 12.h,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Categories",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _categories(List<CategoryEntity> categories) {
    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _categoryButton(
            context: context,
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
        separatorBuilder: (context, index) => SizedBox(width: 16.w),
        itemCount: categories.length,
      ),
    );
  }

  Widget _categoryButton({
    required BuildContext context,
    required VoidCallback onTap,
    required String buttonImage,
    required String buttonTitle,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: colorScheme.surfaceContainerHighest,
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: ClipOval(
              child: buttonImage.toLowerCase().contains('.svg')
                  ? SvgPicture.network(
                      ImageDisplayHelper.generateCategoryImageURL(buttonImage),
                      width: 28.w,
                      height: 28.h,
                      colorFilter: ColorFilter.mode(
                        colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    )
                  : Image.network(
                      ImageDisplayHelper.generateCategoryImageURL(buttonImage),
                      width: 32.w,
                      height: 32.h,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.category,
                        size: 28.w,
                        color: colorScheme.primary,
                      ),
                    ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            buttonTitle,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
