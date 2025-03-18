import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_app_button.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 80.sp, color: AppColors.red),
            SizedBox(height: 20.h),
            Text(
              "No Internet Connection",
              style: AppTextStyles.base.s20.w800,
            ),
            SizedBox(height: 10.h),
            Text(
              "Please check your internet connection and try again.",
              textAlign: TextAlign.center,
              style: AppTextStyles.base.s16.w500.greyColor,
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: BasicAppButton(
                onPressed: () {
                  context.read<ConnectivityCubit>().checkConnection();
                },
                title: "Retry",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
