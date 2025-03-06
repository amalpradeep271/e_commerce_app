import 'package:e_commerce_application/common/bloc/button/button_state.dart';
import 'package:e_commerce_application/common/bloc/textfield/password_visibility_cubit.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/app_bottom_navigationbar/custom_app_bottom_navigationbar.dart';
import 'package:e_commerce_application/common/widgets/app_button/basic_reactive_button.dart';
import 'package:e_commerce_application/common/widgets/app_textfield/basic_app_textformfield.dart';
import 'package:e_commerce_application/core/configs/assets/app_images.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:e_commerce_application/data/auth/models/user_creation_req.dart';
import 'package:e_commerce_application/domain/auth/usecase/signup_usecase.dart';
import 'package:e_commerce_application/presentation/auth/pages/signin_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/bloc/button/button_state_cubit.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
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
              AppNavigator.pushAndRemove(
                  context, const CustomAppBottomNavigationBar());
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              spacing: 20.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sigupText(),
                _firstNameField(),
                _lastNameField(),
                _emailField(),
                _passwordField(context),
                _signInText(context),
                _continueButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sigupText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 80.h,
        ),
        const Center(
          child: Image(
            image: AssetImage(
              AppImages.logo,
            ),
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        Text(
          "Sign Up",
          style: AppTextStyles.base.blackColor.s24.w600,
        ),
      ],
    );
  }

  Widget _firstNameField() {
    return CustomTextField(
      controller: _firstNameController,
      hintText: "Firstname",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Firstname cannot be empty';
        }

        return null;
      },
    );
  }

  Widget _lastNameField() {
    return CustomTextField(
      controller: _lastNameController,
      hintText: "Lastname",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Lastname cannot be empty';
        }

        return null;
      },
    );
  }

  Widget _emailField() {
    return CustomTextField(
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
    );
  }

  Widget _passwordField(BuildContext context) {
    return CustomTextField(
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
    );
  }

  Widget _continueButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return BasicReactiveButton(
          onPressed: () {
            var signUpReq = UserCreationReq(
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              email: _emailController.text,
              password: _passwordController.text,
            );
            context.read<ButtonStateCubit>().execute(
                  usecase: SignUpUseCase(),
                  params: signUpReq,
                );
            AppNavigator.pushReplacement(context, SigninPage());
          },
          title: "Sign Up",
        );
      },
    );
  }

  Widget _signInText(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
              text: "Do you have an account? ",
              style: TextStyle(
                color: AppColors.black,
              )),
          TextSpan(
            text: 'Signin',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigator.pushReplacement(context, SigninPage());
              },
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          )
        ],
      ),
    );
  }
}
