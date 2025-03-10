import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/common/widgets/app_bottom_navigationbar/custom_app_bottom_navigationbar.dart';
import 'package:e_commerce_application/core/configs/assets/app_images.dart';
import 'package:e_commerce_application/presentation/auth/pages/signin_page.dart';
import 'package:e_commerce_application/presentation/spalsh/bloc/splash_cubit.dart';
import 'package:e_commerce_application/presentation/spalsh/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          AppNavigator.pushReplacement(context, SigninPage());
        }
        if (state is Authenticated) {
          AppNavigator.pushReplacement(
              context, const CustomAppBottomNavigationBar());
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(AppImages.logo),
        ),
      ),
    );
  }
}
