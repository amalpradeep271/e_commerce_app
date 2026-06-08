import 'package:e_commerce_application/common/bloc/button/button_state.dart';
import 'package:e_commerce_application/common/bloc/button/button_state_cubit.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/data/cart/model/add_to_cart_req_model.dart';
import 'package:e_commerce_application/domain/cart/usecase/add_to_cart_usecase.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/presentation/cart/bloc/cart_status_cubit.dart';
import 'package:e_commerce_application/presentation/cart/pages/cart_page.dart';
import 'package:e_commerce_application/presentation/product_detail/bloc/product_color_selection_cubit.dart';
import 'package:e_commerce_application/presentation/product_detail/bloc/product_quanitity_cubit.dart';
import 'package:e_commerce_application/presentation/product_detail/bloc/product_size_selection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddToCart extends StatelessWidget {
  final ProductEntity productEntity;
  const AddToCart({
    required this.productEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;
    final activeBtnColor = isDark ? const Color(0xFF14B8A6) : const Color(0xFF006970);
    final bottomBarBg = isDark ? const Color(0xFF1E293B) : Colors.white;
    final borderTopColor = isDark ? const Color(0xFF334155).withValues(alpha: 0.5) : const Color(0xFFE2E8F0);

    return BlocListener<ButtonStateCubit, ButtonState>(
      listener: (context, state) {
        if (state is ButtonSuccessState) {
          var snackbar = const SnackBar(
            content: Text('Item added to cart successfully!'),
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          AppNavigator.push(context, const CartPage());
        }
        if (state is ButtonFailureState) {
          var snackbar = SnackBar(
            content: Text(state.errorMessage),
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      },
      child: Container(
        height: 85.h,
        decoration: BoxDecoration(
          color: bottomBarBg,
          border: Border(
            top: BorderSide(
              color: borderTopColor,
              width: 1.w,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: BlocBuilder<CartStatusCubit, bool>(
          builder: (context, inCart) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Total Price Column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Price",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.outline,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    BlocBuilder<ProductQuantityCubit, int>(
                      builder: (context, qty) {
                        final currentPrice = productEntity.discountPrice != 0
                            ? productEntity.discountPrice
                            : productEntity.price;
                        final totalPrice = currentPrice * qty;
                        return Text(
                          "\$${totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: colorScheme.onSurface,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                // Add to Cart / Go to Cart reactive button
                GestureDetector(
                  onTap: () {
                    if (inCart) {
                      AppNavigator.push(context, const CartPage());
                    } else {
                      context.read<ButtonStateCubit>().execute(
                            usecase: AddToCartUseCase(),
                            params: AddToCartReq(
                              productId: productEntity.productId,
                              productTitle: productEntity.title,
                              productQuantity: context.read<ProductQuantityCubit>().state,
                              productColor: productEntity
                                  .color[context.read<ProductColorSelectionCubit>().selectedIndex]
                                  .title,
                              productSize: productEntity.sizes[context
                                  .read<ProductSizeSelectionCubit>()
                                  .selectedIndex],
                              productPrice: productEntity.price.toDouble(),
                              discountPrice: productEntity.discountPrice.toDouble(),
                              totalPrice: (productEntity.discountPrice != 0
                                      ? productEntity.discountPrice
                                      : productEntity.price)
                                  .toDouble() *
                                  context.read<ProductQuantityCubit>().state,
                              productImage: productEntity.images[0],
                              createdDate: DateTime.now().toString(),
                            ),
                          );
                    }
                  },
                  child: Container(
                    height: 50.h,
                    padding: EdgeInsets.symmetric(horizontal: 36.w),
                    decoration: BoxDecoration(
                      color: activeBtnColor,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        if (!isDark)
                          BoxShadow(
                            color: activeBtnColor.withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      inCart ? 'Go to Cart' : 'Add to Cart',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
