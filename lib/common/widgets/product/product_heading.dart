import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductHeading extends StatelessWidget {
  const ProductHeading({
    super.key,
    required this.productHeading,
    required this.allProductClick,
  });

  final String productHeading;
  final VoidCallback allProductClick;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;
    final seeAllColor =
        isDark ? const Color(0xFF14B8A6) : const Color(0xFF006970);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          productHeading,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        TextButton(
          onPressed: allProductClick,
          child: Text(
            "See All",
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: seeAllColor,
            ),
          ),
        )
      ],
    );
  }
}
