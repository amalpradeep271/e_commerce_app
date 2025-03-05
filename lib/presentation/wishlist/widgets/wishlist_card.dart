import 'package:e_commerce_application/common/bloc/button/favourite_icon_cubit.dart';
import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_icons.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCard extends StatelessWidget {
  const WishlistCard({
    super.key,

    // required this.rating,
    required this.productEntity,
    // required this.onTap,
  });
  final ProductEntity productEntity;

  // final double rating;
  // final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.productGray,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height / 5,
                      decoration: BoxDecoration(
                        color: AppColors.productGray,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Image.network(
                        ImageDisplayHelper.generateProductImageURL(
                          productEntity.images[0],
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productEntity.title,
                        style: AppTextStyles.base.w500.s16,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "₹${productEntity.price}",
                        style: AppTextStyles.base.w700.s20,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // RatingBarIndicator(
                      //   itemBuilder: (context, index) => const Icon(
                      //     Icons.star,
                      //     color: AppColors.kPrimaryColor,
                      //   ),
                      //   itemCount: 5,
                      //   itemSize: 17,
                      //   direction: Axis.horizontal,
                      //   rating: rating,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              color: AppColors.productGray,
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    AppIcons.delete,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      context.read<FavoriteIconCubit>().onTap(productEntity);
                    },
                    child: const Text("Remove"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
