import 'package:e_commerce_application/common/widgets/app_button/basic_app_button.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonTitle;
  final VoidCallback onRefresh;
  final Widget? icon;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.buttonTitle = "Refresh",
    required this.onRefresh,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon ??
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 80.sp,
                  color: Colors.grey.shade400,
                ),
            SizedBox(height: 20.h),
            Text(
              title,
              style: AppTextStyles.base.w600.s20,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.base.s16.w500.greyColor,
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 50.h,
              child: BasicAppButton(
                onPressed: onRefresh,
                title: buttonTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
