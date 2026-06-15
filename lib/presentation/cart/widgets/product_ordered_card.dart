import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/cart/entity/product_ordered_entity.dart';
import 'package:e_commerce_application/presentation/cart/bloc/cart_product_display_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_application/core/configs/tenant/tenant_config.dart';

import '../../../core/configs/theme/app_colors.dart';

class ProductOrderedCard extends StatelessWidget {
  final ProductOrderedEntity productOrderedEntity;
  const ProductOrderedCard({required this.productOrderedEntity, super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final borderColor = isDark ? const Color(0xFF334155) : Colors.grey.shade200;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final tealColor =
        isDark ? const Color(0xFF14B8A6) : const Color(0xFF0D9488);
    final quantityBgColor =
        isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC);
    final quantityBorderColor =
        isDark ? const Color(0xFF334155) : Colors.grey.shade200;

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            width: 65.w,
            height: 65.w,
            decoration: BoxDecoration(
              color: isDark ? Colors.black : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  ImageDisplayHelper.generateProductImageURL(
                    productOrderedEntity.productImage,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title and Delete Icon
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        productOrderedEntity.productTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<CartProductsDisplayCubit>()
                            .removeProduct(productOrderedEntity, context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Icon(
                          Icons.delete_outline,
                          size: 20.sp,
                          color: subTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                // Color and Size
                Row(
                  children: [
                    Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: const BoxDecoration(
                        color: Colors.red, // Placeholder color dot
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        '${productOrderedEntity.productColor} • Size ${productOrderedEntity.productSize}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: subTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // Quantity and Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Quantity Selector
                    Container(
                      height: 26.h,
                      decoration: BoxDecoration(
                        color: quantityBgColor,
                        border: Border.all(color: quantityBorderColor),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(minWidth: 32.w),
                            icon: Icon(Icons.remove,
                                size: 16.sp, color: textColor),
                            onPressed: () {
                              // Quantity update logic here
                            },
                          ),
                          Text(
                            productOrderedEntity.productQuantity.toString(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(minWidth: 32.w),
                            icon:
                                Icon(Icons.add, size: 16.sp, color: textColor),
                            onPressed: () {
                              // Quantity update logic here
                            },
                          ),
                        ],
                      ),
                    ),
                    // Price
                    Text(
                      '${TenantConfig.instance.currencySymbol}${productOrderedEntity.totalPrice}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: tealColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
