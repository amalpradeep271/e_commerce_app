// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:e_commerce_application/common/bloc/button/button_state_cubit.dart';
// import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
// import 'package:e_commerce_application/presentation/product_detail/bloc/favourite_icon_cubit.dart';
// import 'package:e_commerce_application/presentation/product_detail/bloc/product_color_selection_cubit.dart';
// import 'package:e_commerce_application/presentation/product_detail/bloc/product_quanitity_cubit.dart';
// import 'package:e_commerce_application/presentation/product_detail/bloc/product_size_selection_cubit.dart';
// import 'package:e_commerce_application/presentation/product_detail/widgets/add_to_cart.dart';
// import 'package:e_commerce_application/presentation/product_detail/widgets/favourite_button.dart';
// import 'package:e_commerce_application/presentation/product_detail/widgets/product_images.dart';
// import 'package:e_commerce_application/presentation/product_detail/widgets/product_price.dart';
// import 'package:e_commerce_application/presentation/product_detail/widgets/product_quantity.dart';
// import 'package:e_commerce_application/presentation/product_detail/widgets/product_title.dart';
// import 'package:e_commerce_application/presentation/product_detail/widgets/selected_color.dart';
// import 'package:e_commerce_application/presentation/product_detail/widgets/selected_size.dart';
// import 'package:flutter/material.dart';

// import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ProductDetailsPage extends StatelessWidget {
//   final ProductEntity productEntity;
//   const ProductDetailsPage({
//     super.key,
//     required this.productEntity,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => ProductQuantityCubit()),
//         BlocProvider(create: (context) => ProductColorSelectionCubit()),
//         BlocProvider(create: (context) => ProductSizeSelectionCubit()),
//         BlocProvider(create: (context) => ButtonStateCubit()),
//         BlocProvider(create: (context) => FavoriteIconCubit()..isFavorite(productEntity.productId)),
//       ],
//       child: Scaffold(
//         appBar: BasicAppbar(
//           hideBack: false,
//           action: FavoriteButton(
//             productEntity: productEntity,
//           ),
//         ),
//         bottomNavigationBar: AddToCart(
//           productEntity: productEntity,
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ProductImages(productEntity: productEntity),
//               SizedBox(
//                 height: 10.h,
//               ),
//               ProductTitle(
//                 productEntity: productEntity,
//               ),
//               SizedBox(
//                 height: 5.h,
//               ),
//               ProductPrice(
//                 productEntity: productEntity,
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               SelectedSize(
//                 productEntity: productEntity,
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               SelectedColor(
//                 productEntity: productEntity,
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               ProductQuantity(
//                 productEntity: productEntity,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
