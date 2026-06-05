import 'package:e_commerce_application/common/bloc/textfield/password_visibility_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.prefixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordVisibilityCubit, bool>(
      builder: (context, isObscured) {
        return TextFormField(
          controller: controller,
          obscureText: isPassword ? isObscured : false,
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isObscured ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
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
