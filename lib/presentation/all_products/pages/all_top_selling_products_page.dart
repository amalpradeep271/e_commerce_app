import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_state.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/common/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:e_commerce_application/common/widgets/product/product_card.dart';
import 'package:e_commerce_application/common/widgets/product/product_grid_shimmer.dart';
import 'package:e_commerce_application/domain/product/entity/product_entity.dart';
import 'package:e_commerce_application/domain/product/usecase/get_topselling_usecase.dart';
import 'package:e_commerce_application/presentation/wishlist/bloc/wishlist_cubit.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_application/common/widgets/please_try_again/please_try_again_widget.dart';
import 'package:e_commerce_application/common/widgets/empty/empty_state_widget.dart';
import 'package:e_commerce_application/domain/product/repository/product_repository.dart';

class AllTopSellingProductsPage extends StatefulWidget {
  final String title;

  const AllTopSellingProductsPage({
    super.key,
    required this.title,
  });

  @override
  State<AllTopSellingProductsPage> createState() => _AllTopSellingProductsPageState();
}

class _AllTopSellingProductsPageState extends State<AllTopSellingProductsPage> {
  final ScrollController _scrollController = ScrollController();
  List<ProductEntity> _products = [];
  int _page = 1;
  static const int _limit = 6;
  bool _isInitialLoading = true;
  bool _isLoadingMore = false;
  bool _isLastPage = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchPage(isRefresh: true);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _fetchPage();
    }
  }

  Future<void> _fetchPage({bool isRefresh = false}) async {
    if (isRefresh) {
      setState(() {
        _page = 1;
        _isLastPage = false;
        _isInitialLoading = true;
        _errorMessage = null;
      });
    } else {
      if (_isLoadingMore || _isLastPage) return;
      setState(() {
        _isLoadingMore = true;
      });
    }

    final result = await sl<GetTopSellingUseCase>().call(params: {'page': _page, 'limit': _limit});
    
    if (!mounted) return;

    result.fold(
      (error) {
        setState(() {
          _isInitialLoading = false;
          _isLoadingMore = false;
          _errorMessage = error;
        });
      },
      (data) {
        setState(() {
          _isInitialLoading = false;
          _isLoadingMore = false;
          if (isRefresh) {
            _products = data;
          } else {
            _products.addAll(data);
          }
          if (data.length < _limit) {
            _isLastPage = true;
          } else {
            _page++;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectivityDisconnected) {
          return const NoInternetScreen();
        }
        return Scaffold(
          appBar: CustomAppBar(
            title: widget.title,
          ),
          body: BlocProvider(
            create: (context) => WishlistCubit()..loadWishlist(),
            child: RefreshIndicator(
              onRefresh: () async {
                sl<ProductRepository>().clearCache();
                await _fetchPage(isRefresh: true);
              },
              child: Builder(
                builder: (context) {
                  if (_isInitialLoading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: ProductGridShimmer(
                        itemCount: 6,
                        shrinkWrap: false,
                        physics: AlwaysScrollableScrollPhysics(),
                      ),
                    );
                  }

                  if (_errorMessage != null) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: PleaseTryAgainWidget(
                          errorMessage: _errorMessage!,
                          onRetry: () {
                            sl<ProductRepository>().clearCache();
                            _fetchPage(isRefresh: true);
                          },
                          isFullScreen: false,
                        ),
                      ),
                    );
                  }

                  if (_products.isEmpty) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: EmptyStateWidget(
                          title: "No Products Found",
                          subtitle: "There are no top selling products available right now.",
                          onRefresh: () {
                            sl<ProductRepository>().clearCache();
                            _fetchPage(isRefresh: true);
                          },
                        ),
                      ),
                    );
                  }

                  return CustomScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 15),
                        sliver: SliverGrid(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 5,
                            childAspectRatio: .60,
                            crossAxisCount: 2,
                            crossAxisSpacing: 0,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: ProductCard(
                                  productEntity: _products[index],
                                ),
                              );
                            },
                            childCount: _products.length,
                          ),
                        ),
                      ),
                      if (_isLoadingMore)
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: CupertinoActivityIndicator(),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
