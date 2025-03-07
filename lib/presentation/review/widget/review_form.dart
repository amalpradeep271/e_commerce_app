import 'package:e_commerce_application/common/widgets/app_button/basic_reactive_button.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_icons.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewForm extends StatelessWidget {
  ReviewForm({super.key});

  final reviewValidator = GlobalKey<FormState>();
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          child: TextFormField(
            controller: _reviewController,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText:
                    "Share the details of your own experience on this product"),
            validator: (value) {
              if (value!.isEmpty) {
                return 'cannot post empty review type something';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BasicReactiveButton(
              onPressed: () {},
              title: "Submit",
            ),
            const Icon(
              AppIcons.success,
              color: AppColors.accountblue,
            ),
          ],
        ),
      ],
    );
  }
}
