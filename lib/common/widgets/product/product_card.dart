import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/common/widgets/app_button/favourite_button.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/common/bloc/button/favourite_icon_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.productEntity,
  });
  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavoriteIconCubit()..isFavorite(productEntity.productId),
      child: Stack(
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
                        style:
                            AppTextStyles.base.s15.greyColor.w300.lineThrough,
                      ),
                    ],
                  )
                ],
              )),
          Align(
            alignment: Alignment.topRight,
            child: FavoriteButton(
              productEntity: productEntity,
            ),
          )
        ],
      ),
    );
  }
}
