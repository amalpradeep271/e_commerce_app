import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductColors extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductColors({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Color :",
          style: AppTextStyles.base.s16.blackColor,
        ),
        SizedBox(width: 8.w),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Text(
            productEntity.color[0].title,
            style: const TextStyle(
              color: AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
