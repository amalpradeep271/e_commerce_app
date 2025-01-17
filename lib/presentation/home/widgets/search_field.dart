import 'package:e_commerce_application/common/helper/mode/is_dark_mode.dart';
import 'package:e_commerce_application/common/helper/navigator/app_navigator.dart';
import 'package:e_commerce_application/core/configs/assets/app_vectors.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/presentation/search/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        readOnly: true,
        onTap: () {
          AppNavigator.push(context, const SearchPage());
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          prefixIcon: SvgPicture.asset(
            AppVectors.search,
            fit: BoxFit.none,
          ),
          prefixIconColor:
              context.isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
          hintText: 'search',
        ),
      ),
    );
  }
}
