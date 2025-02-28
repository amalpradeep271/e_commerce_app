// import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
// import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
// import 'package:e_commerce_application/presentation/product_detail/bloc/product_color_selection_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ProductColors extends StatelessWidget {
//   final ProductEntity productEntity;
//   const ProductColors({required this.productEntity, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height / 2,
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: AppColors.background,
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(16.r),
//           topLeft: Radius.circular(16.r),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: 40.h,
//             child: Stack(
//               children: [
//                 const Center(
//                   child: Text(
//                     'Color',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(Icons.close)),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 20.h,
//           ),
//           Expanded(
//             child: ListView.separated(
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 return BlocBuilder<ProductColorSelectionCubit, int>(
//                   builder: (context, state) => GestureDetector(
//                     onTap: () {
//                       context
//                           .read<ProductColorSelectionCubit>()
//                           .itemSelection(index);
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       height: 60.h,
//                       padding: EdgeInsets.symmetric(horizontal: 16.w),
//                       decoration: BoxDecoration(
//                         color: state == index
//                             ? AppColors.primary
//                             : AppColors.secondBackground,
//                         borderRadius: BorderRadius.circular(50.r),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             productEntity.color[index].title,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16),
//                           ),
//                           Row(
//                             children: [
//                               Container(
//                                 height: 20.h,
//                                 width: 20.w,
//                                 decoration: BoxDecoration(
//                                   color: Color.fromRGBO(
//                                       productEntity.color[index].rgb[0].toInt(),
//                                       productEntity.color[index].rgb[1].toInt(),
//                                       productEntity.color[index].rgb[2].toInt(),
//                                       1),
//                                   shape: BoxShape.circle,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 15.w,
//                               ),
//                               state == index
//                                   ? const Icon(
//                                       Icons.check,
//                                       size: 30,
//                                     )
//                                   : Container(
//                                       width: 30.w,
//                                     )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               separatorBuilder: (context, index) => SizedBox(
//                 height: 20.h,
//               ),
//               itemCount: productEntity.color.length,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
