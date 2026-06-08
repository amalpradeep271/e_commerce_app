import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_icons.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    Color? backgroundColor,
    bool? searchBox,
    Color? leadingIconColor,
    Color? actionIconColor,
    double? elevation,
    String? title,
    Color? titleColor,
    double? titleSize,
    IconData? leadingIconData,
    IconData? actionIconData1,
    IconData? actionIconData2,
    IconData? actionIconData3,
    VoidCallback? onLeadingPressed,
    VoidCallback? onAction1Pressed,
    VoidCallback? onAction2Pressed,
    VoidCallback? onAction3Pressed,
    double? actionIcon1Size,
    double? actionIcon2Size,
    double? leadingIconSize,
    double? actionIcon3Size,
    void Function()? onPressed,
    void Function()? onTap,
    int? itemcount,
    bool? isLoading,
    int? notificationBadge,
    int? cartBadge,
  }) : super(
          titleSpacing: 0,
          centerTitle: true,
          backgroundColor: backgroundColor ?? AppColors.cream,
          elevation: elevation ?? 0,
          title: title != null
              ? Builder(
                  builder: (context) {
                    final isDark = Theme.of(context).brightness == Brightness.dark;
                    // Brand teal title colors matching light vs dark screen designs
                    final titleThemeColor = isDark ? const Color(0xFF14B8A6) : const Color(0xFF006970);
                    return Text(
                      title,
                      style: TextStyle(
                        fontSize: titleSize ?? 20.sp,
                        fontWeight: FontWeight.bold,
                        color: titleColor ?? titleThemeColor,
                      ),
                    );
                  }
                )
              : searchBox == true
                  ? SizedBox(
                      width: 250.w,
                      child: GestureDetector(
                        onTap: onTap,
                        child: TextFormField(
                          enabled: false,
                          cursorHeight: 16,
                          cursorWidth: 1,
                          decoration: InputDecoration(
                            fillColor: AppColors.whiteGrey.withAlpha(127),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5)),
                            contentPadding:
                                const EdgeInsets.only(bottom: 7, left: 15),
                            hintText: "Search",
                            hintStyle: AppTextStyles.getAppTextStyleCustomized(
                                textWeight: FontWeight.w400,
                                textColor: AppColors.black.withAlpha(128),
                                textSize: 14.sp),
                            suffixIcon: const Icon(
                              AppIcons.search,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  : null,
          actions: [
            if (actionIconData1 != null)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: _buildBadgeIcon(
                  icon: actionIconData1,
                  badgeCount: notificationBadge,
                  color: actionIconColor ?? AppColors.black,
                  size: actionIcon1Size ?? 22.0,
                  onPressed: onAction1Pressed,
                ),
              ),
            if (actionIconData3 != null)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: _buildBadgeIcon(
                  icon: actionIconData3,
                  badgeCount: null,
                  color: actionIconColor ?? AppColors.red,
                  size: actionIcon2Size ?? 22.0,
                  onPressed: onAction3Pressed,
                ),
              ),
            if (actionIconData2 != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _buildBadgeIcon(
                  icon: actionIconData2,
                  badgeCount: cartBadge,
                  color: actionIconColor ?? AppColors.black,
                  size: actionIcon2Size ?? 22.0,
                  onPressed: onAction2Pressed,
                ),
              ),
          ],
          leading: leadingIconData != null
              ? IconButton(
                  onPressed: onLeadingPressed,
                  icon: Icon(
                    leadingIconData,
                    color: leadingIconColor ?? AppColors.black,
                    size: leadingIconSize ?? 22.0,
                  ),
                )
              : null,
        );

  static Widget _buildBadgeIcon({
    required IconData icon,
    required int? badgeCount,
    required Color color,
    required double size,
    required VoidCallback? onPressed,
  }) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: color,
            size: size,
          ),
        ),
        if (badgeCount != null && badgeCount > 0)
          Positioned(
            top: 4.h,
            right: 4.w,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              constraints: BoxConstraints(
                minWidth: 14.w,
                minHeight: 14.h,
              ),
              child: Text(
                '$badgeCount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 7.5.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
