// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_application/presentation/wishlist/bloc/wishlist_cubit.dart';
import 'package:e_commerce_application/presentation/wishlist/bloc/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';

class FavoriteButton extends StatelessWidget {
  final ProductEntity productEntity;
  final double iconSize;
  const FavoriteButton({
    super.key,
    required this.productEntity,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<WishlistCubit>().toggleWishlist(productEntity);
      },
      icon: Container(
        height: 40.h,
        width: 40.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: BlocBuilder<WishlistCubit, WishlistState>(
            builder: (context, state) {
          bool isWishlisted = false;
          if (state is WishlistLoaded) {
            isWishlisted = state.wishlistedItems
                .any((p) => p.productId == productEntity.productId);
          }
          return Icon(
            isWishlisted ? Icons.favorite : Icons.favorite_outline,
            size: iconSize,
            color: AppColors.red,
          );
        }),
      ),
    );
  }
}
