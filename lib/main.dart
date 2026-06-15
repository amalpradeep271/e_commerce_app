import 'package:e_commerce_application/common/bloc/internet_connectivity/internet_connectivity_cubit.dart';
import 'package:e_commerce_application/core/configs/theme/app_theme.dart';
import 'package:e_commerce_application/firebase_options.dart';
import 'package:e_commerce_application/presentation/splash/bloc/splash_cubit.dart';
import 'package:e_commerce_application/presentation/splash/pages/splash_page.dart';
import 'package:e_commerce_application/presentation/settings/bloc/theme_cubit.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_application/core/configs/tenant/tenant_config.dart';
import 'package:e_commerce_application/core/configs/tenant/tenant_config_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const slug = String.fromEnvironment('TENANT_SLUG', defaultValue: 'khadi');
  await TenantConfigService.initialize(slug);

  await initializeDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ConnectivityCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
        create: (context) => SplashCubit()..appStarted(),
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: TenantConfig.instance.appName,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.appTheme,
              themeMode: themeMode,
              home: const SplashPage(),
            );
          },
        ),
      ),
    );
  }
}
