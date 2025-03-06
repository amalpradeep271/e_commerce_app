import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/presentation/product_detail/bloc/product_quanitity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductQuantity extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductQuantity({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                context.read<ProductQuantityCubit>().decrement();
              },
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.grey)),
                child: const Center(
                  child: Icon(
                    Icons.remove,
                    size: 25,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            BlocBuilder<ProductQuantityCubit, int>(
              builder: (context, state) => Text(
                state.toString(),
                style: AppTextStyles.base.w900.s18,
              ),
            ),
            SizedBox(width: 10.w),
            InkWell(
              onTap: () {
                context.read<ProductQuantityCubit>().increment();
              },
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.grey)),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    size: 25,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
