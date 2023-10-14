import 'package:flutter/material.dart';

import 'components/colors.dart';
import 'components/laza_icons.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(),
      body: SafeArea(
          child: Center(
        child: Text(
          'Search through the store',
          style: TextStyle(color: Color(0xff8F959E), fontSize: 20),
        ),
      )),
    );
  }
}

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    const inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(width: 0, color: Colors.transparent));
    return Container(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
        child: Row(
          children: [
            InkWell(
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
            const SizedBox(width: 12.0),
            Expanded(
              child: TextField(
                controller: TextEditingController(),
                autofocus: true,
                decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Search ...',
                    contentPadding: EdgeInsets.zero,
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    focusedBorder: inputBorder,
                    hintStyle: TextStyle(color: Color(0xff8F959E)),
                    fillColor: Color(0xffF5F6FA),
                    prefixIcon: Hero(tag: 'search', child: Icon(LazaIcons.search, color: Color(0xff8F959E)))),
              ),
            ),
            const SizedBox(width: 12.0),
            InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              onTap: () {},
              child: Ink(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    color: ColorConstant.primary, borderRadius: const BorderRadius.all(Radius.circular(50.0))),
                child: const Icon(LazaIcons.voice, color: Colors.white, size: 22),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
