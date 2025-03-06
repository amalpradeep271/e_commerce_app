import 'package:e_commerce_application/common/bloc/button/button_state.dart';
import 'package:e_commerce_application/common/bloc/button/button_state_cubit.dart';
import 'package:e_commerce_application/common/helper/product/product_price.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_reactive_button.dart';
import 'package:e_commerce_application/data/order/model/add_to_cart_req_model.dart';
import 'package:e_commerce_application/domain/order/usecase/add_to_cart_usecase.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/presentation/product_detail/bloc/product_color_selection_cubit.dart';
import 'package:e_commerce_application/presentation/product_detail/bloc/product_quanitity_cubit.dart';
import 'package:e_commerce_application/presentation/product_detail/bloc/product_size_selection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCart extends StatelessWidget {
  final ProductEntity productEntity;
  const AddToCart({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ButtonStateCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonSuccessState) {
            // AppNavigator.push(context, const CartPage());
          }
          if (state is ButtonFailureState) {
            var snackbar = SnackBar(
              content: Text(state.errorMessage),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BasicReactiveButton(
            onPressed: () {
              context.read<ButtonStateCubit>().execute(
                    usecase: AddToCartUseCase(),
                    params: AddToCartReq(
                      productId: productEntity.productId,
                      productTitle: productEntity.title,
                      productQuantity:
                          context.read<ProductQuantityCubit>().state,
                      productColor: productEntity
                          .color[context
                              .read<ProductColorSelectionCubit>()
                              .selectedIndex]
                          .title,
                      productSize: productEntity.sizes[context
                          .read<ProductSizeSelectionCubit>()
                          .selectedIndex],
                      productPrice: productEntity.price.toDouble(),
                      discountPrice: productEntity.discountPrice.toDouble(),
                      totalPrice: ProductPriceHelper.provideCurrentPrice(
                              productEntity) *
                          context.read<ProductQuantityCubit>().state,
                      productImage: productEntity.images[0],
                      createdDate: DateTime.now().toString(),
                    ),
                  );
            },
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<ProductQuantityCubit, int>(
                  builder: (context, state) {
                    var price =
                        ProductPriceHelper.provideCurrentPrice(productEntity) *
                            state;

                    return Text(
                      "₹ $price",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14),
                    );
                  },
                ),
                const Text(
                  'Add to Cart',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 14),
                ),
              ],
            ),
          ),
        ));
  }
}
