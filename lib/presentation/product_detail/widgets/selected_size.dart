// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_application/common/helper/bottomsheet/app_bottomsheet.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/presentation/product_detail/bloc/product_size_selection_cubit.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/product_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedSize extends StatelessWidget {
  final ProductEntity productEntity;

  const SelectedSize({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppBottomsheet.display(
          context,
          // BlocProvider.value(
          //   value: BlocProvider.of<ProductSizeSelectionCubit>(context),
          //   child:
          ProductSizes(productEntity: productEntity),
          // ),
        );
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
              'Sizes',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            Row(
              children: [
                // BlocBuilder<ProductSizeSelectionCubit, int>(
                //   builder: (context, state) {
                //     return
                Text(
                  'S',
                  // productEntity.sizes[state],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                //   },
                // ),
                SizedBox(width: 15.w),
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
