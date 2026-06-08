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
    this.showRating = true,
    this.showCartButton = true,
    this.badgeText,
  });

  final ProductEntity productEntity;
  final bool showRating;
  final bool showCartButton;
  final String? badgeText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    
    // Exact brand colors matching the provided screen designs
    final brandTeal = isDark ? const Color(0xFF14B8A6) : const Color(0xFF006970);
    const badgeOrange = Color(0xFFE5951F);

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
              color: isDark ? const Color(0xFF1E293B) : Colors.white, // slate 800 in dark, white in light
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isDark 
                    ? const Color(0xFF334155).withValues(alpha: 0.5) 
                    : const Color(0xFFE2E8F0), // clean borders
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
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
                        baseColor: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                        highlightColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
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
                  padding: EdgeInsets.all(10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              productEntity.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : const Color(0xFF0F172A), // slate 900
                              ),
                            ),
                            if (showRating) ...[
                              SizedBox(height: 3.h),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 12.sp),
                                  SizedBox(width: 3.w),
                                  Text(
                                    productEntity.rating.toStringAsFixed(1),
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? Colors.white70 : Colors.black87,
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    "(${productEntity.ratingCount})",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: colorScheme.outline,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            SizedBox(height: 5.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  productEntity.discountPrice == 0
                                      ? "\$${productEntity.price}"
                                      : "\$${productEntity.discountPrice}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                    color: brandTeal,
                                  ),
                                ),
                                if (productEntity.discountPrice != 0) ...[
                                  SizedBox(width: 4.w),
                                  Flexible(
                                    child: Text(
                                      "\$${productEntity.price}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: colorScheme.outline,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (showCartButton && isDark) ...[
                        SizedBox(width: 4.w),
                        Container(
                          width: 32.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            color: brandTeal,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Heart favorite button at the top-right
        Positioned(
          top: 8.h,
          right: 8.w,
          child: FavoriteButton(
            iconSize: 16.sp,
            productEntity: productEntity,
          ),
        ),
        // Badge at the top-left
        if (badgeText != null)
          Positioned(
            top: 8.h,
            left: 8.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: badgeOrange,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                badgeText!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
