import 'package:flutter/material.dart';
import 'package:laza/common/extensions/context_extension.dart';

import '../../common/colors.dart';


class BottomNavButton extends StatelessWidget {
  const BottomNavButton({super.key, required this.label, required this.onTap});
  final String label;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final bottomPadding = context.bottomViewPadding;
    final buttonColor = onTap == null ? ColorConstant.primary.withOpacity(0.6) : ColorConstant.primary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          child: InkWell(
            onTap: onTap,
            child: Ink(
              color: buttonColor,
              height: 50,
              width: double.maxFinite,
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        Container(
          color: ColorConstant.primary,
          height: bottomPadding,
        ),
      ],
    );
  }
}
