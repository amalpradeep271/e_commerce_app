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
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          productHeading,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        TextButton(
          onPressed: allProductClick,
          child: Text(
            "See All",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }
}
