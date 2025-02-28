// import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
// import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
// import 'package:e_commerce_application/presentation/settings/pages/my_account_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class MyAccountTile extends StatelessWidget {
//   const MyAccountTile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         AppNavigator.push(context, const MyAccountPage());
//       },
//       child: Container(
//         height: 70.h,
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         decoration: BoxDecoration(
//           color: AppColors.secondBackground,
//           borderRadius: BorderRadius.circular(10.r),
//         ),
//         child: const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'My Account',
//               style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: 16,
//                 color: AppColors.whiteColor,
//               ),
//             ),
//             Icon(Icons.arrow_forward_ios_rounded)
//           ],
//         ),
//       ),
//     );
//   }
// }
