import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/presentation/product_detail/bloc/product_image_view_cubit.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImages extends StatelessWidget {
  final ProductEntity productEntity;
  final CarouselSliderController carosuelController =
      CarouselSliderController();

  ProductImages({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            BlocBuilder<ProductImageViewCubit, int>(
              builder: (context, selectedIndex) {
                return CarouselSlider.builder(
                  carouselController: carosuelController,
                  itemCount: productEntity.images.length,
                  itemBuilder: (context, index, _) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: SizedBox(
                        height: 250,
                        width: 300,
                        child: Image.network(
                          ImageDisplayHelper.generateSingleProductImageURL(
                            productEntity.images[index],
                          ),
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, _) {
                            return const Text("Image not available");
                          },
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    initialPage: selectedIndex,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    autoPlay: false,
                    height: 300,
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    onPageChanged: (index, _) {
                      context
                          .read<ProductImageViewCubit>()
                          .selectImage(index); // Sync state
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 10.h),
            BlocBuilder<ProductImageViewCubit, int>(
              builder: (context, selectedIndex) {
                return SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: productEntity.images.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              context
                                  .read<ProductImageViewCubit>()
                                  .selectImage(index);
                              carosuelController
                                  .animateToPage(index); // Update carousel
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: selectedIndex == index
                                      ? AppColors.kPrimaryColor
                                      : AppColors.transparent,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      ImageDisplayHelper
                                          .generateSingleProductImageURL(
                                        productEntity.images[index],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
        // Padding(
        //   padding: const EdgeInsets.only(right: 15, top: 15),
        //   child: Align(
        //     alignment: Alignment.topRight,
        //     child: FavoriteButton(
        //       iconSize: 40.sp,
        //       productEntity: productEntity,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
