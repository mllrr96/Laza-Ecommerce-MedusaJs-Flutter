import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:laza/common/extensions/extensions.dart';

import '../../../components/index.dart';
import '../../../routes/app_router.dart';
import '../../dashboard_screen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: 'search_back',
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    onTap: () {
                      dashboardScaffoldKey.currentState?.openDrawer();
                    },
                    child: Ink(
                      width: 45,
                      height: 45,
                      decoration: ShapeDecoration(
                        color: context.theme.cardColor,
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(
                        LazaIcons.menu_horizontal,
                        size: 13,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    onTap: () => context.router.push(const CartRoute()),
                    child: Ink(
                      width: 45,
                      height: 45,
                      decoration: ShapeDecoration(
                        color: context.theme.cardColor,
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(
                        LazaIcons.bag,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
