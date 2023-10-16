import 'package:flutter/material.dart';
import 'package:laza/extensions/context_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title, this.actions});
  final String? title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
    return Container(
      height: kToolbarHeight,
      margin: EdgeInsets.only(top: context.viewPadding.top),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: canPop || actions != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
          children: [
            if (canPop)
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
            if (!canPop && actions != null) const SizedBox(height: 45, width: 45),
            if (title != null) Text(title!, style: context.bodyLargeW500),
            if (canPop && actions == null) const SizedBox(height: 45, width: 45),
            if (actions != null)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: actions!,
              )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
