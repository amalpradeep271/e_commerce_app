import 'package:e_commerce_application/core/configs/theme/app_theme.dart';
import 'package:e_commerce_application/firebase_options.dart';
import 'package:e_commerce_application/presentation/settings/bloc/theme_cubit.dart';
import 'package:e_commerce_application/presentation/spalsh/bloc/splash_cubit.dart';
import 'package:e_commerce_application/presentation/spalsh/pages/splash_page.dart';
import 'package:e_commerce_application/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => SplashCubit()..appStarted())
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'e commerce app',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: mode,
            home: const SplashPage(),
          ),
        ),
      ),
    );
  }
}
