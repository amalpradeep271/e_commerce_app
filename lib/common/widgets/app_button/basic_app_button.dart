import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Widget? content;
  final double? height;
  final double? width;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;

  const BasicAppButton({
    required this.onPressed,
    this.title = '',
    this.height,
    this.width,
    this.content,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Resolve dimensions strictly to prevent layout shift during loading
    final buttonHeight = height ?? 50.h;
    final buttonWidth = width ?? MediaQuery.of(context).size.width.w;
    
    // Resolve theme-based colors
    final defaultBg = AppColors.getPrimary(context);
    final defaultText = theme.brightness == Brightness.dark ? Colors.black : Colors.white;

    final resolvedBg = backgroundColor ?? defaultBg;
    final resolvedText = textColor ?? defaultText;

    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: (isLoading || onPressed == null) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: resolvedBg,
          foregroundColor: resolvedText,
          disabledBackgroundColor: resolvedBg.withValues(alpha: 0.6),
          disabledForegroundColor: resolvedText.withValues(alpha: 0.6),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(resolvedText),
                  ),
                ),
              )
            : content ??
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: resolvedText,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
      ),
    );
  }
}
