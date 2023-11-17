import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laza/common/extensions/context_extension.dart';
import 'package:laza/presentation/components/index.dart';
import '../../common/colors.dart';
import '../routes/app_router.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';


var dashboardScaffoldKey = GlobalKey<ScaffoldState>();

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool pop = false;
  @override
  Widget build(BuildContext context) {
    final bottomBarBgColor = context.theme.bottomNavigationBarTheme.backgroundColor;
    final systemOverlay = context.theme.appBarTheme.systemOverlayStyle;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemOverlay!.copyWith(systemNavigationBarColor: bottomBarBgColor),
      child: WillPopScope(
        onWillPop: () async {
          if (Platform.isIOS) {
            return true;
          }
          if (pop) {
            return true;
          }
          Fluttertoast.showToast(msg: 'Press again to exist the app');
          pop = true;
          Timer(const Duration(seconds: 2), () {
            pop = false;
          });
          return false;
        },
        child: AutoTabsRouter(
          routes: const [
            HomeRoute(),
            WishlistRoute(),
            CartRoute(),
            MyCardsRoute(),
          ],
          builder: (context, child) {
            final tabsRouter = AutoTabsRouter.of(context);

            return Scaffold(
              key: dashboardScaffoldKey,
              drawer: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: const DrawerWidget(),
              ),
              body: child,
              bottomNavigationBar: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 56,
                    child: SlidingClippedNavBar(
                      backgroundColor: bottomBarBgColor ?? Colors.white,
                      onButtonPressed: (index) {
                        tabsRouter.setActiveIndex(index);
                      },
                      iconSize: 25,
                      activeColor: ColorConstant.primary,
                      inactiveColor: const Color(0xff8F959E),
                      selectedIndex: tabsRouter.activeIndex,
                      barItems: [
                        BarItem(
                          icon: LazaIcons.home,
                          title: 'Home',
                        ),
                        BarItem(
                          icon: LazaIcons.heart,
                          title: 'Wishlist',
                        ),
                        BarItem(
                          icon: LazaIcons.bag,
                          title: 'Cart',
                        ),
                        BarItem(
                          icon: LazaIcons.wallet,
                          title: 'My Cards',
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: context.bottomViewPadding),
                    color: bottomBarBgColor,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
