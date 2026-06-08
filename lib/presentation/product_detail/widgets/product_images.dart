import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/common/widgets/app_button/favourite_button.dart';
import 'package:e_commerce_application/presentation/product_detail/bloc/product_image_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImages extends StatelessWidget {
  final ProductEntity productEntity;
  final CarouselSliderController carouselController = CarouselSliderController();

  ProductImages({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final activeBorderColor = isDark ? const Color(0xFF14B8A6) : const Color(0xFF4F378A);

    return Stack(
      children: [
        // Main Content: Image carousel and thumbnails
        Column(
          children: [
            // Image Carousel area
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                BlocBuilder<ProductImageViewCubit, int>(
                  builder: (context, selectedIndex) {
                    return CarouselSlider.builder(
                      carouselController: carouselController,
                      itemCount: productEntity.images.length,
                      itemBuilder: (context, index, _) {
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
                          ),
                          child: Center(
                            child: Image.network(
                              ImageDisplayHelper.generateSingleProductImageURL(
                                productEntity.images[index],
                              ),
                              fit: BoxFit.contain,
                              height: 320.h,
                              errorBuilder: (context, error, _) {
                                return const Center(child: Text("Image not available"));
                              },
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        initialPage: selectedIndex,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: productEntity.images.length > 1,
                        autoPlay: false,
                        height: 320.h,
                        onPageChanged: (index, _) {
                          context.read<ProductImageViewCubit>().selectImage(index);
                        },
                      ),
                    );
                  },
                ),
                // Indicator dots over the main image bottom center
                if (productEntity.images.length > 1)
                  Positioned(
                    bottom: 12.h,
                    child: BlocBuilder<ProductImageViewCubit, int>(
                      builder: (context, selectedIndex) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            productEntity.images.length,
                            (index) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              width: selectedIndex == index ? 20.w : 6.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? activeBorderColor
                                    : Colors.grey.withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
            SizedBox(height: 12.h),
            // Horizontal list of thumbnails
            SizedBox(
              height: 56.h,
              child: BlocBuilder<ProductImageViewCubit, int>(
                builder: (context, selectedIndex) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: productEntity.images.length,
                    separatorBuilder: (context, index) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      final isSelected = selectedIndex == index;
                      return GestureDetector(
                        onTap: () {
                          context.read<ProductImageViewCubit>().selectImage(index);
                          carouselController.animateToPage(index);
                        },
                        child: Container(
                          width: 56.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E293B) : Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: isSelected ? activeBorderColor : Colors.transparent,
                              width: 2.w,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.network(
                              ImageDisplayHelper.generateSingleProductImageURL(
                                productEntity.images[index],
                              ),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, _) {
                                return const Icon(Icons.image, color: Colors.grey);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        // Floating action buttons (Back, Share, Favorite overlay)
        Positioned(
          top: MediaQuery.of(context).padding.top + 10.h,
          left: 16.w,
          right: 16.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  height: 38.h,
                  width: 38.w,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.35),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
                ),
              ),
              // Share and Favorite Row
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Share action placeholder
                    },
                    child: Container(
                      height: 38.h,
                      width: 38.w,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.share_outlined, color: Colors.white, size: 20.sp),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  FavoriteButton(
                    productEntity: productEntity,
                    iconSize: 18.sp,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
