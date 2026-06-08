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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Widget grid = GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        mainAxisExtent: 240.h,
      ),
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemCount: itemCount,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        highlightColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
    );

    if (height != null || shrinkWrap) {
      return SizedBox(
        height: height ?? 240.h,
        child: grid,
      );
    }

    return grid;
  }
}
