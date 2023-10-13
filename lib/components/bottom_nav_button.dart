import 'package:flutter/material.dart';
import 'package:laza/components/colors.dart';

class BottomNavButton extends StatelessWidget {
  const BottomNavButton({super.key, required this.label, required this.onTap});
final String label;
final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          child: Ink(
            color: ColorConstant.primary,
            height: 50,
            width: double.maxFinite,
            child: Center(
              child: Text(label, style: const TextStyle(
                color: Colors.white, fontSize: 17,fontWeight: FontWeight.w500
              ),
              textAlign: TextAlign.center,
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
