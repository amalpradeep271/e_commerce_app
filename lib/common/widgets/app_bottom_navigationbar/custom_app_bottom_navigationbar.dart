import 'package:e_commerce_application/common/bloc/app_bottom_navigationbar/bottom_navigation_cubit.dart';
import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_state.dart';
import 'package:e_commerce_application/common/bloc/product/product_display_cubit.dart';
import 'package:e_commerce_application/common/widgets/app_drawer/app_drawer.dart';
import 'package:e_commerce_application/common/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_icons.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/category/usecase/get_category_usecase.dart';
import 'package:e_commerce_application/domain/product/usecase/get_newin_usecase.dart';
import 'package:e_commerce_application/domain/product/usecase/get_topselling_usecase.dart';
import 'package:e_commerce_application/presentation/home/pages/homepage.dart';
import 'package:e_commerce_application/presentation/order/pages/my_orders_page.dart';
import 'package:e_commerce_application/presentation/wishlist/bloc/wishlist_cubit.dart';
import 'package:e_commerce_application/presentation/wishlist/pages/wishlist_page.dart';
import 'package:e_commerce_application/common/bloc/app_drawer/user_info_display_cubit.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBottomNavigationBar extends StatelessWidget {
  CustomAppBottomNavigationBar({super.key});
  final List<Widget> pages = [
    const HomePage(),
    const MyOrdersPage(),
    const WishlistPage(),
  ];

  Widget buildBottomNavigationMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.navigationBarColor,
          ),
          child: BlocBuilder<BottomNavigationCubit, BottomNavItem>(
            builder: (context, tabIndex) {
              return BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                showSelectedLabels: true,
                onTap: (index) {
                  context
                      .read<BottomNavigationCubit>()
                      .changeTabIndex(BottomNavItem.values[index]);
                },
                currentIndex: tabIndex.index,
                backgroundColor: AppColors.kPrimaryColor,
                unselectedItemColor: AppColors.neutral3,
                selectedItemColor: AppColors.white,
                unselectedLabelStyle: AppTextStyles.base.s14,
                selectedLabelStyle: AppTextStyles.base.s14,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(AppIcons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(AppIcons.orders), label: 'Orders'),
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
          return Stack(
            children: [
              Scaffold(
                key: GlobalKey<
                    ScaffoldState>(), // Ensure scaffold key for drawer access
                drawer:
                    const CustomAppDrawer(), // ✅ Ensure drawer is part of Scaffold

                body: BlocBuilder<BottomNavigationCubit, BottomNavItem>(
                  builder: (context, tabIndex) {
                    return pages[tabIndex.index];
                  },
                ),
                bottomNavigationBar: buildBottomNavigationMenu(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
