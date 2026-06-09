import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_app_button.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/auth/entity/user_entity.dart';
import 'package:e_commerce_application/domain/order/usecase/get_orders_usecase.dart';
import 'package:e_commerce_application/domain/wishlist/usecase/get_wishlist_usecase.dart';
import 'package:e_commerce_application/presentation/address/pages/address_book_page.dart';
import 'package:e_commerce_application/presentation/notification/pages/notifications_page.dart';
import 'package:e_commerce_application/presentation/order/pages/my_orders_page.dart';
import 'package:e_commerce_application/presentation/auth/pages/signin_page.dart';
import 'package:e_commerce_application/presentation/settings/bloc/profile_cubit.dart';
import 'package:e_commerce_application/presentation/settings/bloc/profile_state.dart';
import 'package:e_commerce_application/presentation/settings/bloc/theme_cubit.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:e_commerce_application/core/network/api_client.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _ordersCount = 0;
  int _wishlistCount = 0;
  bool _isLoadingStats = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() {
      _isLoadingStats = true;
    });

    final ordersResult = await sl<GetOrdersUseCase>().call();
    final wishlistResult = await sl<GetWishlistUseCase>().call();

    if (mounted) {
      setState(() {
        _ordersCount = ordersResult.fold((err) => 0, (list) => list.length);
        _wishlistCount = wishlistResult.fold((err) => 0, (list) => list.length);
        _isLoadingStats = false;
      });
    }
  }

  Future<void> _pickAndUploadImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    
    if (pickedFile != null && mounted) {
      context.read<ProfileCubit>().uploadAvatar(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..loadProfile(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Profile',
            ),
            body: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is ProfileFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );
                } else if (state is AvatarUploadSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Avatar uploaded successfully!')),
                  );
                }
              },
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ProfileLoaded) {
                  final user = state.user;

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: Column(
                      children: [
                        // User Profile Header
                        _profileHeader(context, user),
                        SizedBox(height: 24.h),

                        // Stats Card
                        _statsCard(),
                        SizedBox(height: 24.h),

                        // Settings Options List
                        _settingsOptions(context),
                      ],
                    ),
                  );
                }

                return Center(
                  child: BasicAppButton(
                    onPressed: () => context.read<ProfileCubit>().loadProfile(),
                    title: 'Try Again',
                    width: 150.w,
                  ),
                );
              },
            ),
          );
        }
      ),
    );
  }

  Widget _profileHeader(BuildContext context, UserEntity user) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = AppColors.getPrimary(context);
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 54.r,
              backgroundColor: primaryColor.withValues(alpha: 0.1),
              backgroundImage: user.image.isNotEmpty ? NetworkImage(user.image) : null,
              child: user.image.isEmpty
                  ? Icon(Icons.person, size: 54.r, color: primaryColor)
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () => _pickAndUploadImage(context),
                child: CircleAvatar(
                  radius: 18.r,
                  backgroundColor: primaryColor,
                  child: const Icon(Icons.camera_alt, color: AppColors.white, size: 16),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          '${user.firstName} ${user.lastName}',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.h),
        Text(
          user.email,
          style: TextStyle(fontSize: 14.sp, color: isDark ? Colors.grey[400] : Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _statsCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Expanded(child: _statItem('Orders', _ordersCount)),
            Container(width: 1, height: 40.h, color: AppColors.getBorderColor(context)),
            Expanded(child: _statItem('Wishlist', _wishlistCount)),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String label, int value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = AppColors.getPrimary(context);
    return Column(
      children: [
        if (_isLoadingStats)
          SizedBox(
            width: 16.w,
            height: 16.h,
            child: const CircularProgressIndicator(strokeWidth: 2),
          )
        else
          Text(
            value.toString(),
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: primaryColor),
          ),
        SizedBox(height: 4.h),
        Text(label, style: TextStyle(fontSize: 13.sp, color: isDark ? Colors.grey[400] : Colors.grey[700])),
      ],
    );
  }

  Widget _settingsOptions(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final isDarkMode = themeCubit.state == ThemeMode.dark;
    final primaryColor = AppColors.getPrimary(context);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _optionTile(
            icon: Icons.shopping_bag_outlined,
            title: 'My Orders',
            onTap: () => AppNavigator.push(context, const MyOrdersPage()),
          ),
          const Divider(height: 1),
          _optionTile(
            icon: Icons.location_on_outlined,
            title: 'Address Book',
            onTap: () => AppNavigator.push(context, const AddressBookPage()),
          ),
          const Divider(height: 1),
          _optionTile(
            icon: Icons.notifications_none_outlined,
            title: 'Notifications',
            onTap: () => AppNavigator.push(context, const NotificationsPage()),
          ),
          const Divider(height: 1),
          SwitchListTile(
            secondary: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode, color: primaryColor),
            title: Text('Dark Mode', style: TextStyle(fontSize: 14.sp)),
            activeColor: primaryColor,
            value: isDarkMode,
            onChanged: (val) {
              themeCubit.updateTheme(val ? ThemeMode.dark : ThemeMode.light);
            },
          ),
          const Divider(height: 1),
          _optionTile(
            icon: Icons.logout,
            title: 'Sign Out',
            titleColor: Colors.red,
            iconColor: Colors.red,
            onTap: () async {
              await sl<ApiClient>().clearTokens();
              if (context.mounted) {
                AppNavigator.pushAndRemove(context, SigninPage());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _optionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? titleColor,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final defaultTitleColor = isDark ? Colors.white : AppColors.black;
    final defaultIconColor = AppColors.getPrimary(context);
    return ListTile(
      leading: Icon(icon, color: iconColor ?? defaultIconColor),
      title: Text(
        title,
        style: TextStyle(fontSize: 14.sp, color: titleColor ?? defaultTitleColor),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
