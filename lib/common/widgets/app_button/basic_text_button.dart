import 'package:e_commerce_application/common/bloc/button/button_state.dart';
import 'package:e_commerce_application/common/bloc/button/button_state_cubit.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:e_commerce_application/core/configs/theme/app_icons.dart';
import 'package:e_commerce_application/core/configs/theme/app_text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const BasicTextButton({required this.onPressed, this.title = '', super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonStateCubit, ButtonState>(builder: (_, state) {
      if (state is ButtonLoadingState) {
        return _loading();
      }
      return _initial();
    });
  }

  Widget _loading() {
    return TextButton(
      onPressed: null,
      child: Container(
        alignment: Alignment.center,
        child: const CupertinoActivityIndicator(),
      ),
    );
  }

  Widget _initial() {
    return Row(
      children: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: AppTextStyles.base.accountblue.s16.w700,
          ),
        ),
        const Icon(
          AppIcons.success,
          color: AppColors.accountblue,
        ),
      ],
    );
  }
}
