// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:e_commerce_application/common/bloc/button/favourite_icon_cubit.dart';
import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
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
        context.read<FavoriteIconCubit>().onTap(productEntity);
        context
            .read<ProductsDisplayCubit>()
            .displayProducts(showLoading: false);
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
            size: iconSize,
            color: AppColors.red,
          ),
        ),
      ),
    );
  }
}
