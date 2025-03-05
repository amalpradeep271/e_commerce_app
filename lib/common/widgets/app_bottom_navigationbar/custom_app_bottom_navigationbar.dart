import 'package:e_commerce_application/common/bloc/app_bottom_navigationbar/bottom_navigation_cubit.dart';
import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_icons.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/product/usecase/get_favourite_products_usecase.dart';
import 'package:e_commerce_application/presentation/home/pages/homepage.dart';
import 'package:e_commerce_application/presentation/wishlist/pages/wishlist_page.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBottomNavigationBar extends StatelessWidget {
  const CustomAppBottomNavigationBar({super.key});

  Widget buildBottomNavigationMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.navigationBarColor,
          ),
          child: BlocBuilder<BottomNavigationCubit, int>(
            builder: (context, tabIndex) {
              return BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                showSelectedLabels: true,
                onTap: (index) => context
                    .read<BottomNavigationCubit>()
                    .changeTabIndex(index, context),
                currentIndex: tabIndex,
                backgroundColor: AppColors.kPrimaryColor,
                unselectedItemColor: AppColors.neutral3,
                selectedItemColor: AppColors.white,
                unselectedLabelStyle: AppTextStyles.base.s14,
                selectedLabelStyle: AppTextStyles.base.s14,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(AppIcons.home), label: 'Home'),
                  // BottomNavigationBarItem(
                  //     icon: Icon(AppIcons.orders), label: 'Orders'),
                  // BottomNavigationBarItem(
                  //     icon: Icon(AppIcons.notification), label: 'Notification'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'Wishlist'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavigationCubit(),
        ),
        BlocProvider(
          create: (context) =>
              ProductsDisplayCubit(useCase: sl<GetFavortiesProductsUseCase>())
                ..displayProducts(showLoading: false),
        ),
      ],
      child: Scaffold(
        bottomNavigationBar: buildBottomNavigationMenu(context),
        body: BlocBuilder<BottomNavigationCubit, int>(
          builder: (context, tabIndex) {
            return IndexedStack(
              index: tabIndex,
              children: const [
                HomePage(),
                // OrderPage(),
                // NotificationPage(),
                WishlistPage(),
              ],
            );
          },
        ),
      ),
    );
  }
}
