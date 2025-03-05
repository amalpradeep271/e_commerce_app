import 'package:e_commerce_application/common/bloc/button/favourite_icon_cubit.dart';
import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteButton extends StatelessWidget {
  final ProductEntity productEntity;
  const FavoriteButton({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<FavoriteIconCubit>().onTap(productEntity);
        context
            .read<ProductsDisplayCubit>()
            .displayProducts(showLoading: false); // Force update
      },
      icon: Container(
        height: 40.h,
        width: 40.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: BlocBuilder<FavoriteIconCubit, bool>(
          builder: (context, state) => Icon(
            state ? Icons.favorite : Icons.favorite_outline,
            size: 18,
            color: AppColors.red,
          ),
        ),
      ),
    );
  }
}
