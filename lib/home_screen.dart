import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laza/components/colors.dart';
import 'package:laza/components/laza_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const brands = [
      Brand('Adidas', LazaIcons.adidas),
      Brand('Nike', LazaIcons.vector),
      Brand('Puma', LazaIcons.puma_logo_1),
      Brand('Fila', LazaIcons.fila),
    ];

    return Scaffold(
      appBar: const HomeAppBar(),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10),
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  onTap: () {},
                  child: Ink(
                    width: 45,
                    height: 45,
                    decoration: const ShapeDecoration(
                      color: Color(0xffF5F6FA),
                      shape: CircleBorder(),
                    ),
                    child: const Icon(
                      LazaIcons.menu2,
                      size: 13,
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
                    const Row(
                      children: [
                        CircleAvatar(
                          maxRadius: 25,
                          child: Text('M'),
                        ),
                        SizedBox(width: 15.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Mrh Raju'),
                            Text('Verified Profile'),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                          color: Color(0xffF5F5F5), borderRadius: BorderRadius.all(Radius.circular(5.0))),
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
                leading: const Icon(Icons.brightness_2),
                onTap: () {},
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                title: const Text('Dark Mode', style: TextStyle(fontSize: 15.0)),
                trailing: Switch.adaptive(
                    activeColor: Platform.isIOS ? ColorConstant.primary : null, value: true, onChanged: (val) {}),
                horizontalTitleGap: 10.0,
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                onTap: () {},
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                title: const Text('Account Information', style: TextStyle(fontSize: 15.0)),
                horizontalTitleGap: 10.0,
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                onTap: () {},
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                title: const Text('Password', style: TextStyle(fontSize: 15.0)),
                horizontalTitleGap: 10.0,
              ),
              ListTile(
                leading: const Icon(LazaIcons.bag2),
                onTap: () {},
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                title: const Text('Order', style: TextStyle(fontSize: 15.0)),
                horizontalTitleGap: 10.0,
              ),
              ListTile(
                leading: const Icon(LazaIcons.bag2),
                onTap: () {},
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                title: const Text('My Cards', style: TextStyle(fontSize: 15.0)),
                horizontalTitleGap: 10.0,
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.heart),
                onTap: () {},
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                title: const Text('Whislist', style: TextStyle(fontSize: 15.0)),
                horizontalTitleGap: 10.0,
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                onTap: () {},
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                title: const Text('Settings', style: TextStyle(fontSize: 15.0)),
                horizontalTitleGap: 10.0,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          const SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Welcome to Laza',
                  style: TextStyle(fontSize: 15, color: Color(0xff8F959E)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: 'Search ...',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 0, color: Colors.transparent)),
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 0, color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 0, color: Colors.transparent)),
                        hintStyle: TextStyle(color: Color(0xff8F959E)),
                        fillColor: Color(0xffF5F6FA),
                        prefixIcon: Icon(LazaIcons.search22, color: Color(0xff8F959E))),
                  ),
                ),
                const SizedBox(width: 10.0),
                InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  onTap: () {},
                  child: Ink(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: ColorConstant.primary, borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                    child: const Icon(LazaIcons.voice22, color: Colors.white, size: 22),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Choose Brand',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Color(0xff8F959E), fontSize: 13),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              separatorBuilder: (_, __) => const SizedBox(width: 10.0),
              shrinkWrap: true,
              itemCount: brands.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final brand = brands[index];
                return InkWell(
                  onTap: () {},
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Ink(
                    height: 50,
                    width: 115,
                    decoration: const BoxDecoration(
                      color: Color(0xffF5F6FA),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Color(0xffFEFEFE),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Icon(
                            brand.iconData,
                            size: brand.name == 'Fila' ? 12 : 18,
                          ),
                        ),
                        Expanded(
                            child: Text(
                          brand.name,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'New Arrival',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Color(0xff8F959E), fontSize: 13),
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(builder: (context) {
              return InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Ink(
                  width: 45,
                  height: 45,
                  decoration: const ShapeDecoration(
                    color: Color(0xffF5F6FA),
                    shape: CircleBorder(),
                  ),
                  child: const Icon(
                    LazaIcons.menu2,
                    size: 13,
                  ),
                ),
              );
            }),
            InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              onTap: () {},
              child: Ink(
                width: 45,
                height: 45,
                decoration: const ShapeDecoration(
                  color: Color(0xffF5F6FA),
                  shape: CircleBorder(),
                ),
                child: const Icon(
                  LazaIcons.bag2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class Brand {
  final String name;
  final IconData iconData;
  const Brand(this.name, this.iconData);
}
