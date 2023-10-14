import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:laza/components/colors.dart';
import 'package:laza/components/drawer.dart';
import 'package:laza/components/laza_icons.dart';
import 'package:laza/home_screen.dart';
import 'package:laza/order_confirmed_screen.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
var dashboardScaffoldKey = GlobalKey<ScaffoldState>();
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final pageController = PageController();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: dashboardScaffoldKey,
      drawer: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: const DrawerWidget(),
      ),      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          HomeScreen(),
          OrderConfirmedScreen(),
          HomeScreen(),
          HomeScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 56,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
        child: SlidingClippedNavBar(
          backgroundColor: Colors.white,
          onButtonPressed: (index) {
            setState(() {
              selectedIndex = index;
            });
            pageController.jumpToPage(selectedIndex);
          },
          iconSize: 25,
          activeColor: ColorConstant.primary,
          inactiveColor: const Color(0xff8F959E),
          selectedIndex: selectedIndex,
          barItems: [
            BarItem(
              icon: LazaIcons.home,
              title: 'Home',
            ),
            BarItem(
              icon: LazaIcons.heart,
              title: 'Wishlist',
            ), BarItem(
              icon: LazaIcons.bag,
              title: 'Cart',
            ), BarItem(
              icon: LazaIcons.wallet,
              title: 'My Cards',
            ),
          ],
        ),
      ),
    );
  }
}
