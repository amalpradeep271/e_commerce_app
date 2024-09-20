import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_app_button.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/presentation/auth/pages/signup_page.dart';
import 'package:e_commerce_application/presentation/settings/widgets/my_account_tile.dart';
import 'package:e_commerce_application/presentation/settings/widgets/my_favourites_tile.dart';
import 'package:e_commerce_application/presentation/settings/widgets/my_orders_tile.dart';
import 'package:e_commerce_application/presentation/settings/widgets/theme_mode_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            const MyAccountTile(),
            SizedBox(
              height: 15.h,
            ),
            const MyFavortiesTile(),
            SizedBox(
              height: 15.h,
            ),
            const MyOrdersTile(),
            SizedBox(
              height: 15.h,
            ),
            const ThemeModeTile(),
            SizedBox(
              height: 15.h,
            ),
            BasicAppButton(
              title: 'SignOut',
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                AppNavigator.pushAndRemove(context, SignupPage());
              },
            )
          ],
        ),
      ),
    );
  }
}
