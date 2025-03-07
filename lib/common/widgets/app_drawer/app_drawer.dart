import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/app_bottom_navigationbar/custom_app_bottom_navigationbar.dart';
import 'package:e_commerce_application/core/configs/assets/app_images.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_icons.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/presentation/auth/pages/signin_page.dart';
import 'package:e_commerce_application/presentation/home/bloc/user_info_display_cubit.dart';
import 'package:e_commerce_application/presentation/home/bloc/user_info_display_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
          const CustomAppBottomNavigationBar(),
        );
      }),
      DrawerTileData(Icons.share, "Share App", (context) {}),
      DrawerTileData(AppIcons.contact, "Contact Us", (context) {
        // Implement Contact Us Navigation
      }),
      DrawerTileData(AppIcons.privacypolicy, "Privacy Policy", (context) {
        // Implement Privacy Policy Navigation
      }),
    ];

    return BlocProvider(
      create: (context) => UserInfoDisplayCubit()..displayUserInfo(),
      child: SizedBox(
        width: 500,
        child: drawerWidget(context, arrayOfListTiles),
      ),
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
                  await FirebaseAuth.instance.signOut();
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
                  // Implement Terms and Conditions Navigation
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
          decoration: const BoxDecoration(
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
                        return const Center(
                            child: CupertinoActivityIndicator());
                      }
                      if (state is UserInfoDisaplyLoaded) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => _pickImage(context),
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
                      // Close Drawer Action
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

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      if (context.mounted) {
        await _uploadImage(context, imageFile);
      }
    }
  }

  Future<void> _uploadImage(BuildContext context, File imageFile) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String fileName = 'users/$userId/profile.jpg';

      // Upload to Firebase Storage
      Reference ref = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;

      // Get download URL
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Update Firestore document
      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'image': imageUrl,
      });
      if (context.mounted) {
        // Notify Bloc to reload user data

        context.read<UserInfoDisplayCubit>().displayUserInfo();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile image updated successfully')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        // Notify Bloc to reload user data

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error uploading image')),
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
