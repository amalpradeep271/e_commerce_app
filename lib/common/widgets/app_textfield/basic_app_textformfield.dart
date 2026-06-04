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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<PasswordVisibilityCubit, bool>(
      builder: (context, isObscured) {
        return TextFormField(
          controller: controller,
          obscureText: isPassword ? isObscured : false,
          style: TextStyle(
            fontSize: 15,
            color: isDark ? Colors.white : Colors.black,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            filled: true,
            fillColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: isDark ? const Color(0xFF334155) : Colors.grey.shade300,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isDark ? const Color(0xFF334155) : Colors.grey.shade300,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.kPrimaryColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isObscured ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                      size: 20,
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
