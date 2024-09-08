import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter/material.dart';

class AddToCart extends StatelessWidget {
  final ProductEntity productEntity;
  const AddToCart({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return
        // BlocListener<ButtonStateCubit,ButtonState>(
        //   listener: (context, state) {
        //     if (state is ButtonSuccessState) {
        //       AppNavigator.push(context, const CartPage());
        //     }
        //     if (state is ButtonFailureState) {
        //       var snackbar = SnackBar(content: Text(state.errorMessage),behavior: SnackBarBehavior.floating,);
        //       ScaffoldMessenger.of(context).showSnackBar(snackbar);
        //     }
        //   },
        //   child:
        Padding(
      padding: const EdgeInsets.all(16),
      child:
          //  BasicReactiveButton(
          //     onPressed: () {
          //   context.read<ButtonStateCubit>().execute(
          //     usecase: AddToCartUseCase(),
          //     params: AddToCartReq(
          //       productId: productEntity.productId,
          //       productTitle: productEntity.title,
          //       productQuantity: context.read<ProductQuantityCubit>().state,
          //       productColor: productEntity.colors[context.read<ProductColorSelectionCubit>().selectedIndex].title,
          //       productSize: productEntity.sizes[context.read<ProductSizeSelectionCubit>().selectedIndex],
          //       productPrice: productEntity.price.toDouble(),
          //       totalPrice: ProductPriceHelper.provideCurrentPrice(productEntity) * context.read<ProductQuantityCubit>().state,
          //       productImage: productEntity.images[0],
          //       createdDate: DateTime.now().toString()
          //     )
          //  );
          // },
          // content:
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // BlocBuilder<ProductQuantityCubit,int>(
          //   builder: (context, state) {
          //   var price = ProductPriceHelper.provideCurrentPrice(productEntity) * state;
          //   return
          Text(
            '1',
            //  "\$${price.toString()}",
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14),
          ),
          //  );
          // },

          const Text(
            'Add to Bag',
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
    // );
    // );
  }
}
