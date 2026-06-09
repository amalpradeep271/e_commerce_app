import 'package:e_commerce_application/common/helper/cart/cart_helper.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_app_button.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/cart/entity/product_ordered_entity.dart';
import 'package:e_commerce_application/presentation/cart/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Checkout extends StatelessWidget {
  final List<ProductOrderedEntity> products;
  const Checkout({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF3F4F6);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final borderColor = isDark ? const Color(0xFF334155) : Colors.grey.shade200;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final tealColor =
        isDark ? const Color(0xFF14B8A6) : const Color(0xFF0D9488);

    final subtotal = CartHelper.calculateCartSubtotal(products);
    final discount = 500.0;
    final total = (subtotal - discount) > 0 ? (subtotal - discount) : 0.0;

    return Container(
      color: bgColor,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Coupon Section
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : Colors.white,
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 12.w),
                      Icon(Icons.local_activity_outlined,
                          color: subTextColor, size: 20.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: textColor, fontSize: 12.sp),
                          decoration: InputDecoration(
                            hintText: 'Coupon code',
                            hintStyle:
                                TextStyle(color: subTextColor, fontSize: 12.sp),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: tealColor,
                  foregroundColor: Colors.white,
                  minimumSize: Size(80.w, 40.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 0,
                ),
                child: Text('Apply',
                    style: TextStyle(
                        fontSize: 12.sp, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // Coupon Success Message
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF022C22) : const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                  color: isDark
                      ? const Color(0xFF064E3B)
                      : const Color(0xFFD1FAE5)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline,
                    color: const Color(0xFF10B981), size: 16.sp),
                SizedBox(width: 8.w),
                Text(
                  'Coupon Applied! ₹500 discount saved.',
                  style: TextStyle(
                    color: const Color(0xFF10B981),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Order Summary
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: borderColor),
            ),
            child: Column(
              children: [
                _buildSummaryRow('Subtotal', '₹${subtotal.toStringAsFixed(0)}',
                    subTextColor, textColor),
                SizedBox(height: 12.h),
                _buildSummaryRow('Discount', '-₹${discount.toStringAsFixed(0)}',
                    subTextColor, tealColor),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery',
                        style: TextStyle(color: subTextColor, fontSize: 12.sp)),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        'FREE',
                        style: TextStyle(
                          color: const Color(0xFF10B981),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Divider(color: borderColor, height: 1),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '₹${total.toStringAsFixed(0)}',
                      style: TextStyle(
                          color: tealColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Proceed to Checkout Button
          ElevatedButton(
            onPressed: () {
              AppNavigator.push(
                context,
                CheckOutPage(
                  shipping: 0,
                  tax: 0,
                  products: products,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: tealColor,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 48.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Proceed to Checkout',
                    style: TextStyle(
                        fontSize: 14.sp, fontWeight: FontWeight.bold)),
                SizedBox(width: 8.w),
                Icon(Icons.arrow_forward, size: 20.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
      String title, String value, Color titleColor, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: titleColor, fontSize: 12.sp)),
        Text(value,
            style: TextStyle(
                color: valueColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}
