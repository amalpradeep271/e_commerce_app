import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // appBar: const BasicAppbar(
        //   title: Text('Cart'),
        // ),
        body: Center(
      child: Text("CartPage"),
    )
        //  BlocProvider(
        //   create: (context) => CartProductsDisplayCubit()..displayCartProducts(),
        //   child: BlocBuilder<CartProductsDisplayCubit, CartProductsDisplayState>(
        //     builder: (context, state) {
        //       if (state is CartProductsLoading) {
        //         return const Center(
        //           child: CupertinoActivityIndicator(),
        //         );
        //       }
        //       if (state is CartProductsLoaded) {
        //         return state.products.isEmpty
        //             ? Center(child: _cartIsEmpty())
        //             : Stack(
        //                 children: [
        //                   _products(state.products),
        //                   Align(
        //                       alignment: Alignment.bottomCenter,
        //                       child: Checkout(
        //                         products: state.products,
        //                       ))
        //                 ],
        //               );
        //       }
        //       if (state is LoadCartProductsFailure) {
        //         return Center(
        //           child: Text(state.errorMessage),
        //         );
        //       }
        //       return Container();
        //     },
        //   ),
        // ),
        );
  }

  // Widget _products(List<ProductOrderedEntity> products) {
  //   return ListView.separated(
  //     padding: EdgeInsets.all(16.w),
  //     itemBuilder: (context, index) {
  //       return ProductOrderedCard(
  //         productOrderedEntity: products[index],
  //       );
  //     },
  //     separatorBuilder: (context, index) => SizedBox(
  //       height: 10.h,
  //     ),
  //     itemCount: products.length,
  //   );
  // }

  // Widget _cartIsEmpty() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       SvgPicture.asset(AppVectors.cartBag),
  //       SizedBox(
  //         height: 20.h,
  //       ),
  //       const Text(
  //         "Cart is empty",
  //         textAlign: TextAlign.center,
  //         style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
  //       )
  //     ],
  //   );
  // }
}
