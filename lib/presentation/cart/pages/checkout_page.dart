import 'package:e_commerce_application/common/bloc/button/button_state_cubit.dart';
import 'package:e_commerce_application/common/helper/cart/cart_helper.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_reactive_button.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/domain/cart/entity/product_ordered_entity.dart';
import 'package:e_commerce_application/presentation/cart/bloc/payment_cubit.dart';
import 'package:e_commerce_application/presentation/cart/bloc/payment_state.dart';
import 'package:e_commerce_application/presentation/cart/pages/order_placed_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckOutPage extends StatelessWidget {
  final List<ProductOrderedEntity> products;
  final dynamic shipping;
  final dynamic tax;

  CheckOutPage({
    super.key,
    required this.products,
    required this.shipping,
    required this.tax,
  });

  final TextEditingController _addressCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Checkout'),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ButtonStateCubit()),
          BlocProvider(create: (context) => PaymentCubit()),
        ],
        child: BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              context.read<PaymentCubit>().placeOrder(
                    shippingAddress: _addressCon.text,
                    products: products,
                    shipping: shipping,
                    tax: tax,
                  );
            } else if (state is PaymentFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            } else if (state is OrderPlacedSuccessfully) {
              AppNavigator.pushAndRemove(context, const OrderPlacedPage());
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _addressField(),
                  BasicReactiveButton(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹ ${CartHelper.calculateCartSubtotal(products) + shipping + tax}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Text(
                          'Place Order',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      if (_addressCon.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Enter shipping address')),
                        );
                        return;
                      }

                      context.read<PaymentCubit>().makePayment(
                            amount: CartHelper.calculateCartSubtotal(products) +
                                shipping +
                                tax,
                            shippingAddress: _addressCon.text,
                            products: products,
                            shipping: shipping,
                            tax: tax,
                          );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _addressField() {
    return TextField(
      controller: _addressCon,
      minLines: 2,
      maxLines: 4,
      decoration: const InputDecoration(hintText: 'Shipping Address'),
    );
  }
}
