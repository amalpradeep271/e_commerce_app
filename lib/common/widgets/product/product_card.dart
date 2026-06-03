import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/app_button/favourite_button.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/presentation/product_detail/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

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
            onTap: () {
              AppNavigator.push(
                context,
                ProductDetailsPage(
                  productEntity: productEntity,
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 190.h,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: CachedNetworkImage(
                      imageUrl: ImageDisplayHelper.generateProductImageURL(
                        productEntity.images[0],
                      ),
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: const Color.fromARGB(255, 218, 221, 227),
                        highlightColor: const Color.fromARGB(255, 240, 242, 245),
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error),
                      ),
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
          child: FavoriteButton(
            iconSize: 18.sp,
            productEntity: productEntity,
          ),
        )
      ],
    );
  }
}
