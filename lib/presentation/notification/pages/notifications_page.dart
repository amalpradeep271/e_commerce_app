import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_app_button.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/domain/notification/entity/notification_entity.dart';
import 'package:e_commerce_application/presentation/notification/bloc/notification_cubit.dart';
import 'package:e_commerce_application/presentation/notification/bloc/notification_state.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit()..loadNotifications(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Notifications',
              leadingIconData: Icons.arrow_back,
              onLeadingPressed: () => Navigator.pop(context),
            ),
            body: RefreshIndicator(
              onRefresh: () => context.read<NotificationCubit>().loadNotifications(),
              child: BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is NotificationLoaded) {
                    if (state.notifications.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.notifications_off, size: 80.w, color: AppColors.grey),
                            SizedBox(height: 16.h),
                            Text(
                              'No notifications yet.',
                              style: TextStyle(fontSize: 16.sp, color: AppColors.lightGray),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) {
                        final notification = state.notifications[index];
                        return _notificationTile(context, notification);
                      },
                    );
                  }

                  return Center(
                    child: BasicAppButton(
                      onPressed: () => context.read<NotificationCubit>().loadNotifications(),
                      title: 'Try Again',
                      width: 150.w,
                    ),
                  );
                },
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _notificationTile(BuildContext context, NotificationEntity item) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    IconData getIcon() {
      switch (item.type) {
        case 'order':
          return Icons.shopping_bag;
        case 'promo':
          return Icons.local_offer;
        case 'system':
        default:
          return Icons.info;
      }
    }

    Color getIconColor() {
      switch (item.type) {
        case 'order':
          return isDark ? const Color(0xFF22D3EE) : Colors.blue;
        case 'promo':
          return isDark ? const Color(0xFF34D399) : Colors.green;
        case 'system':
        default:
          return isDark ? const Color(0xFFFB923C) : Colors.orange;
      }
    }

    return Card(
      elevation: item.isRead ? 0 : 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      color: item.isRead
          ? (isDark ? AppColors.slate800 : AppColors.white)
          : (isDark ? AppColors.brandTeal.withValues(alpha: 0.12) : AppColors.kPrimaryColor.withValues(alpha: 0.06)),
      margin: EdgeInsets.only(bottom: 12.h),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        leading: CircleAvatar(
          backgroundColor: getIconColor().withValues(alpha: 0.15),
          child: Icon(getIcon(), color: getIconColor()),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: item.isRead ? FontWeight.normal : FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            if (!item.isRead)
              Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: AppColors.getPrimary(context),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6.h),
            Text(
              item.body,
              style: TextStyle(fontSize: 13.sp, color: isDark ? Colors.grey[300] : Colors.grey[700]),
            ),
            SizedBox(height: 8.h),
            Text(
              DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
              style: TextStyle(fontSize: 11.sp, color: isDark ? Colors.grey[500] : Colors.grey),
            ),
          ],
        ),
        onTap: () {
          if (!item.isRead) {
            context.read<NotificationCubit>().markNotificationAsRead(item.id);
          }
        },
      ),
    );
  }
}
