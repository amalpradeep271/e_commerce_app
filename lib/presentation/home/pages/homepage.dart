import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/common/widgets/app_drawer/app_drawer.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_icons.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/presentation/home/bloc/banners_display_cubit.dart';
import 'package:e_commerce_application/presentation/home/bloc/banners_display_state.dart';
import 'package:e_commerce_application/presentation/home/widgets/banner_carousel_slider.dart';
import 'package:e_commerce_application/presentation/home/widgets/categories.dart';
import 'package:e_commerce_application/presentation/home/widgets/top_selling.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  final val = 0;
  var activeIndex = 0;

  int onIndexChange(int value) {
    final val = activeIndex = value;
    return val;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomAppDrawer(),
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
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            BlocProvider(
              create: (context) => BannersDisplayCubit()..displayBanners(),
              child: BlocBuilder<BannersDisplayCubit, BannersDisplayState>(
                builder: (context, state) {
                  if (state is BannersLoading) {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                  if (state is BannersLoaded) {
                    return BannerCarouselSlider(
                      height: 200,
                      autoPlay: true,
                      itemBuilder: (context, index, _) {
                        return Padding(
                          padding: EdgeInsets.only(
                            top: 30.h,
                            bottom: 10.h,
                          ),
                          child: SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: Image.network(
                              ImageDisplayHelper.generateBannerImageURL(
                                state.banners[index].bannerImage,
                              ),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, _) {
                                return const Text("Image not available");
                              },
                            ),
                          ),
                        );
                      },
                      itemCount: state.banners.length,
                      onPageChanged: (index, _) => onIndexChange(index),
                    );
                  }
                  return Container();
                },
              ),
            ),

            const Categories(),
            SizedBox(height: 24.h),
            const TopSelling(),
            // SizedBox(height: 24.h),
            // const NewIn(),
          ],
        ),
      )),
    );
  }
}
