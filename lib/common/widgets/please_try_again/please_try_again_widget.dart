import 'package:e_commerce_application/common/widgets/app_button/basic_app_button.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PleaseTryAgainWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;
  final bool isFullScreen;

  const PleaseTryAgainWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
    this.isFullScreen = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: isFullScreen ? 80.sp : 40.sp,
              color: AppColors.red,
            ),
            SizedBox(height: isFullScreen ? 20.h : 10.h),
            Text(
              "Something Went Wrong",
              style: AppTextStyles.base.s20.w800,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              errorMessage.isEmpty ? "Please try again later." : errorMessage,
              textAlign: TextAlign.center,
              style: AppTextStyles.base.s16.w500.greyColor,
            ),
            SizedBox(height: isFullScreen ? 30.h : 15.h),
            SizedBox(
              width: isFullScreen
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width / 3,
              height: isFullScreen ? 50.h : 35.h,
              child: BasicAppButton(
                onPressed: onRetry,
                title: "Retry",
              ),
            ),
          ],
        ),
      ),
    );

    if (isFullScreen) {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: content,
      );
    }

    return content;
  }
}
