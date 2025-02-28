// import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
// import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
// import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
// import 'package:e_commerce_application/domain/order/entity/order_entity.dart';
// import 'package:e_commerce_application/presentation/settings/bloc/order_display_cubit.dart';
// import 'package:e_commerce_application/presentation/settings/bloc/order_display_state.dart';
// import 'package:e_commerce_application/presentation/settings/pages/order_detail_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class MyOrdersPage extends StatelessWidget {
//   const MyOrdersPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: const BasicAppbar(
//           title: Text('My Orders'),
//         ),
//         body: BlocProvider(
//             create: (context) => OrdersDisplayCubit()..displayOrders(),
//             child: BlocBuilder<OrdersDisplayCubit, OrdersDisplayState>(
//               builder: (context, state) {
//                 if (state is OrdersLoading) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 if (state is OrdersLoaded) {
//                   return _orders(state.orders);
//                 }

//                 if (state is LoadOrdersFailure) {
//                   return Center(
//                     child: Text(state.errorMessage),
//                   );
//                 }
//                 return Container();
//               },
//             )));
//   }

//   Widget _orders(List<OrderEntity> orders) {
//     return ListView.separated(
//         padding: const EdgeInsets.all(16),
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               AppNavigator.push(
//                   context,
//                   OrderDetailPage(
//                     orderEntity: orders[index],
//                   ));
//             },
//             child: Container(
//               height: 70,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               decoration: BoxDecoration(
//                   color: AppColors.secondBackground,
//                   borderRadius: BorderRadius.circular(10)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       const Icon(Icons.receipt_rounded),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Order #${orders[index].code}',
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w400, fontSize: 16),
//                           ),
//                           Text(
//                             '${orders[index].products.length} item',
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 12,
//                                 color: Colors.grey),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                   const Icon(Icons.arrow_forward_ios_rounded)
//                 ],
//               ),
//             ),
//           );
//         },
//         separatorBuilder: (context, index) => const SizedBox(
//               height: 20,
//             ),
//         itemCount: orders.length);
//   }
// }
