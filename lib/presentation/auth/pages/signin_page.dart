import 'package:e_commerce_application/common/bloc/button/button_state.dart';
import 'package:e_commerce_application/common/bloc/button/button_state_cubit.dart';
import 'package:e_commerce_application/common/bloc/textfield/password_visibility_cubit.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/presentation/home/pages/main_page.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_reactive_button.dart';
import 'package:e_commerce_application/common/widgets/app_textfield/basic_app_textformfield.dart';
import 'package:e_commerce_application/core/configs/assets/app_images.dart';
import 'package:e_commerce_application/data/auth/models/user_signin_req.dart';
import 'package:e_commerce_application/domain/auth/usecase/signin_usecase.dart';
import 'package:e_commerce_application/presentation/auth/pages/forgot_password_page.dart';
import 'package:e_commerce_application/presentation/auth/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ButtonStateCubit(),
            ),
            BlocProvider(
              create: (context) => PasswordVisibilityCubit(),
            ),
          ],
          child: BlocListener<ButtonStateCubit, ButtonState>(
            listener: (context, state) {
              if (state is ButtonFailureState) {
                debugPrint('Signin Error: ${state.errorMessage}');
                var snackbar = SnackBar(
                  content: Text(
                    state.errorMessage,
                  ),
                  behavior: SnackBarBehavior.floating,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
              if (state is ButtonSuccessState) {
                AppNavigator.pushAndRemove(context, MainPage());
              }
            },
            child: loginbody(context),
          )),
    );
  }

  Widget loginbody(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [colorScheme.surface, colorScheme.surfaceContainerHighest]
              : [Colors.white, const Color(0xFFF0FDFA)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.h),
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                AppImages.logo,
                width: 60.w,
                height: 60.h,
              ),
              SizedBox(height: 24.h),
              Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Sign in to continue shopping",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email Address",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: _emailController,
                    hintText: "name@example.com",
                    prefixIcon: Icon(Icons.mail_outline,
                        color: colorScheme.outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email cannot be empty';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          AppNavigator.push(
                              context, ForgotPasswordPage());
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: "••••••••",
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock_outline,
                        color: colorScheme.outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Builder(builder: (context) {
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
                  title: "Sign In",
                );
              }),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                      child:
                          Divider(color: colorScheme.outlineVariant)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: colorScheme.outline,
                      ),
                    ),
                  ),
                  Expanded(
                      child:
                          Divider(color: colorScheme.outlineVariant)),
                ],
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.g_mobiledata,
                      size: 32.sp, color: colorScheme.primary),
                  label: Text(
                    "Continue with Google",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: colorScheme.outlineVariant),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: colorScheme.outline,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AppNavigator.push(context, SignupPage());
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
