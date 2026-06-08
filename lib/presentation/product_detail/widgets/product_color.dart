import 'package:e_commerce_application/presentation/product_detail/bloc/product_color_selection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductColors extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductColors({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;
    final activeRingColor = isDark ? const Color(0xFF14B8A6) : const Color(0xFF4F378A);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 38.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: productEntity.color.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final col = productEntity.color[index];
              // Parse RGB colors
              final r = col.rgb[0].toInt();
              final g = col.rgb[1].toInt();
              final b = col.rgb[2].toInt();
              final dotColor = Color.fromARGB(255, r, g, b);

              return BlocBuilder<ProductColorSelectionCubit, int>(
                builder: (context, selectedIndex) {
                  final isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      context.read<ProductColorSelectionCubit>().itemSelection(index);
                    },
                    child: Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? activeRingColor : Colors.transparent,
                          width: 2.w,
                        ),
                      ),
                      padding: EdgeInsets.all(3.r), // spacing gap for double-ring
                      child: Container(
                        decoration: BoxDecoration(
                          color: dotColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            // Add a subtle border for white color so it stands out on white bg
                            color: (r > 240 && g > 240 && b > 240)
                                ? Colors.grey.shade300
                                : Colors.transparent,
                            width: 1.w,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
