import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_state.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/common/widgets/no_internet_screen/no_internet_screen.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/domain/order/entity/order_entity.dart';
import 'package:e_commerce_application/presentation/order/bloc/order_display_cubit.dart';
import 'package:e_commerce_application/presentation/order/bloc/order_display_state.dart';
import 'package:e_commerce_application/presentation/order/pages/order_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_application/common/widgets/please_try_again/please_try_again_widget.dart';
import 'package:e_commerce_application/common/widgets/empty/empty_state_widget.dart';
import 'package:e_commerce_application/core/configs/assets/app_gifs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, state) {
          if (state is ConnectivityDisconnected) {
            return const NoInternetScreen();
          }
        return Scaffold(
            appBar: CustomAppBar(
              title: 'My Orders',
            ),
            body: BlocProvider(
                create: (context) => OrdersDisplayCubit()..displayOrders(),
                child: Builder(
                  builder: (context) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<OrdersDisplayCubit>().displayOrders();
                      },
                      child: BlocBuilder<OrdersDisplayCubit, OrdersDisplayState>(
                        builder: (context, state) {
                          if (state is OrdersLoading) {
                            return const Center(
                              child: CupertinoActivityIndicator(),
                            );
                          }
                          if (state is OrdersLoaded) {
                            if (state.orders.isEmpty) {
                              return SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.7,
                                  child: EmptyStateWidget(
                                    title: "No Orders Placed",
                                    subtitle: "You haven't ordered anything yet.",
                                    icon: Image.asset(
                                      AppGifs.orderlistEmpty,
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                                    onRefresh: () {
                                      context.read<OrdersDisplayCubit>().displayOrders();
                                    },
                                  ),
                                ),
                              );
                            }
                            return _orders(state.orders);
                          }

                          if (state is LoadOrdersFailure) {
                            return SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.7,
                                child: PleaseTryAgainWidget(
                                  errorMessage: state.errorMessage,
                                  onRetry: () {
                                    context.read<OrdersDisplayCubit>().displayOrders();
                                  },
                                  isFullScreen: false,
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    );
                  }
                )));
      },
    );
  }

  Widget _orders(List<OrderEntity> orders) {
    return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          return GestureDetector(
            onTap: () {
              AppNavigator.push(
                  context,
                  OrderDetailPage(
                    orderEntity: orders[index],
                  ));
            },
            child: Container(
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF0FDFA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? const Color(0xFF334155).withValues(alpha: 0.5) : const Color(0xFFE2E8F0),
                    width: 1.0,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.receipt_rounded,
                        color: isDark ? const Color(0xFF14B8A6) : AppColors.kPrimaryColor,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order #${orders[index].code}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          Text(
                            '${orders[index].products.length} item',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: isDark ? Colors.grey[400] : Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: isDark ? Colors.white70 : Colors.black54,
                    size: 16,
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
        itemCount: orders.length);
  }
}
