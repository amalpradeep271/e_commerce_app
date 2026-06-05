import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_state.dart';
import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/common/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:e_commerce_application/presentation/cart/pages/cart_page.dart';
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
              create: (context) => CategoriesDisplayCubit()..displayCategories(),
            ),
          ],
          child: Builder(
            builder: (context) {
              return Scaffold(
                appBar: CustomAppBar(
                  onTap: () async {
                    AppNavigator.push(context, const SearchPage());
                  },
                  title: "E-Commerce",
                  leadingIconData: Icons.menu,
                  leadingIconColor: Theme.of(context).colorScheme.onSurface,
                  onLeadingPressed: () => Scaffold.of(context).openDrawer(),
                  searchBox: false,
                  backgroundColor: Colors.transparent,
                  actionIconData2: Icons.shopping_cart_outlined,
                  actionIconColor: Theme.of(context).colorScheme.onSurface,
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
                          SizedBox(height: 16.h),
                          // New Search Bar Design
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    AppNavigator.push(context, const SearchPage());
                                  },
                                  child: Container(
                                    height: 50.h,
                                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                                      borderRadius: BorderRadius.circular(16.r),
                                      border: Border.all(
                                        color: Theme.of(context).colorScheme.outlineVariant,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.search, color: Theme.of(context).colorScheme.outline),
                                        SizedBox(width: 12.w),
                                        Text(
                                          "Search products...",
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.outline,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Container(
                                height: 50.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(16.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    // TODO: Implement Filter action
                                  },
                                  icon: const Icon(Icons.filter_list, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          BlocBuilder<BannersDisplayCubit, BannersDisplayState>(
                            builder: (context, state) {
                              if (state is BannersLoading) {
                                return Shimmer.fromColors(
                                  baseColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                                  highlightColor: Theme.of(context).colorScheme.surface,
                                  child: Container(
                                    height: 200.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                  ),
                                );
                              }
                              if (state is BannersLoaded) {
                                return BannerCarouselSlider(
                                  height: 200.h,
                                  autoPlay: true,
                                  itemBuilder: (context, index, _) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(24.r),
                                      child: SizedBox(
                                        height: 200.h,
                                        width: double.infinity,
                                        child: Image.network(
                                          ImageDisplayHelper.generateBannerImageURL(
                                            state.banners[index].bannerImage,
                                          ),
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, _) {
                                            return const Center(
                                              child: Text(
                                                "Image not available",
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: state.banners.length,
                                );
                              }
                              if (state is BannersLoadFailure) {
                                return PleaseTryAgainWidget(
                                  errorMessage: "Failed to load banners",
                                  onRetry: () {
                                    context.read<BannersDisplayCubit>().displayBanners();
                                  },
                                  isFullScreen: false,
                                );
                              }
                              return Container();
                            },
                          ),
                          SizedBox(height: 24.h),
                          const Categories(),
                          SizedBox(height: 24.h),
                          const TopSelling(),
                          SizedBox(height: 24.h),
                          const NewIn(),
                          SizedBox(height: 100.h), // padding for bottom nav bar
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        );
      },
    );
  }
}
