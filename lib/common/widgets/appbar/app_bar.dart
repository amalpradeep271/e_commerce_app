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
  }) : super(
          titleSpacing: 0,
          centerTitle: true,
          backgroundColor: backgroundColor ?? AppColors.cream,
          elevation: elevation ?? 0,
          title: title != null
              ? Text(
                  title,
                  style:
                      AppTextStyles.getAppTextStyleCustomized(textSize: 20.h),
                )
              : searchBox == true
                  ? SizedBox(
                      width: 250.w,
                      child:
                       TextFormField(
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
                          suffixIcon: GestureDetector(
                              onTap: onTap,
                              child: const Icon(
                                AppIcons.search,
                                size: 20,
                              ),),
                        ),
                      ),
                    )
                  : null,
          actions: [
            if (actionIconData1 != null)
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: IconButton(
                  onPressed: onAction1Pressed,
                  icon: Icon(
                    actionIconData1,
                    color: actionIconColor ?? AppColors.black,
                    size: actionIcon1Size ?? 20.0,
                  ),
                ),
              ),
            if (actionIconData3 != null)
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: IconButton(
                  onPressed: onAction3Pressed,
                  icon: Icon(
                    actionIconData3,
                    color: actionIconColor ?? AppColors.red,
                    size: actionIcon2Size ?? 20.0,
                  ),
                ),
              ),
            if (actionIconData2 != null)
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: IconButton(
                  onPressed: onAction2Pressed,
                  icon: Icon(
                    actionIconData2,
                    color: actionIconColor ?? AppColors.black,
                    size: actionIcon2Size ?? 20.0,
                  ),
                ),
              ),
          ],
          leading: leadingIconData != null
              ? IconButton(
                  onPressed: onLeadingPressed,
                  icon: Icon(
                    leadingIconData,
                    color: leadingIconColor ?? AppColors.black,
                    size: leadingIconSize ?? 20.0,
                  ),
                )
              : null,
        );
}
