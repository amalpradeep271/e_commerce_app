import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/app_bottom_navigationbar/custom_app_bottom_navigationbar.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_app_button.dart';
import 'package:e_commerce_application/core/configs/assets/app_images.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OrderPlacedPage extends StatelessWidget {
  const OrderPlacedPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      if (context.mounted) {
        AppNavigator.pushAndRemove(
            context, const CustomAppBottomNavigationBar());
      }
    });
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(AppImages.orderPlaced),
          ),
          const SizedBox(
            height: 60,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Order Placed Successfully',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BasicAppButton(
                      title: 'Finish',
                      onPressed: () {
                        AppNavigator.pushAndRemove(
                            context, const CustomAppBottomNavigationBar());
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
