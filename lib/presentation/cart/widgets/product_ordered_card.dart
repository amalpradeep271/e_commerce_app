import 'dart:developer';

import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/cart/entity/product_ordered_entity.dart';
import 'package:e_commerce_application/presentation/cart/bloc/cart_product_display_cubit.dart';
import 'package:e_commerce_application/presentation/cart/bloc/cart_status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/configs/theme/app_colors.dart';

class ProductOrderedCard extends StatelessWidget {
  final ProductOrderedEntity productOrderedEntity;
  const ProductOrderedCard({required this.productOrderedEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(
          8.r,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: 90.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          ImageDisplayHelper.generateProductImageURL(
                            productOrderedEntity.productImage,
                          ),
                        ),
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productOrderedEntity.productTitle,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.base.w600.s16,
                      ),
                      Text(
                        'X ${productOrderedEntity.productQuantity.toString()}',
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.base.w600.s16,
                      ),
                      Text.rich(
                        overflow: TextOverflow.ellipsis,
                        TextSpan(
                          text: 'Size - ',
                          style: AppTextStyles.base.w600.s12,
                          children: [
                            TextSpan(
                              text: productOrderedEntity.productSize,
                              style: AppTextStyles.base.w600.s12,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text.rich(
                        overflow: TextOverflow.ellipsis,
                        TextSpan(
                          text: 'Color - ',
                          style: AppTextStyles.base.w600.s12,
                          children: [
                            TextSpan(
                              text: productOrderedEntity.productColor,
                              style: AppTextStyles.base.w600.s12,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹ ${productOrderedEntity.totalPrice}',
                  style: AppTextStyles.base.s14.w600,
                ),
                GestureDetector(
                  onTap: () async {
                    context
                        .read<CartProductsDisplayCubit>()
                        .removeProduct(productOrderedEntity, context)
                        .then(
                      (_) {
                        log("🗑️ Calling markAsRemoved()...");
                        context.read<CartStatusCubit>().markAsRemoved();

                        log("🔄 Checking cart status again...");
                        context
                            .read<CartStatusCubit>()
                            .checkCartStatus(productOrderedEntity.productId);
                      },
                    );
                  },
                  child: Container(
                    height: 23.h,
                    width: 23.w,
                    decoration: const BoxDecoration(
                        color: Color(0xffFF8383), shape: BoxShape.circle),
                    child: const Icon(
                      Icons.remove,
                      size: 15,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
