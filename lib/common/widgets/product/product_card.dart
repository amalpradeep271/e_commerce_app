import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/app_button/favourite_button.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

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
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: colorScheme.surfaceContainerHighest,
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: ImageDisplayHelper.generateProductImageURL(
                        productEntity.images[0],
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: colorScheme.surfaceContainerHighest,
                        highlightColor: colorScheme.surface,
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
                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productEntity.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            productEntity.discountPrice == 0
                                ? "₹ ${productEntity.price}"
                                : "₹ ${productEntity.discountPrice}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: colorScheme.primary,
                            ),
                          ),
                          if (productEntity.discountPrice != 0) ...[
                            SizedBox(width: 8.w),
                            Text(
                              "₹ ${productEntity.price}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                                color: colorScheme.outline,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 8.h,
          right: 8.w,
          child: FavoriteButton(
            iconSize: 18.sp,
            productEntity: productEntity,
          ),
        ),
      ],
    );
  }
}
