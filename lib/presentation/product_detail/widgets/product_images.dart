// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImages extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductImages({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.h,
      child: ListView.separated(
        padding: EdgeInsets.all(8.0.w),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 200.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  ImageDisplayHelper.generateSingleProductImageURL(
                    productEntity.images[index],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: productEntity.images.length,
        separatorBuilder: (_, index) => SizedBox(
          width: 10.w,
        ),
      ),
    );
  }
}
