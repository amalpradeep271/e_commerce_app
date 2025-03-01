import 'package:e_commerce_application/common/widgets/app_drawer/app_drawer.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_icons.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomAppDrawer(),
      appBar: CustomAppBar(
        onTap: () async {
          // await controller.getSearchData();
        },
        searchBox: true,
        backgroundColor: AppColors.transparent,
        actionIconData2: AppIcons.cart,
        // onAction2Pressed: () => Get.toNamed(AppRoutes.cartscreen),
        // itemcount: controller.itemcount.value,
        // isLoading: controller.isLoading.value,
      ),
      body: const SingleChildScrollView(
          child: Column(
        children: [
          // const SearchField(),
          // SizedBox(height: 24.h),
          // const Categories(),
          // SizedBox(height: 24.h),
          // const TopSelling(),
          // SizedBox(height: 24.h),
          // const NewIn(),
        ],
      )),
    );
  }
}
