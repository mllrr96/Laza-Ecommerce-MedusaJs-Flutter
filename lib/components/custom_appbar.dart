import 'package:flutter/material.dart';
import 'package:laza/extensions/context_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              onTap: () => Navigator.pop(context),
              child: Ink(
                width: 45,
                height: 45,
                decoration: ShapeDecoration(
                  color: context.theme.cardColor,
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.arrow_back_outlined),
              ),
            ),
            if (title != null)
              Text(
                title!,
                style: context.bodyLargeW500,
              ),
            const SizedBox(height: 45, width: 45)
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
