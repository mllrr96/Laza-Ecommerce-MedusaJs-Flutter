import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:laza/intro_screen.dart';
import 'colors.dart';
import 'laza_icons.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5),
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    onTap: () => Scaffold.of(context).closeDrawer(),
                    child: Ink(
                      width: 45,
                      height: 45,
                      decoration: const ShapeDecoration(
                        color: Color(0xffF5F6FA),
                        shape: CircleBorder(),
                      ),
                      child: const Icon(
                        LazaIcons.menu_vertical,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 24,
                              child: Text('M'),
                            ),
                            SizedBox(width: 10.0),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Mrh Raju'),
                                  Row(
                                    children: [
                                      Flexible(child: Text('Verified Profile')),
                                      SizedBox(width: 5.0),
                                      Icon(LazaIcons.verified_badge, size: 15,color: Colors.green,)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                            color: Color(0xffF5F6FA), borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: const Text(
                          '3 Orders',
                          style: TextStyle(color: Color(0xff8F959E)),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                ListTile(
                  leading: const Icon(LazaIcons.sun),
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  title: const Text('Dark Mode', style: TextStyle(fontSize: 15.0)),
                  trailing: Switch.adaptive(
                      activeColor: Platform.isIOS ? ColorConstant.primary : null, value: true, onChanged: (val) {}),
                  horizontalTitleGap: 10.0,
                ),
                ListTile(
                  leading: const Icon(LazaIcons.info_circle),
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  title: const Text('Account Information', style: TextStyle(fontSize: 15.0)),
                  horizontalTitleGap: 10.0,
                ),
                ListTile(
                  leading: const Icon(LazaIcons.lock),
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  title: const Text('Password', style: TextStyle(fontSize: 15.0)),
                  horizontalTitleGap: 10.0,
                ),
                ListTile(
                  leading: const Icon(LazaIcons.bag),
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  title: const Text('Order', style: TextStyle(fontSize: 15.0)),
                  horizontalTitleGap: 10.0,
                ),
                ListTile(
                  leading: const Icon(LazaIcons.wallet),
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  title: const Text('My Cards', style: TextStyle(fontSize: 15.0)),
                  horizontalTitleGap: 10.0,
                ),
                ListTile(
                  leading: const Icon(LazaIcons.heart),
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  title: const Text('Whislist', style: TextStyle(fontSize: 15.0)),
                  horizontalTitleGap: 10.0,
                ),
                ListTile(
                  leading: const Icon(LazaIcons.settings),
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  title: const Text('Settings', style: TextStyle(fontSize: 15.0)),
                  horizontalTitleGap: 10.0,
                ),
              ],
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(LazaIcons.logout, color: Colors.red),
                  onTap: () async {
                    await showOkCancelAlertDialog(
                      context: context,
                      title: 'Confirm Logout',
                      message: 'Are you sure you want to logout?',
                      isDestructiveAction: true,
                      okLabel: 'Logout',
                    ).then((result) {
                      if (result == OkCancelResult.ok) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const IntroductionScreen()),
                            (Route<dynamic> route) => false);
                      }
                    });
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  title: const Text('Logout', style: TextStyle(fontSize: 15.0, color: Colors.red)),
                  horizontalTitleGap: 10.0,
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
