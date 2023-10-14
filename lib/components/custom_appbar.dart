import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 25),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          onTap: () => Navigator.pop(context),
          child: Ink(
            width: 45,
            height: 45,
            decoration: const ShapeDecoration(
              color: Color(0xffF5F6FA),
              shape: CircleBorder(),
            ),
            child: const Icon(Icons.arrow_back_outlined),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
