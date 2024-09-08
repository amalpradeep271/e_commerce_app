import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedColor extends StatelessWidget {
  final ProductEntity productEntity;
  const SelectedColor({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // AppBottomsheet.display(
        //   context,
        //   BlocProvider.value(
        //     value:BlocProvider.of<ProductColorSelectionCubit>(context),
        //     child: ProductColors(productEntity: productEntity,)
        //   )
        // );
      },
      child: Container(
        height: 60.h,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Color',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            Row(
              children: [
                // BlocBuilder<ProductColorSelectionCubit,int>(
                //   builder: (context, state) =>
                Container(
                  height: 20.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                      0,
                      0,
                      0,
                      // productEntity.colors[state].rgb[0],
                      // productEntity.colors[state].rgb[1],
                      // productEntity.colors[state].rgb[2],
                      1,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),

                SizedBox(
                  width: 15.w,
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 30,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
