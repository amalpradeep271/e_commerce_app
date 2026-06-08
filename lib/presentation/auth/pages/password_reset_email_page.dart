import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_app_button.dart';
import 'package:e_commerce_application/core/configs/assets/app_vectors.dart';
import 'package:e_commerce_application/presentation/auth/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordResetEmailPage extends StatelessWidget {
  const PasswordResetEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emailSending(),
          SizedBox(height: 20.h),
          _sentEmailText(),
          SizedBox(height: 20.h),
          _returnToLoginButton(context),
        ],
      ),
    );
  }

  Widget _emailSending() {
    return Center(
      child: SvgPicture.asset(AppVectors.emailSending),
    );
  }

  Widget _sentEmailText() {
    return const Center(
      child: Text('We Sent you an Email to reset your password.'),
    );
  }

  Widget _returnToLoginButton(BuildContext context) {
    return BasicAppButton(
        onPressed: () {
          AppNavigator.pushReplacement(context, SigninPage());
        },
        width: 200,
        title: 'Return to Login');
  }
}
