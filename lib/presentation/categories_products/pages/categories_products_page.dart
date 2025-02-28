// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:e_commerce_application/common/bloc/product/product_display_state.dart';
// import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
// import 'package:e_commerce_application/common/widgets/product/product_card.dart';
// import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
// import 'package:e_commerce_application/domain/category/entity/category_entity.dart';
// import 'package:e_commerce_application/domain/product/usecase/get_product_by_category_id.dart';
// import 'package:e_commerce_application/service_locator.dart';

// class CategoryProductsPage extends StatelessWidget {
//   final CategoryEntity categoryEntity;

//   const CategoryProductsPage({
//     super.key,
//     required this.categoryEntity,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const BasicAppbar(),
//       body: BlocProvider(
//         create: (context) =>
//             ProductsDisplayCubit(useCase: sl<GetProductsByCategoryIdUseCase>())
//               ..displayProducts(params: categoryEntity.categoryId),
//         child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
//           builder: (context, state) {
//             if (state is ProductsLoading) {
//               return const Center(child: CupertinoActivityIndicator());
//             }
//             if (state is ProductsLoaded) {
//               return Padding(
//                 padding: EdgeInsets.all(16.w),
//                 child: Column(children: [
//                   _categoryInfo(state.products),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   _products(state.products),
//                 ]),
//               );
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }

//   Widget _categoryInfo(List<ProductEntity> products) {
//     return Text(
//       '${categoryEntity.title} (${products.length})',
//       style: const TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: 16,
//       ),
//     );
//   }

//   Widget _products(List<ProductEntity> products) {
//     return Expanded(
//       child: GridView.builder(
//         itemCount: products.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//             childAspectRatio: 0.6),
//         itemBuilder: (BuildContext context, int index) {
//           return ProductCard(productEntity: products[index]);
//         },
//       ),
//     );
//   }
// }
