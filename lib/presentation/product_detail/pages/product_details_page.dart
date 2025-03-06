import 'package:e_commerce_application/common/bloc/button/button_state_cubit.dart';
import 'package:e_commerce_application/presentation/product_detail/bloc/product_image_view_cubit.dart';
import 'package:e_commerce_application/presentation/product_detail/bloc/product_quanitity_cubit.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/add_to_cart.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/product_color.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/product_images.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/product_informations.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/product_price.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/product_quantity.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/product_sizes.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/product_title.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/ratingbar_indicator.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailsPage({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductImageViewCubit(),
        ),
        BlocProvider(create: (context) => ProductQuantityCubit()),
        // BlocProvider(create: (context) => ProductSizeSelectionCubit()),
        BlocProvider(create: (context) => ButtonStateCubit()),
        // BlocProvider(
        //     create: (context) =>
        //         FavoriteIconCubit()..isFavorite(productEntity.productId)),
      ],
      child: Scaffold(
        // appBar: BasicAppbar(
        //   hideBack: false,
        //   action: FavoriteButton(
        //     productEntity: productEntity,
        //   ),
        // ),
        bottomNavigationBar: AddToCart(
          productEntity: productEntity,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImages(productEntity: productEntity),

                  ProductTitle(productEntity: productEntity),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProductPrice(productEntity: productEntity),
                      ProductQuantity(productEntity: productEntity),
                    ],
                  ),
                  const RatingBars(rating: 3),

                  ProductColors(productEntity: productEntity),
                  ProductSizes(productEntity: productEntity),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    productEntity.description,
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  DropDownWidget(
                    heading: "Manufacturer Information",
                    collapsedtext: "",
                    expandedtext: productEntity.manufactureInformation,
                  ),
                  const DropDownWidget(
                    heading: "Disclaimer",
                    collapsedtext: "",
                    expandedtext:
                        "The image is for representation purposes only. The packaging you receive might vary.",
                  ),
                  DropDownWidget(
                    heading: "Product Dimensions",
                    collapsedtext: "",
                    expandedtext: productEntity.dimensions,
                  ),

                  // Text(
                  //   "Reviews",
                  //   style: AppTextStyles.base.s16.w600,
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // RatingBar.builder(
                  //   itemBuilder: (context, index) {
                  //     return const Icon(
                  //       Icons.star,
                  //       size: 10,
                  //       color: AppColors.kPrimaryColor,
                  //     );
                  //   },
                  //   onRatingUpdate: (rating) {
                  //     controller.changerating(rating);
                  //   },
                  //   itemCount: 5,
                  //   minRating: 1,
                  //   initialRating: controller.initialRating,
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Form(
                  //   key: controller.reviewValidator,
                  //   child: TextFormField(
                  //     controller: controller.reviewcontroller,
                  //     maxLines: 5,
                  //     keyboardType: TextInputType.multiline,
                  //     decoration: const InputDecoration(
                  //         border: OutlineInputBorder(),
                  //         hintText:
                  //             "Share the details of your own experience on this product"),
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return 'cannot post empty review type something';
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     GestureDetector(
                  //         onTap: () {
                  //           if (controller.reviewValidator.currentState!
                  //               .validate()) {
                  //             controller.addReview(controller
                  //                 .productviewmodel
                  //                 .value
                  //                 .variants!
                  //                 .productId!
                  //                 .toInt());
                  //           }
                  //         },
                  //         child: Text("Submit",
                  //             style: AppTextStyles.base.accountblue.s14)),
                  //     const Icon(
                  //       Khadi.success,
                  //       color: AppColors.accountblue,
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  // controller.productviewmodel.value.variants!.product!
                  //         .reviews!.isEmpty
                  //     ? const SizedBox()
                  //     : reviewbody(),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.toNamed(
                  //       AppRoutes.reviewscreen,
                  //       arguments: controller
                  //           .productviewmodel.value.variants!.productId!,
                  //     );
                  //   },
                  //   child: controller.productviewmodel.value.variants!
                  //           .product!.reviews!.isEmpty
                  //       ? const SizedBox()
                  //       : Row(
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           children: [
                  //             const Icon(
                  //               Khadi.success,
                  //               color: AppColors.accountblue,
                  //             ),
                  //             Text(
                  //               "View All",
                  //               style: AppTextStyles.base.accountblue.s14,
                  //             ),
                  //           ],
                  //         ),
                  // ),
                  // Text(
                  //   "Featured Products",
                  //   style: AppTextStyles.base.s16.w600,
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // controller.productviewmodel.value.similarProducts!.isEmpty
                  //     ? const SizedBox()
                  //     : featuredproductbody(),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
