import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

class ProductHeading extends StatelessWidget {
  const ProductHeading({
    super.key,
    required this.productHeading,
    required this.allProductClick,
  });

  final String productHeading;
  final VoidCallback allProductClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          productHeading,
          style: AppTextStyles.base.w500.s16,
        ),
        TextButton(
          onPressed: allProductClick,
          child: Text(
            "See all",
            style: AppTextStyles.base.w500.s14.blackColor,
          ),
        )
      ],
    );
  }
}
