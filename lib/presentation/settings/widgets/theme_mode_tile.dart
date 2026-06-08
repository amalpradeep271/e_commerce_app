// import 'dart:developer';
// import 'dart:ui';

// import 'package:e_commerce_application/common/helper/bottomsheet/app_bottomsheet.dart';
// import 'package:e_commerce_application/common/helper/mode/is_dark_mode.dart';
// import 'package:e_commerce_application/core/configs/assets/app_vectors.dart';
// import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
// import 'package:e_commerce_application/presentation/settings/bloc/theme_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class ThemeModeTile extends StatelessWidget {
//   const ThemeModeTile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         modeWidget(
//           context: context,
//           onTap: () {
//             log('dark');
//             context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
//           },
//           icon: AppVectors.moon,
//           iconName: 'Dark Mode',
//         ),
//         const SizedBox(
//           width: 40,
//         ),
//         modeWidget(
//           context: context,
//           onTap: () {
//             log('light');
//             context.read<ThemeCubit>().updateTheme(ThemeMode.light);
//           },
//           icon: AppVectors.sun,
//           iconName: 'Light Mode',
//         ),
//       ],
//     );
//   }

//   Widget modeWidget({
//     required String icon,
//     required String iconName,
//     required VoidCallback onTap,
//     required BuildContext context,
//   }) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: onTap,
//           child: ClipOval(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//               child: Container(
//                 width: 70.w,
//                 height: 70.h,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: context.isDarkMode
//                       ? AppColors.blur.withOpacity(0.5)
//                       : AppColors.blur.withOpacity(0.08),
//                 ),
//                 child: Center(
//                   child: Container(
//                     width: 40.w,
//                     height: 40.h,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                     ),
//                     child: SvgPicture.asset(
//                       icon,
//                       // colorFilter: const ColorFilter.mode(
//                       //   // AppColors.greyColor,
//                       //   BlendMode.srcIn,
//                       // ),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         Text(
//           iconName,
//           style: const TextStyle(
//             fontWeight: FontWeight.w500,
//             fontSize: 17,
//             color: AppColors.greyColor,
//           ),
//         ),
//       ],
//     );
//   }
// }
