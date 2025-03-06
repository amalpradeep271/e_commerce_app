import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductPrice extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductPrice({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "₹${productEntity.discountPrice != 0 ? productEntity.discountPrice : productEntity.price}",
          style: AppTextStyles.base.s24.w600,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          "(Inclusive of all taxes )",
          style: AppTextStyles.base.s12,
        )
      ],
    );
  }
}
