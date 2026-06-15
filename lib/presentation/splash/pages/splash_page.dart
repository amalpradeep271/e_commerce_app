import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/presentation/home/pages/main_page.dart';
import 'package:e_commerce_application/core/configs/assets/app_images.dart';
import 'package:e_commerce_application/presentation/auth/pages/signin_page.dart';
import 'package:e_commerce_application/presentation/splash/bloc/splash_cubit.dart';
import 'package:e_commerce_application/presentation/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_application/core/configs/tenant/tenant_config.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        Future.delayed(const Duration(milliseconds: 1800), () {
          if (mounted) {
            if (state is UnAuthenticated) {
              AppNavigator.pushReplacement(context, SigninPage());
            }
            if (state is Authenticated) {
              AppNavigator.pushReplacement(context, MainPage());
            }
          }
        });
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? [
                      colorScheme.surface,
                      colorScheme.primaryContainer.withValues(alpha: 0.2),
                      colorScheme.surface,
                    ]
                  : [
                      colorScheme.surface,
                      colorScheme.primaryContainer.withValues(alpha: 0.3),
                      colorScheme.surface,
                    ],
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: TenantConfig.instance.logoUrl,
                          width: 140,
                          height: 140,
                          placeholder: (context, url) => const SizedBox(
                            width: 140,
                            height: 140,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            AppImages.logo,
                            width: 140,
                            height: 140,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          TenantConfig.instance.appName,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          TenantConfig.instance.tagline,
                          style: TextStyle(
                            fontSize: 14,
                            color: colorScheme.onSurfaceVariant,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Center(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SizedBox(
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          color: colorScheme.primary,
                          backgroundColor: colorScheme.surfaceContainerHighest,
                          minHeight: 4,
                        ),
                      ),
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
}
