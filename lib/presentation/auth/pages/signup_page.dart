import 'package:e_commerce_application/common/helper/mode/is_dark_mode.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_app_button.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/data/auth/models/user_creation_req.dart';
import 'package:e_commerce_application/presentation/auth/pages/gender_and_age_selection_page.dart';
import 'package:e_commerce_application/presentation/auth/pages/signin_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sigupText(),
            SizedBox(height: 20.h),
            _firstNameField(),
            SizedBox(height: 20.h),
            _lastNameField(),
            SizedBox(height: 20.h),
            _emailField(),
            SizedBox(height: 20.h),
            _passwordField(context),
            SizedBox(height: 20.h),
            _continueButton(context),
            SizedBox(height: 20.h),
            _signInText(context),
          ],
        ),
      ),
    );
  }

  Widget _sigupText() {
    return const Text(
      'Create Account',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget _firstNameField() {
    return TextFormField(
      controller: _firstNameController,
      decoration: const InputDecoration(hintText: 'Firstname'),
    );
  }

  Widget _lastNameField() {
    return TextFormField(
      controller: _lastNameController,
      decoration: const InputDecoration(hintText: 'Lastname'),
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(hintText: 'Email Address'),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(hintText: 'Password'),
    );
  }

  Widget _continueButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        AppNavigator.push(
          context,
          GenderAndAgeSelectionPage(
            userCreationReq: UserCreationReq(
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              email: _emailController.text,
              password: _passwordController.text,
            ),
          ),
        );
      },
      title: 'Continue',
    );
  }

  Widget _signInText(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: "Do you have an account? ",
              style: TextStyle(
                color: context.isDarkMode
                    ? AppColors.whiteColor
                    : AppColors.blackColor,
              )),
          TextSpan(
            text: 'Signin',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigator.pushReplacement(context, SignInPage());
              },
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: context.isDarkMode
                  ? AppColors.whiteColor
                  : AppColors.blackColor,
            ),
          )
        ],
      ),
    );
  }
}
