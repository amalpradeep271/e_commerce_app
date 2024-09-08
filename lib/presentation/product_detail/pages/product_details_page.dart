// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/add_to_cart.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/favourite_button.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/product_images.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/product_price.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/product_quantity.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/product_title.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/selected_color.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/selected_size.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailsPage({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        hideBack: false,
        action: FavoriteButton(
          productEntity: productEntity,
        ),
      ),
      bottomNavigationBar: AddToCart(
        productEntity: productEntity,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImages(productEntity: productEntity),
            SizedBox(
              height: 10.h,
            ),
            ProductTitle(
              productEntity: productEntity,
            ),
            SizedBox(
              height: 10.h,
            ),
            ProductPrice(
              productEntity: productEntity,
            ),
            SizedBox(
              height: 20.h,
            ),
            SelectedSize(
              productEntity: productEntity,
            ),
            const SizedBox(
              height: 15,
            ),
            SelectedColor(
              productEntity: productEntity,
            ),
            const SizedBox(
              height: 15,
            ),
            ProductQuantity(
              productEntity: productEntity,
            ),
          ],
        ),
      ),
    );
  }
}
