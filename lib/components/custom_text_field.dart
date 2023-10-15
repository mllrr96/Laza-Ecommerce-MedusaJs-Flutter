import 'package:flutter/material.dart';
import 'package:laza/components/colors.dart';
import 'package:laza/extensions/context_extension.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.labelText, this.controller, this.textInputAction, this.validator});
  final String labelText;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      textInputAction: textInputAction ?? TextInputAction.next,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: context.bodySmall?.copyWith(color: ColorConstant.manatee),
      ),
    );
  }
}
