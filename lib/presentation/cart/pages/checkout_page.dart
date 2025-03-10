// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_commerce_application/common/bloc/button/button_state.dart';
// import 'package:e_commerce_application/common/bloc/button/button_state_cubit.dart';
// import 'package:e_commerce_application/common/helper/cart/cart_helper.dart';
// import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
// import 'package:e_commerce_application/common/widgets/app_button/basic_reactive_button.dart';
// import 'package:e_commerce_application/data/order/model/order_registration_req_model.dart';
// import 'package:e_commerce_application/domain/order/entity/order_status_entity.dart';
// import 'package:e_commerce_application/domain/order/usecase/order_registration_usecase.dart';
// import 'package:e_commerce_application/presentation/cart/pages/order_placed_page.dart';
// import 'package:flutter/material.dart';
// import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
// import 'package:e_commerce_application/domain/order/entity/product_ordered_entity.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:uuid/uuid.dart';

// class CheckOutPage extends StatelessWidget {
//   final List<ProductOrderedEntity> products;

//   CheckOutPage({
//     super.key,
//     required this.products,
//   });

//   final TextEditingController _addressCon = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const BasicAppbar(
//         title: Text('Checkout'),
//       ),
//       body: BlocProvider(
//         create: (context) => ButtonStateCubit(),
//         child: BlocListener<ButtonStateCubit, ButtonState>(
//           listener: (context, state) {
//             if (state is ButtonSuccessState) {
//               AppNavigator.pushAndRemove(context, const OrderPlacedPage());
//             }
//             if (state is ButtonFailureState) {
//               var snackbar = SnackBar(
//                 content: Text(state.errorMessage),
//                 behavior: SnackBarBehavior.floating,
//               );
//               ScaffoldMessenger.of(context).showSnackBar(snackbar);
//             }
//           },
//           child: Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Builder(builder: (context) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _addressField(context),
//                   BasicReactiveButton(
//                       content: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 8),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               '\$${CartHelper.calculateCartSubtotal(products)}',
//                               style: const TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16),
//                             ),
//                             const Text(
//                               'Place Order',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 16),
//                             )
//                           ],
//                         ),
//                       ),
//                       onPressed: () {
//                         var uuid = const Uuid();
//                         List<OrderStatusEntity> orderStatusList = [
//                           OrderStatusEntity(
//                               createdDate: Timestamp.fromDate(DateTime.now()),
//                               done: true,
//                               title: 'Order Placed'),
//                           OrderStatusEntity(
//                               createdDate: Timestamp.fromDate(DateTime.now()),
//                               done: false,
//                               title: 'Order Confirmed'),
//                           OrderStatusEntity(
//                               createdDate: Timestamp.fromDate(DateTime.now()),
//                               done: false,
//                               title: 'Shipped'),
//                           OrderStatusEntity(
//                               createdDate: Timestamp.fromDate(DateTime.now()),
//                               done: false,
//                               title: 'Delivered'),
//                         ];
//                         context.read<ButtonStateCubit>().execute(
//                               usecase: OrderRegistrationUseCase(),
//                               params: OrderRegistrationReqModel(
//                                 code: '#${uuid.v4().substring(0, 7)}',
//                                 products: products,
//                                 createdDate: DateTime.now().toString(),
//                                 itemCount: products.length,
//                                 totalPrice:
//                                     CartHelper.calculateCartSubtotal(products),
//                                 shippingAddress: _addressCon.text,
//                                 orderStatus: orderStatusList,
//                               ),
//                             );
//                       })
//                 ],
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _addressField(BuildContext context) {
//     return TextField(
//       controller: _addressCon,
//       minLines: 2,
//       maxLines: 4,
//       decoration: const InputDecoration(hintText: 'Shipping Address'),
//     );
//   }
// }
