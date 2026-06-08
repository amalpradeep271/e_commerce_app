import 'package:e_commerce_application/common/helper/cart/cart_helper.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_app_button.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/cart/entity/product_ordered_entity.dart';
import 'package:e_commerce_application/presentation/cart/pages/checkout_page.dart';
import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  final List<ProductOrderedEntity> products;
  const Checkout({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    dynamic shipping = 40;
    dynamic tax = 8.5;

    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height / 3.5,
      color: AppColors.cream,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: AppTextStyles.base.blackColor.s16.w500,
              ),
              Text(
                '₹ ${CartHelper.calculateCartSubtotal(products).toString()}',
                style: AppTextStyles.base.blackColor.s16.w900,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shipping Cost',
                style: AppTextStyles.base.blackColor.s16.w500,
              ),
              Text(
                '₹ $shipping',
                style: AppTextStyles.base.blackColor.s16.w900,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tax',
                style: AppTextStyles.base.blackColor.s16.w500,
              ),
              Text(
                '₹ $tax',
                style: AppTextStyles.base.blackColor.s16.w900,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppTextStyles.base.blackColor.s16.w500,
              ),
              Text(
                '₹ ${CartHelper.calculateCartSubtotal(products) + shipping + tax}',
                style: AppTextStyles.base.blackColor.s16.w900,
              )
            ],
          ),
          BasicAppButton(
            onPressed: () {
              AppNavigator.push(
                context,
                CheckOutPage(
                  shipping: shipping,
                  tax: tax,
                  products: products,
                ),
              );
            },
            title: 'Checkout',
          )
        ],
      ),
    );
  }
}
