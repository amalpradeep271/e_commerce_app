import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductGridShimmer extends StatelessWidget {
  final int itemCount;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final double? height;

  const ProductGridShimmer({
    super.key,
    this.itemCount = 2,
    this.physics = const NeverScrollableScrollPhysics(),
    this.shrinkWrap = true,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    Widget grid = GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10.0,
        mainAxisExtent: 300,
      ),
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemCount: itemCount,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 218, 221, 227),
        highlightColor: AppColors.colorDivider,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );

    if (height != null || shrinkWrap) {
      return SizedBox(
        height: height ?? 280.h,
        child: grid,
      );
    }

    return grid;
  }
}
