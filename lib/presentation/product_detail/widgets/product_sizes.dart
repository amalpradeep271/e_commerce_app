// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSizes extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductSizes({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productEntity.sizes.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey,
              ),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Center(
              child: Text(
                productEntity.sizes[index],
                style: const TextStyle(
                  color: AppColors.black,
                ),
              ),
            ),
          );
        },
      ),
    );

    // Container(
    //   height: MediaQuery.of(context).size.height / 2,
    //   padding: EdgeInsets.all(16.w),
    //   decoration: BoxDecoration(
    //       color: AppColors.background,
    //       borderRadius: BorderRadius.only(
    //           topRight: Radius.circular(16.r), topLeft: Radius.circular(16.r))),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       SizedBox(
    //         height: 40.h,
    //         child: Stack(
    //           children: [
    //             const Center(
    //               child: Text(
    //                 'Size',
    //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
    //               ),
    //             ),
    //             Align(
    //               alignment: Alignment.bottomRight,
    //               child: IconButton(
    //                   onPressed: () {
    //                     Navigator.pop(context);
    //                   },
    //                   icon: const Icon(Icons.close)),
    //             )
    //           ],
    //         ),
    //       ),
    //       SizedBox(height: 20.h),
    //       Expanded(
    //         child: ListView.separated(
    //             shrinkWrap: true,
    //             itemBuilder: (context, index) {
    //               return BlocBuilder<ProductSizeSelectionCubit, int>(
    //                 builder: (context, state) => GestureDetector(
    //                   onTap: () {
    //                     context
    //                         .read<ProductSizeSelectionCubit>()
    //                         .itemSelection(index);
    //                     Navigator.pop(context);
    //                   },
    //                   child: Container(
    //                     height: 60.h,
    //                     padding: EdgeInsets.symmetric(horizontal: 16.w),
    //                     decoration: BoxDecoration(
    //                         color: state == index
    //                             ? AppColors.primary
    //                             : AppColors.secondBackground,
    //                         borderRadius: BorderRadius.circular(50.r)),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Padding(
    //                           padding: const EdgeInsets.only(left: 15),
    //                           child: Text(
    //                             productEntity.sizes[index],
    //                             style: const TextStyle(
    //                               fontWeight: FontWeight.bold,
    //                               fontSize: 18,
    //                             ),
    //                           ),
    //                         ),
    //                         state == index
    //                             ? const Icon(
    //                                 Icons.check,
    //                                 size: 30,
    //                               )
    //                             : Container(
    //                                 width: 30,
    //                               )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             },
    //             separatorBuilder: (context, index) => SizedBox(height: 20.h),
    //             itemCount: productEntity.sizes.length),
    //       ),
    //     ],
    //   ),
    // );
  }
}
