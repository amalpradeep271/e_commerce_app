import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ProductCard extends StatelessWidget {
//   final ProductEntity productEntity;
//   const ProductCard({required this.productEntity, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // AppNavigator.push(
//         //   context,
//         //   ProductDetailsPage(
//         //     productEntity: productEntity,
//         //   ),
//         // );
//       },
//       child: Container(
//         width: 180,
//         decoration: BoxDecoration(
//           color: AppColors.secondBackground,
//           borderRadius: BorderRadius.circular(8.r),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               flex: 4,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: NetworkImage(
//                       ImageDisplayHelper.generateProductImageURL(
//                         productEntity.images[0],
//                       ),
//                     ),
//                   ),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(8.r),
//                     topRight: Radius.circular(8.r),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       productEntity.title,
//                       style: const TextStyle(
//                           color: AppColors.whiteColor,
//                           fontSize: 12,
//                           overflow: TextOverflow.ellipsis,
//                           fontWeight: FontWeight.w300),
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           productEntity.discountPrice == 0
//                               ? "₹ ${productEntity.price}"
//                               : "₹ ${productEntity.discountPrice}",
//                           style: const TextStyle(
//                             color: AppColors.whiteColor,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           productEntity.discountPrice == 0
//                               ? ''
//                               : "₹ ${productEntity.price}",
//                           style: const TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey,
//                               fontWeight: FontWeight.w300,
//                               decoration: TextDecoration.lineThrough),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.productEntity,
  });
  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 190.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    image: DecorationImage(
                      image: NetworkImage(
                        ImageDisplayHelper.generateProductImageURL(
                          productEntity.images[0],
                        ),
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  productEntity.title,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.base.w500.s15,
                ),
                Row(
                  children: [
                    Text(
                      productEntity.discountPrice == 0
                          ? "₹ ${productEntity.price}"
                          : "₹ ${productEntity.discountPrice}",
                      style: AppTextStyles.base.w700.s15,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      productEntity.discountPrice == 0
                          ? ''
                          : "₹ ${productEntity.price}",
                      style: AppTextStyles.base.s15.greyColor.w300.lineThrough,
                    ),
                  ],
                )
              ],
            )),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite,
                color: AppColors.grey,
              )),
        )
      ],
    );
  }
}
