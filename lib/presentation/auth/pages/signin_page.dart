import 'package:e_commerce_application/common/bloc/button/button_state.dart';
import 'package:e_commerce_application/common/bloc/button/button_state_cubit.dart';
import 'package:e_commerce_application/common/bloc/textfield/password_visibility_cubit.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_reactive_button.dart';
import 'package:e_commerce_application/common/widgets/app_textfield/basic_app_textformfield.dart';
import 'package:e_commerce_application/core/configs/assets/app_images.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/data/auth/models/user_signin_req.dart';
import 'package:e_commerce_application/domain/auth/usecase/signin_usecase.dart';
import 'package:e_commerce_application/presentation/home/pages/homepage.dart';
import 'package:flutter/gestures.dart';
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
            child: loginbody(context),
          )),
    );
  }

  Widget loginbody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: ListView(
        children: [
          SizedBox(
            height: 100.h,
          ),
          const Center(
            child: Image(
              image: AssetImage(AppImages.logo),
            ),
          ),
          SizedBox(
            height: 80.h,
          ),
          Text(
            "Login",
            style: AppTextStyles.base.blackColor.s24.w600,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomTextField(
            controller: _emailController,
            hintText: "Email",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email cannot be empty';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(
            height: 15.h,
          ),
          CustomTextField(
            controller: _passwordController,
            hintText: "Password",
            isPassword: true,
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
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRichText(
                "Don't you have an account? ",
                "Create one",
                () {
                  // AppNavigator.push(context, SignupPage());
                },
              ),
              _buildRichText(
                "Forgot password? ",
                "Reset",
                () {
                  // AppNavigator.push(context, ForgotPasswordPage());
                },
              ),
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
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
              title: "Login",
            );
          }),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildRichText(String text1, String text2, VoidCallback onTap) {
    return Expanded(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text1,
              style: AppTextStyles.base.grayColor.s14.w500,
            ),
            TextSpan(
              text: text2,
              recognizer: TapGestureRecognizer()..onTap = onTap,
              style: AppTextStyles.base.grayColor.s14.w900,
            ),
          ],
        ),
      ),
    );
  }
}
