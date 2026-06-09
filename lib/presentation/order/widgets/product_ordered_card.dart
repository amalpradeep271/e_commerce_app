import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/domain/cart/entity/product_ordered_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderItemCard extends StatelessWidget {
  final ProductOrderedEntity productOrderedEntity;
  const OrderItemCard({required this.productOrderedEntity, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final brandTeal = isDark ? const Color(0xFF14B8A6) : const Color(0xFF006970);
    
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white, // slate 800 / white
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? const Color(0xFF334155).withValues(alpha: 0.5) : const Color(0xFFE2E8F0),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: 70.w,
              height: 70.w,
              color: isDark ? const Color(0xFF0F172A) : AppColors.productGray,
              child: Image.network(
                ImageDisplayHelper.generateProductImageURL(
                  productOrderedEntity.productImage,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 14.w),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productOrderedEntity.productTitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    // Color dot representation
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      "${productOrderedEntity.productColor}  •  Size ${productOrderedEntity.productSize}",
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Qty: ${productOrderedEntity.productQuantity}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                    Text(
                      '\$${productOrderedEntity.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: brandTeal,
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
