import 'package:e_commerce_application/common/bloc/button/button_state.dart';
import 'package:e_commerce_application/common/bloc/button/button_state_cubit.dart';
import 'package:e_commerce_application/common/helper/mode/is_dark_mode.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_reactive_button.dart';
import 'package:e_commerce_application/common/widgets/appbar/app_bar.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/data/auth/models/user_signin_req.dart';
import 'package:e_commerce_application/domain/auth/usecase/signin_usecase.dart';
import 'package:e_commerce_application/presentation/auth/pages/forgot_password_page.dart';
import 'package:e_commerce_application/presentation/auth/pages/signup_page.dart';
import 'package:e_commerce_application/presentation/home/pages/homepage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BasicAppbar(hideBack: true),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
          child: BlocProvider(
            create: (context) => ButtonStateCubit(),
            child: BlocListener<ButtonStateCubit, ButtonState>(
              listener: (context, state) {
                if (state is ButtonFailureState) {
                  var snackbar = SnackBar(
                    content: Text(
                      state.errorMessage,
                    ),
                    behavior: SnackBarBehavior.floating,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
                if (state is ButtonSuccessState) {
                  AppNavigator.pushAndRemove(context, const HomePage());
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _siginText(context),
                    SizedBox(height: 20.h),
                    _emailField(context),
                    SizedBox(height: 20.h),
                    _passwordField(context),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _forgotPassword(context)),
                        Expanded(child: _createAccount(context)),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    _continueButton(context)
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _siginText(BuildContext context) {
    return Text(
      'Sign in',
      style: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(hintText: 'Enter Email'),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(hintText: 'Enter Password'),
    );
  }

  Widget _continueButton(BuildContext context) {
    return Builder(builder: (context) {
      return BasicReactiveButton(
          onPressed: () {
            var signInReq = UserSignInReq(
              email: _emailController.text,
              password: _passwordController.text,
            );
            context.read<ButtonStateCubit>().execute(
                  usecase: SignInUseCase(),
                  params: signInReq,
                );
          },
          title: 'Continue');
    });
  }

  Widget _createAccount(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Don't you have an account? ",
            style: TextStyle(
              fontSize: 14,
              color: context.isDarkMode
                  ? AppColors.whiteColor
                  : AppColors.blackColor,
            ),
          ),
          TextSpan(
            text: 'Create one',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigator.push(context, SignupPage());
              },
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: context.isDarkMode
                  ? AppColors.whiteColor
                  : AppColors.blackColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Forgot password? ",
            style: TextStyle(
              fontSize: 14,
              color: context.isDarkMode
                  ? AppColors.whiteColor
                  : AppColors.blackColor,
            ),
          ),
          TextSpan(
            text: 'Reset',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigator.push(context, ForgotPasswordPage());
              },
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
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
