import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/presentation/order/bloc/order_tracking_cubit.dart';
import 'package:e_commerce_application/presentation/order/bloc/order_tracking_state.dart';
import 'package:intl/intl.dart';

class OrderTrackingPage extends StatelessWidget {
  final String orderId;
  final String orderCode;

  const OrderTrackingPage({required this.orderId, required this.orderCode, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderTrackingCubit()..loadOrderTracking(orderId),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Track Order $orderCode',
              leadingIconData: Icons.arrow_back,
              onLeadingPressed: () => Navigator.pop(context),
            ),
            body: BlocBuilder<OrderTrackingCubit, OrderTrackingState>(
              builder: (context, state) {
                if (state is OrderTrackingLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is OrderTrackingLoaded) {
                  final steps = state.trackingSteps;

                  return SingleChildScrollView(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Status Timeline',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 24.h),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: steps.length,
                          itemBuilder: (context, index) {
                            final step = steps[index];
                            final isLast = index == steps.length - 1;
                            
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 24.w,
                                      height: 24.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: step.done ? AppColors.kPrimaryColor : Colors.grey[300],
                                        border: Border.all(
                                          color: step.done ? AppColors.kPrimaryColor : Colors.grey[400]!,
                                          width: 2,
                                        ),
                                      ),
                                      child: step.done
                                          ? const Icon(Icons.check, size: 14, color: AppColors.white)
                                          : null,
                                    ),
                                    if (!isLast)
                                      Container(
                                        width: 2.w,
                                        height: 60.h,
                                        color: step.done && steps[index + 1].done
                                            ? AppColors.kPrimaryColor
                                            : Colors.grey[300],
                                      ),
                                  ],
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        step.title,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: step.done ? AppColors.black : Colors.grey[600],
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      if (step.done)
                                        Text(
                                          DateFormat('dd MMM yyyy, hh:mm a')
                                              .format(step.createdDate.toDate()),
                                          style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
                                        )
                                      else
                                        Text(
                                          'Pending',
                                          style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }

                if (state is OrderTrackingFailure) {
                  return Center(child: Text(state.errorMessage));
                }

                return const SizedBox();
              },
            ),
          );
        }
      ),
    );
  }
}
