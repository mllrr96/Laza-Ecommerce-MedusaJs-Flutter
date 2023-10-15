import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:laza/extensions/context_extension.dart';
import 'package:laza/intro_screen.dart';
import 'package:laza/theme.dart';
import 'package:provider/provider.dart';
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
        bottom: false,
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
                      decoration: ShapeDecoration(
                        color: context.theme.cardColor,
                        shape: const CircleBorder(),
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
                                      Icon(
                                        LazaIcons.verified_badge,
                                        size: 15,
                                        color: Colors.green,
                                      )
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
                        decoration: BoxDecoration(
                            color: context.theme.cardColor, borderRadius: const BorderRadius.all(Radius.circular(5.0))),
                        child: Text(
                          '3 Orders',
                          style: TextStyle(color: ColorConstant.manatee),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                Consumer<ThemeNotifier>(
                  builder: (context, themeNotifier, _) {
                    return ListTile(
                      leading: const Icon(LazaIcons.sun),
                      onTap: () => themeNotifier.toggleTheme(),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                      title: const Text('Appearance'),
                      trailing: Switch.adaptive(
                          activeColor: Platform.isIOS ? ColorConstant.primary : null,
                          value: themeNotifier.darkTheme,
                          onChanged: (_) => themeNotifier.toggleTheme()),
                      horizontalTitleGap: 10.0,
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(LazaIcons.info_circle),
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  title: const Text('Account Information'),
                  horizontalTitleGap: 10.0,
                ),
                ListTile(
                  leading: const Icon(LazaIcons.lock),
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  title: const Text('Password'),
                  horizontalTitleGap: 10.0,
                ),
                ListTile(
                  leading: const Icon(LazaIcons.bag),
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  title: const Text('Order'),
                  horizontalTitleGap: 10.0,
                ),
                ListTile(
                  leading: const Icon(LazaIcons.wallet),
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  title: const Text('My Cards'),
                  horizontalTitleGap: 10.0,
                ),
                ListTile(
                  leading: const Icon(LazaIcons.heart),
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  title: const Text('Whislist'),
                  horizontalTitleGap: 10.0,
                ),
                ListTile(
                  leading: const Icon(LazaIcons.settings),
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  title: const Text('Settings'),
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
                  title: const Text('Logout'),
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
