import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_app_button.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/domain/order/entity/order_entity.dart';
import 'package:e_commerce_application/presentation/order/pages/order_items_page.dart';
import 'package:e_commerce_application/presentation/order/pages/order_tracking_page.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatelessWidget {
  final OrderEntity orderEntity;
  const OrderDetailPage({required this.orderEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Order #${orderEntity.code}',
          leadingIconData: Icons.arrow_back,
          onLeadingPressed: () => Navigator.pop(context),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _status(),
              const SizedBox(
                height: 24,
              ),
              BasicAppButton(
                title: 'Live Track Order Status',
                onPressed: () {
                  AppNavigator.push(
                    context,
                    OrderTrackingPage(
                      orderId: orderEntity.code,
                      orderCode: orderEntity.code,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 32,
              ),
              _items(context),
              const SizedBox(
                height: 30,
              ),
              _shipping()
            ],
          ),
        ));
  }

  Widget _status() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final primaryColor = isDark ? const Color(0xFF14B8A6) : AppColors.kPrimaryColor;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: orderEntity.orderStatus[index].done
                            ? primaryColor
                            : (isDark ? const Color(0xFF334155) : Colors.grey),
                        shape: BoxShape.circle),
                    child: orderEntity.orderStatus[index].done
                        ? const Icon(Icons.check, color: Colors.white, size: 16)
                        : Container(),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    orderEntity.orderStatus[index].title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: orderEntity.orderStatus[index].done
                          ? (isDark ? Colors.white : Colors.black)
                          : Colors.grey,
                    ),
                  )
                ],
              ),
              Text(
                orderEntity.orderStatus[index].done
                    ? orderEntity.orderStatus[index].createdDate
                        .toDate()
                        .toString()
                        .split(' ')[0]
                    : "----:--:--",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: orderEntity.orderStatus[index].done
                      ? (isDark ? Colors.grey[400] : Colors.black)
                      : Colors.grey,
                ),
              )
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 50,
            ),
        reverse: true,
        itemCount: orderEntity.orderStatus.length);
  }

  Widget _items(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Items',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTap: () {
            AppNavigator.push(
                context, OrderItemsPage(products: orderEntity.products));
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
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.receipt_rounded, color: isDark ? const Color(0xFF14B8A6) : AppColors.kPrimaryColor),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      '${orderEntity.products.length} Items',
                      style: TextStyle(
                        fontWeight: FontWeight.w500, 
                        fontSize: 16,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    )
                  ],
                ),
                Text(
                  'View All',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isDark ? const Color(0xFF14B8A6) : AppColors.kPrimaryColor,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _shipping() {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shipping details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? const Color(0xFF334155).withValues(alpha: 0.5) : const Color(0xFFE5E7EB),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  orderEntity.shippingAddress,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey[300] : Colors.black87,
                  ),
                ))
          ],
        );
      }
    );
  }
}
