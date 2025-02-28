import 'package:e_commerce_application/common/bloc/textfield/password_visibility_cubit.dart';
import 'package:e_commerce_application/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordVisibilityCubit, bool>(
      builder: (context, isObscured) {
        return TextFormField(
          controller: controller,
          obscureText: isPassword ? isObscured : false,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.lightGray,
              ),
              borderRadius: BorderRadius.circular(25.0), // Added curve
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.kPrimaryColor, width: 3.0),
              borderRadius: BorderRadius.circular(25.0), // Added curve
              // Thicker border when focused
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isObscured ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      context
                          .read<PasswordVisibilityCubit>()
                          .toggleVisibility();
                    },
                  )
                : null,
          ),
          validator: validator,
        );
      },
    );
  }
}
