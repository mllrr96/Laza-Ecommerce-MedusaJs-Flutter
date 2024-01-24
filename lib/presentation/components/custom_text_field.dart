import 'package:flutter/material.dart';
import 'package:laza/common/colors.dart';
import 'package:laza/common/extensions/extensions.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.textInputAction,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.onFieldSubmitted,
    this.textCapitalization,
  });
  final String labelText;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final void Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction ?? TextInputAction.next,
      obscureText: obscureText,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: context.bodySmall?.copyWith(color: ColorConstant.manatee),
      ),
    );
  }
}
