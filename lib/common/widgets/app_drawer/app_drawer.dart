import 'dart:io';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/presentation/home/pages/main_page.dart';
import 'package:e_commerce_application/core/configs/assets/app_images.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_icons.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/domain/user/usecase/upload_user_image_usecase.dart';
import 'package:e_commerce_application/presentation/agreements/pages/privacy_policy_page.dart';
import 'package:e_commerce_application/presentation/agreements/pages/terms_and_condition_pages.dart';
import 'package:e_commerce_application/presentation/auth/pages/signin_page.dart';
import 'package:e_commerce_application/common/bloc/app_drawer/user_info_display_cubit.dart';
import 'package:e_commerce_application/common/bloc/app_drawer/user_info_display_state.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:e_commerce_application/core/network/api_client.dart';
import 'package:e_commerce_application/domain/auth/repository/auth_repository.dart';
import 'package:e_commerce_application/domain/product/repository/product_repository.dart';
import 'package:e_commerce_application/domain/category/repository/category_repository.dart';
import 'package:e_commerce_application/domain/home/repository/banner_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerTileData {
  final IconData icon;
  final String tileName;
  final void Function(BuildContext) callback;

  DrawerTileData(this.icon, this.tileName, this.callback);
}

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    List<DrawerTileData> arrayOfListTiles = [
      DrawerTileData(AppIcons.home, "Home", (context) {
        AppNavigator.pushAndRemove(
          context,
          MainPage(),
        );
      }),
      DrawerTileData(Icons.share, "Share App", (context) {}),
      DrawerTileData(AppIcons.contact, "Contact Us", (context) {}),
      DrawerTileData(AppIcons.privacypolicy, "Privacy Policy", (context) {
        AppNavigator.push(context, const PrivacyPolicyPage());
      }),
    ];

    return SizedBox(
      width: 500,
      child: drawerWidget(context, arrayOfListTiles),
    );
  }

  Drawer drawerWidget(
      BuildContext context, List<DrawerTileData> arrayOfListTiles) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: ListView(
        children: [
          getDrawerHeader(context),
          const SizedBox(height: 22),
          for (DrawerTileData listTile in arrayOfListTiles)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
              child: setListTile(
                listTile.icon,
                listTile.tileName,
                () => listTile.callback(context),
              ),
            ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () async {
                  await sl<ApiClient>().clearTokens();
                  sl<AuthRepository>().clearUserCache();
                  sl<ProductRepository>().clearCache();
                  sl<CategoryRepository>().clearCache();
                  sl<BannerRepository>().clearCache();
                  if (context.mounted) {
                    AppNavigator.pushAndRemove(
                      context,
                      SigninPage(),
                    );
                  }
                },
                child: Row(
                  children: [
                    const Icon(Icons.logout, size: 18),
                    Text(
                      "Logout",
                      style: AppTextStyles.getAppTextStyleCustomized(
                        textColor: AppColors.black,
                        textSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  AppNavigator.push(context, const TermsAndConditionPage());
                },
                child: Text(
                  "Terms and Conditions",
                  style: AppTextStyles.getAppTextStyleCustomized(
                    textColor: AppColors.black,
                    textSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getDrawerHeader(BuildContext context) {
    return ClipPath(
      clipper: CurveClipper(),
      child: SizedBox(
        height: 280,
        child: Container(
          decoration: BoxDecoration(
            gradient: AppColors.drawerHeaderColor,
          ),
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Center(
                  child:
                      BlocBuilder<UserInfoDisplayCubit, UserInfoDisaplyState>(
                    builder: (context, state) {
                      if (state is UserInfoDisaplyLoading) {
                        return Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 218, 221, 227),
                          highlightColor: AppColors.colorDivider,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const CircleAvatar(
                                radius: 55,
                                backgroundColor: AppColors.white,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 16.h,
                                width: 120.w,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                height: 12.h,
                                width: 180.w,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      if (state is UserInfoDisaplyLoaded) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => pickAndUploadImage(context),
                              child: CircleAvatar(
                                backgroundImage: state.user.image.isEmpty
                                    ? const AssetImage(AppImages.profilemen)
                                    : NetworkImage(state.user.image),
                                radius: 55,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              state.user.firstName,
                              style: AppTextStyles.getAppTextStyleCustomized(
                                textColor: AppColors.white,
                                textSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              state.user.email,
                              style: AppTextStyles.getAppTextStyleCustomized(
                                textColor: AppColors.white,
                                textSize: 12,
                              ),
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: IconButton(
                    iconSize: 22,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile setListTile(
      IconData iconData, String data, GestureTapCallback onTap) {
    Color itemColor = Colors.black.withAlpha(127);
    return ListTile(
      leading: Icon(iconData, size: 18, color: itemColor),
      horizontalTitleGap: 14,
      title: Text(
        data,
        style: AppTextStyles.getAppTextStyleCustomized(
          textWeight: FontWeight.w500,
          textColor: itemColor,
          textSize: 16,
        ),
      ),
      onTap: onTap,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }

  Future<void> pickAndUploadImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      if (context.mounted) {
        var result = await sl<UploadUserImageUsecase>().call(params: imageFile);
        result.fold(
          (error) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          ),
          (imageUrl) {
            context.read<UserInfoDisplayCubit>().displayUserInfo();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Profile image updated successfully')),
            );
          },
        );
      }
    }
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 40;
    Offset controlPoint = Offset(size.width / 2, size.height + curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);

    Path path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
