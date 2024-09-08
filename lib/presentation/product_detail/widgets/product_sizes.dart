// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_application/presentation/product_detail/bloc/product_size_selection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';

class ProductSizes extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductSizes({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      padding: EdgeInsets.all(25.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.r),
          topLeft: Radius.circular(16.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40.h,
            child: Stack(
              children: [
                const Center(
                  child: Text(
                    'Size',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                // return BlocBuilder<ProductSizeSelectionCubit, int>(
                //   builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    // context
                    //     .read<ProductSizeSelectionCubit>()
                    //     .itemSelection(index);
                    // Navigator.pop(context);
                  },
                  child: Container(
                    height: 60.h,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color:
                          //  state == index
                          //     ?
                          AppColors.primary,
                      // : AppColors.secondBackground,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          productEntity.sizes[index],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        // state == index
                        //     ? const Icon(
                        //         Icons.check,
                        //         size: 30,
                        //       )
                        //     :
                        Container(
                          width: 30.w,
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 20.h,
              ),
              itemCount: productEntity.sizes.length,
            ),
          )
        ],
      ),
    );
  }
}
