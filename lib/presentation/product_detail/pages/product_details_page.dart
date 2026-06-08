import 'package:e_commerce_application/common/bloc/button/button_state_cubit.dart';
import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_state.dart';
import 'package:e_commerce_application/common/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:e_commerce_application/presentation/cart/bloc/cart_status_cubit.dart';
import 'package:e_commerce_application/presentation/product_detail/bloc/product_color_selection_cubit.dart';
import 'package:e_commerce_application/presentation/product_detail/bloc/product_image_view_cubit.dart';
import 'package:e_commerce_application/presentation/product_detail/bloc/product_quanitity_cubit.dart';
import 'package:e_commerce_application/presentation/product_detail/bloc/product_size_selection_cubit.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/add_to_cart.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/product_color.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/product_images.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/product_informations.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/product_quantity.dart';
import 'package:e_commerce_application/presentation/product_detail/widgets/product_sizes.dart';
import 'package:e_commerce_application/presentation/review/widget/review_form.dart';
import 'package:e_commerce_application/presentation/wishlist/bloc/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailsPage({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;
    final activeThemeColor = isDark ? const Color(0xFF14B8A6) : const Color(0xFF006970);
    final scaffoldBg = isDark ? const Color(0xFF0F172A) : Colors.white;
    final detailsCardBg = isDark ? const Color(0xFF1E293B) : Colors.white;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductImageViewCubit(),
        ),
        BlocProvider(create: (context) => ProductQuantityCubit()),
        BlocProvider(create: (context) => ProductSizeSelectionCubit()),
        BlocProvider(create: (context) => ProductColorSelectionCubit()),
        BlocProvider(create: (context) => ButtonStateCubit()),
        BlocProvider(create: (context) => CartStatusCubit()),
        BlocProvider(create: (context) => WishlistCubit()..loadWishlist()),
      ],
      child: BlocBuilder<ConnectivityCubit, ConnectivityState>(
        builder: (context, state) {
          if (state is ConnectivityDisconnected) {
            return const NoInternetScreen();
          }
          return Scaffold(
            backgroundColor: scaffoldBg,
            // bottomNavigationBar persistent container
            bottomNavigationBar: AddToCart(
              productEntity: productEntity,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // Product image slider & custom overlay floating action buttons
                  ProductImages(productEntity: productEntity),
                  
                  // Product details card/sheet with rounded corners
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: detailsCardBg,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                      boxShadow: [
                        if (!isDark)
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, -4),
                          ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left-Column (Title/Rating) & Right-Column (Price/Discount) Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Left Side: Title and Rating
                            Expanded(
                              flex: 12,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productEntity.title,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.amber, size: 14.sp),
                                      SizedBox(width: 4.w),
                                      Text(
                                        productEntity.rating.toStringAsFixed(1),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          color: colorScheme.onSurface,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        "(${productEntity.ratingCount} reviews)",
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: colorScheme.outline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.w),
                            // Right Side: Price Details
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Current Price
                                Text(
                                  productEntity.discountPrice != 0
                                      ? "\$${productEntity.discountPrice.toStringAsFixed(2)}"
                                      : "\$${productEntity.price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w800,
                                    color: activeThemeColor,
                                  ),
                                ),
                                if (productEntity.discountPrice != 0) ...[
                                  SizedBox(height: 4.h),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "\$${productEntity.price.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: colorScheme.outline,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                      SizedBox(width: 6.w),
                                      // Discount percentage badge
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(4.r),
                                        ),
                                        child: Text(
                                          "${((productEntity.price - productEntity.discountPrice) / productEntity.price * 100).round()}% OFF",
                                          style: TextStyle(
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                        
                        Divider(height: 32.h, color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
                        
                        // Color Selection Row
                        ProductColors(productEntity: productEntity),
                        
                        SizedBox(height: 16.h),
                        
                        // Size Selection Row
                        ProductSizes(productEntity: productEntity),
                        
                        SizedBox(height: 16.h),
                        
                        // Quantity Selection Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Quantity",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            ProductQuantity(productEntity: productEntity),
                          ],
                        ),
                        
                        Divider(height: 32.h, color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
                        
                        // Description Header & Content
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          productEntity.description,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: colorScheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                        ),
                        
                        SizedBox(height: 24.h),
                        
                        // Collapsible Information panels
                        DropDownWidget(
                          heading: "Manufacturer Information",
                          collapsedtext: "",
                          expandedtext: productEntity.manufactureInformation,
                        ),
                        SizedBox(height: 8.h),
                        const DropDownWidget(
                          heading: "Disclaimer",
                          collapsedtext: "",
                          expandedtext:
                              "The image is for representation purposes only. The packaging you receive might vary.",
                        ),
                        SizedBox(height: 8.h),
                        DropDownWidget(
                          heading: "Product Dimensions",
                          collapsedtext: "",
                          expandedtext: productEntity.dimensions,
                        ),
                        
                        Divider(height: 32.h, color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
                        
                        // Reviews block
                        BlocProvider(
                          create: (context) => ButtonStateCubit(),
                          child: ReviewForm(productEntity: productEntity),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
