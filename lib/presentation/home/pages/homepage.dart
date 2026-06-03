import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_state.dart';
import 'package:e_commerce_application/common/helper/images/images_display.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/common/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_icons.dart';
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
                    // await controller.getSearchData();
                    AppNavigator.push(context, const SearchPage());
                  },
                  leadingIconData: Icons.menu,
                  onLeadingPressed: () => Scaffold.of(context).openDrawer(),
                  searchBox: true,
                  backgroundColor: AppColors.transparent,
                  actionIconData2: AppIcons.cart,
                  onAction2Pressed: () =>
                      AppNavigator.push(context, const CartPage()),
                ),
                body: RefreshIndicator(
                  onRefresh: () => _onRefresh(context),
                  child: SingleChildScrollView(
                    key: _refreshKey,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          BlocBuilder<BannersDisplayCubit, BannersDisplayState>(
                            builder: (context, state) {
                              if (state is BannersLoading) {
                                return Shimmer.fromColors(
                                  baseColor: const Color.fromARGB(255, 218, 221, 227),
                                  highlightColor: AppColors.colorDivider,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 30.h, bottom: 10.h, left: 10.w),
                                    height: 200.h, // Same height as banner slider
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: AppColors.white,
                                    ),
                                  ),
                                );
                              }
                              if (state is BannersLoaded) {
                                return BannerCarouselSlider(
                                  height: 200.h,
                                  autoPlay: true,
                                  itemBuilder: (context, index, _) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        top: 30.h,
                                        bottom: 10.h,
                                        left: 10.w,
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
                          const Categories(),
                          SizedBox(height: 24.h),
                          const TopSelling(),
                          SizedBox(height: 24.h),
                          const NewIn(),
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
