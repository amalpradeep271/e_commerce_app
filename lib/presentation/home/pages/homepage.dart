import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_state.dart';
import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/common/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:e_commerce_application/presentation/cart/pages/cart_page.dart';
import 'package:e_commerce_application/presentation/notification/pages/notifications_page.dart';
import 'package:e_commerce_application/presentation/home/bloc/banners/banners_display_cubit.dart';
import 'package:e_commerce_application/presentation/home/bloc/banners/banners_display_state.dart';
import 'package:e_commerce_application/common/widgets/please_try_again/please_try_again_widget.dart';
import 'package:e_commerce_application/presentation/home/bloc/categories/categories_display_cubit.dart';
import 'package:e_commerce_application/presentation/home/widgets/banner_carousel_slider.dart';
import 'package:e_commerce_application/presentation/home/widgets/categories.dart';
import 'package:e_commerce_application/presentation/home/widgets/new_in.dart';
import 'package:e_commerce_application/presentation/home/widgets/top_selling.dart';
import 'package:e_commerce_application/presentation/search/pages/search_page.dart';
import 'package:e_commerce_application/presentation/wishlist/bloc/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:e_commerce_application/domain/product/repository/product_repository.dart';
import 'package:e_commerce_application/domain/category/repository/category_repository.dart';
import 'package:e_commerce_application/domain/home/repository/banner_repository.dart';
import 'package:e_commerce_application/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Key _refreshKey = UniqueKey();

  Future<void> _onRefresh(BuildContext context) async {
    sl<ProductRepository>().clearCache();
    sl<CategoryRepository>().clearCache();
    sl<BannerRepository>().clearCache();

    context.read<BannersDisplayCubit>().displayBanners();
    context.read<CategoriesDisplayCubit>().displayCategories();

    setState(() {
      _refreshKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Exact brand colors matching the provided screen designs
    final brandTeal =
        isDark ? const Color(0xFF14B8A6) : const Color(0xFF006970);
    final searchBgColor =
        isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9);
    final searchBorderColor = isDark
        ? const Color(0xFF334155).withValues(alpha: 0.5)
        : const Color(0xFFE2E8F0);
    final iconTextColor = isDark ? Colors.white60 : const Color(0xFF64748B);

    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectivityDisconnected) {
          return const NoInternetScreen();
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => BannersDisplayCubit()..displayBanners(),
            ),
            BlocProvider(
              create: (context) => WishlistCubit()..loadWishlist(),
            ),
            BlocProvider(
              create: (context) =>
                  CategoriesDisplayCubit()..displayCategories(),
            ),
          ],
          child: Builder(builder: (context) {
            return Scaffold(
              appBar: CustomAppBar(
                title: "E-Commerce",
                leadingIconData: Icons.menu,
                leadingIconColor:
                    isDark ? Colors.white : const Color(0xFF0F172A),
                onLeadingPressed: () => Scaffold.of(context).openDrawer(),
                searchBox: false,
                backgroundColor: Colors.transparent,
                actionIconData1: Icons.notifications_none_outlined,
                actionIconData2: Icons.shopping_cart_outlined,
                actionIconColor:
                    isDark ? Colors.white : const Color(0xFF0F172A),
                notificationBadge: 3,
                cartBadge: 2,
                onAction1Pressed: () =>
                    AppNavigator.push(context, const NotificationsPage()),
                onAction2Pressed: () =>
                    AppNavigator.push(context, const CartPage()),
              ),
              body: RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: SingleChildScrollView(
                  key: _refreshKey,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12.h),
                        // New Search Bar Design matching light & dark themes
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  AppNavigator.push(
                                      context, const SearchPage());
                                },
                                child: Container(
                                  height: 50.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  decoration: BoxDecoration(
                                    color: searchBgColor,
                                    borderRadius: BorderRadius.circular(16.r),
                                    border: Border.all(
                                      color: searchBorderColor,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.search,
                                          color: iconTextColor, size: 20.sp),
                                      SizedBox(width: 12.w),
                                      Text(
                                        "Search products...",
                                        style: TextStyle(
                                          color: iconTextColor,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            // Filter button matching mockup exactly
                            Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF1E293B)
                                    : brandTeal,
                                borderRadius: BorderRadius.circular(16.r),
                                border: isDark
                                    ? Border.all(color: searchBorderColor)
                                    : null,
                                boxShadow: [
                                  if (!isDark)
                                    BoxShadow(
                                      color: brandTeal.withValues(alpha: 0.25),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                ],
                              ),
                              child: IconButton(
                                onPressed: () {
                                  // Filter action
                                },
                                icon: Icon(
                                    Icons
                                        .tune, // Exact sliders/filter icon from mockup
                                    color: isDark ? Colors.white : Colors.white,
                                    size: 20.sp),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        // Banners carousel slider with design overlays
                        BlocBuilder<BannersDisplayCubit, BannersDisplayState>(
                          builder: (context, state) {
                            if (state is BannersLoading) {
                              return Shimmer.fromColors(
                                baseColor: isDark
                                    ? const Color(0xFF334155)
                                    : const Color(0xFFE2E8F0),
                                highlightColor: isDark
                                    ? const Color(0xFF1E293B)
                                    : const Color(0xFFF1F5F9),
                                child: Container(
                                  height: 160.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24.r),
                                  ),
                                ),
                              );
                            }
                            if (state is BannersLoaded) {
                              return BannerCarouselSlider(
                                height: 160.h,
                                autoPlay: true,
                                itemCount: state.banners.length,
                                itemBuilder: (context, index, _) {
                                  final banner = state.banners[index];
                                  final subtitleText = banner.subtitle ??
                                      (index == 0
                                          ? (isDark
                                              ? "LIMITED OFFER"
                                              : "SUMMER COLLECTION")
                                          : (isDark
                                              ? "SPECIAL DEAL"
                                              : "NEW ARRIVALS"));
                                  final titleText = banner.title ??
                                      (index == 0
                                          ? "50% OFF\nSummer Sale"
                                          : "30% OFF\nWinter Sale");

                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? const Color(0xFF1E293B)
                                          : const Color(0xFFFBE9E7),
                                      borderRadius: BorderRadius.circular(24.r),
                                      border: Border.all(
                                        color: searchBorderColor,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24.r),
                                      child: Row(
                                        children: [
                                          // Left side text details
                                          Expanded(
                                            flex: 12,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.w,
                                                  vertical: 12.h),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: isDark
                                                      ? [
                                                          const Color(
                                                              0xFF0F172A),
                                                          const Color(
                                                              0xFF1E293B)
                                                        ]
                                                      : [
                                                          const Color(
                                                              0xFFF58A6E),
                                                          const Color(
                                                              0xFFF7A088)
                                                        ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    subtitleText,
                                                    style: TextStyle(
                                                      color: isDark
                                                          ? const Color(
                                                              0xFFE5951F)
                                                          : Colors.white70,
                                                      fontSize: 9.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: 1.0,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4.h),
                                                  Text(
                                                    titleText,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      height: 1.15,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8.h),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12.w,
                                                            vertical: 5.h),
                                                    decoration: BoxDecoration(
                                                      color: isDark
                                                          ? brandTeal
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.r),
                                                    ),
                                                    child: Text(
                                                      "Shop Now",
                                                      style: TextStyle(
                                                        color: isDark
                                                            ? Colors.white
                                                            : const Color(
                                                                0xFFF58A6E),
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Right side banner image from DB
                                          Expanded(
                                            flex: 10,
                                            child: Image.network(
                                              ImageDisplayHelper
                                                  .generateBannerImageURL(
                                                state
                                                    .banners[index].bannerImage,
                                              ),
                                              fit: BoxFit.cover,
                                              height: double.infinity,
                                              errorBuilder:
                                                  (context, error, _) {
                                                return Container(
                                                  color: isDark
                                                      ? const Color(0xFF334155)
                                                      : const Color(0xFFE2E8F0),
                                                  child: Icon(
                                                    Icons.image,
                                                    color: Colors.grey,
                                                    size: 32.sp,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            if (state is BannersLoadFailure) {
                              return PleaseTryAgainWidget(
                                errorMessage: "Failed to load banners",
                                onRetry: () {
                                  context
                                      .read<BannersDisplayCubit>()
                                      .displayBanners();
                                },
                                isFullScreen: false,
                              );
                            }
                            return Container();
                          },
                        ),
                        SizedBox(height: 16.h),
                        const Categories(),
                        SizedBox(height: 16.h),
                        const TopSelling(),
                        SizedBox(height: 16.h),
                        const NewIn(),
                        SizedBox(height: 90.h), // padding for bottom nav bar
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
