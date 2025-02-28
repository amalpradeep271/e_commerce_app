import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/core/configs/assets/app_images.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_icons.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/presentation/home/bloc/user_info_display_cubit.dart';
import 'package:e_commerce_application/presentation/home/bloc/user_info_display_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class DrawerTileData {
  final IconData icon;
  final String tileName;
  final VoidCallback callback;

  DrawerTileData(this.icon, this.tileName, this.callback);
}

var arrayOfListTiles = [
  DrawerTileData(AppIcons.home, "Home", () {
    // Navigator.pop(Get.context!);
    // Get.toNamed(AppRoutes.landingscreen);
  }),
  DrawerTileData(Icons.share, "Share App", () {}),
  DrawerTileData(AppIcons.contact, "Contact Us", () {
    // Navigator.pop(Get.context!);
    // Get.toNamed(AppRoutes.contactus);
  }),
  DrawerTileData(AppIcons.privacypolicy, "Privacy Policy", () {
    // Navigator.pop(Get.context!);
    // Get.toNamed(AppRoutes.privacypolicy);
  }),
  // DrawerTileData(Icons.policy, "Disclaimer", () {
  //   // Navigator.pop( BuildContext context);
  //   // Get.toNamed(AppRoutes.disclaimer);
  // }),
];

class CustomAppDrawer extends StatelessWidget {
  CustomAppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserInfoDisplayCubit()..displayUserInfo(),
      child: SizedBox(
          width: 500,
          child: drawerWidget(
            context,
          )),
    );
  }

  Drawer drawerWidget(
    BuildContext context,
  ) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: [
          getDrawerHeader(),
          const SizedBox(
            height: 22,
          ),
          for (DrawerTileData listTile in arrayOfListTiles)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
              child: setListTile(
                  listTile.icon, listTile.tileName, listTile.callback),
            ),
          const SizedBox(
            height: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      size: 18,
                    ),
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
                  // Navigator.pop(Get.context!);
                  // Get.toNamed(AppRoutes.termsandconditions);
                },
                child: Text(
                  "Term and Condition",
                  style: AppTextStyles.getAppTextStyleCustomized(
                    textColor: AppColors.black,
                    textSize: 12,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getDrawerHeader() {
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
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              state.user.firstName,
                              style: AppTextStyles.getAppTextStyleCustomized(
                                  textColor: AppColors.white, textSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              state.user.email,
                              style: AppTextStyles.getAppTextStyleCustomized(
                                  textColor: AppColors.white, textSize: 12),
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
                  padding: const EdgeInsets.only(top: 20, bottom: 0),
                  child: IconButton(
                    iconSize: 22,
                    onPressed: () {
                      // Navigator.pop(Get.overlayContext!);
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
      leading: Icon(
        iconData,
        size: 18,
        color: itemColor,
      ),
      horizontalTitleGap: 14,
      title: Text(
        data,
        style: AppTextStyles.getAppTextStyleCustomized(
            textWeight: FontWeight.w500, textColor: itemColor, textSize: 16),
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
