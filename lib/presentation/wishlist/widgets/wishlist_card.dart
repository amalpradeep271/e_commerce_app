import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/presentation/wishlist/bloc/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:e_commerce_application/core/configs/tenant/tenant_config.dart';

class WishlistCard extends StatelessWidget {
  const WishlistCard({
    super.key,
    required this.productEntity,
  });
  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final brandTeal = isDark ? const Color(0xFF14B8A6) : const Color(0xFF006970);
    
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white, // Slate 800 or White
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark 
              ? const Color(0xFF334155).withValues(alpha: 0.5) 
              : const Color(0xFFE2E8F0),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? Colors.black.withValues(alpha: 0.2) 
                : Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left: Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: 80.w,
              height: 80.w,
              color: isDark ? const Color(0xFF0F172A) : AppColors.productGray,
              child: CachedNetworkImage(
                imageUrl: ImageDisplayHelper.generateProductImageURL(
                  productEntity.images[0],
                ),
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                  highlightColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                  child: Container(color: Colors.white),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          // Middle: Title & Price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productEntity.title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Text(
                  "${TenantConfig.instance.currencySymbol}${productEntity.price}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: brandTeal,
                  ),
                ),
              ],
            ),
          ),
          // Right: Delete Button
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            onPressed: () {
              context.read<WishlistCubit>().toggleWishlist(productEntity);
            },
          ),
        ],
      ),
    );
  }
}
