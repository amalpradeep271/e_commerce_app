import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_application/common/bloc/app_bottom_navigationbar/bottom_navigation_cubit.dart';
import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_state.dart';
import 'package:e_commerce_application/common/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/presentation/home/pages/homepage.dart';
import 'package:e_commerce_application/presentation/order/pages/my_orders_page.dart';
import 'package:e_commerce_application/presentation/wishlist/pages/wishlist_page.dart';
import 'package:e_commerce_application/presentation/settings/pages/settings_page.dart';
import 'package:e_commerce_application/common/widgets/app_drawer/app_drawer.dart';
import 'package:e_commerce_application/common/bloc/app_drawer/user_info_display_cubit.dart';
import 'package:e_commerce_application/presentation/wishlist/bloc/wishlist_cubit.dart';
import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:e_commerce_application/domain/category/usecase/get_category_usecase.dart';
import 'package:e_commerce_application/domain/product/usecase/get_newin_usecase.dart';
import 'package:e_commerce_application/domain/product/usecase/get_topselling_usecase.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'dart:ui';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final List<Widget> pages = [
    const HomePage(),
    const MyOrdersPage(),
    const WishlistPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavigationCubit(),
        ),
        BlocProvider(
          create: (context) =>
              ProductsDisplayCubit(useCase: sl<GetTopSellingUseCase>())
                ..displayProducts(showLoading: false),
        ),
        BlocProvider(
          create: (context) =>
              ProductsDisplayCubit(useCase: sl<GetNewInUseCase>())
                ..displayProducts(showLoading: false),
        ),
        BlocProvider(
          create: (context) =>
              ProductsDisplayCubit(useCase: sl<GetCategoryUseCase>())
                ..displayProducts(showLoading: false),
        ),
        BlocProvider(create: (context) => WishlistCubit()..loadWishlist()),
        BlocProvider(
          create: (context) => UserInfoDisplayCubit()..displayUserInfo(),
        ),
      ],
      child: BlocBuilder<ConnectivityCubit, ConnectivityState>(
        builder: (context, state) {
          if (state is ConnectivityDisconnected) {
            return const NoInternetScreen();
          }
          return Scaffold(
            key: GlobalKey<ScaffoldState>(),
            drawer: const CustomAppDrawer(),
            extendBody: true, // Let page content flow under bottom nav bar
            body: BlocBuilder<BottomNavigationCubit, BottomNavItem>(
              builder: (context, tabIndex) {
                return pages[tabIndex.index];
              },
            ),
            bottomNavigationBar: const PremiumFloatingNavBar(),
          );
        },
      ),
    );
  }
}

class PremiumFloatingNavBar extends StatelessWidget {
  const PremiumFloatingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<BottomNavigationCubit, BottomNavItem>(
      builder: (context, currentTab) {
        return Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                height: 70.h,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E293B).withValues(alpha: 0.8)
                      : Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.1)
                        : AppColors.kPrimaryColor.withValues(alpha: 0.15),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavBarItem(
                      icon: Icons.home_outlined,
                      activeIcon: Icons.home,
                      label: 'Home',
                      isActive: currentTab == BottomNavItem.home,
                      onTap: () => context
                          .read<BottomNavigationCubit>()
                          .changeTabIndex(BottomNavItem.home),
                    ),
                    _NavBarItem(
                      icon: Icons.shopping_bag_outlined,
                      activeIcon: Icons.shopping_bag,
                      label: 'Orders',
                      isActive: currentTab == BottomNavItem.orders,
                      onTap: () => context
                          .read<BottomNavigationCubit>()
                          .changeTabIndex(BottomNavItem.orders),
                    ),
                    _NavBarItem(
                      icon: Icons.favorite_outline,
                      activeIcon: Icons.favorite,
                      label: 'Wishlist',
                      isActive: currentTab == BottomNavItem.wishlist,
                      onTap: () => context
                          .read<BottomNavigationCubit>()
                          .changeTabIndex(BottomNavItem.wishlist),
                    ),
                    _NavBarItem(
                      icon: Icons.person_outline,
                      activeIcon: Icons.person,
                      label: 'Profile',
                      isActive: currentTab == BottomNavItem.settings,
                      onTap: () => context
                          .read<BottomNavigationCubit>()
                          .changeTabIndex(BottomNavItem.settings),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.kPrimaryColor.withValues(alpha: 0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              isActive ? activeIcon : icon,
              color: isActive ? AppColors.kPrimaryColor : Colors.grey,
              size: 24.r,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive ? AppColors.kPrimaryColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
