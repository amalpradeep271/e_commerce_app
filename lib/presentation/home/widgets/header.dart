// import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
// import 'package:e_commerce_application/core/configs/assets/app_images.dart';
// import 'package:e_commerce_application/core/configs/assets/app_vectors.dart';
// import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
// import 'package:e_commerce_application/domain/auth/entity/user_entity.dart';
// import 'package:e_commerce_application/presentation/cart/pages/cart_page.dart';
// import 'package:e_commerce_application/presentation/home/bloc/user_info_display_cubit.dart';
// import 'package:e_commerce_application/presentation/home/bloc/user_info_display_state.dart';
// import 'package:e_commerce_application/presentation/settings/pages/settings_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class Header extends StatelessWidget {
//   const Header({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => UserInfoDisplayCubit()..displayUserInfo(),
//       child: Padding(
//         padding: EdgeInsets.only(
//           top: 40.h,
//           right: 16.w,
//           left: 16.w,
//         ),
//         child: BlocBuilder<UserInfoDisplayCubit, UserInfoDisaplyState>(
//           builder: (context, state) {
//             if (state is UserInfoDisaplyLoading) {
//               return const Center(child: CupertinoActivityIndicator());
//             }
//             if (state is UserInfoDisaplyLoaded) {
//               return Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _profileImage(state.user, context),
//                   _gender(state.user, context),
//                   _card(context),
//                 ],
//               );
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }

//   Widget _profileImage(UserEntity user, BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         AppNavigator.push(context, const SettingsPage());
//       },
//       child: Container(
//         height: 40.h,
//         width: 40.w,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             fit: BoxFit.cover,
//             image: user.image.isEmpty
//                 ? AssetImage(
//                     user.gender == 1
//                         ? AppImages.profilemen
//                         : AppImages.profilewomen,
//                   )
//                 : NetworkImage(user.image),
//           ),
//           color: AppColors.red,
//           shape: BoxShape.circle,
//         ),
//       ),
//     );
//   }

//   Widget _gender(UserEntity user, BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: 16.w,
//       ),
//       height: 40.h,
//       decoration: BoxDecoration(
//         color: AppColors.secondBackground,
//         borderRadius: BorderRadius.circular(
//           100.r,
//         ),
//       ),
//       child: Center(
//         child: Text(
//           user.gender == 1 ? 'Men' : 'Women',
//           style: const TextStyle(
//             fontWeight: FontWeight.w500,
//             color: AppColors.whiteColor,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _card(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         AppNavigator.push(context, const CartPage());
//       },
//       child: Container(
//         height: 40.h,
//         width: 40.w,
//         decoration: const BoxDecoration(
//           color: AppColors.primary,
//           shape: BoxShape.circle,
//         ),
//         child: SvgPicture.asset(
//           AppVectors.bag,
//           fit: BoxFit.none,
//         ),
//       ),
//     );
//   }
// }
