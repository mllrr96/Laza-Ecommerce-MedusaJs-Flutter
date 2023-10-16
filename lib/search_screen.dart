import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laza/extensions/context_extension.dart';

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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.theme.appBarTheme.systemOverlayStyle!,
      child: Container(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
          child: Row(
            children: [
              Hero(
                tag: 'search_back',
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
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
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Hero(
                  tag: 'search',
                  child: Material(
                    color: Colors.transparent,
                    child: TextField(
                      controller: TextEditingController(),
                      autofocus: true,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: 'Search ...',
                          contentPadding: EdgeInsets.zero,
                          border: inputBorder,
                          enabledBorder: inputBorder,
                          focusedBorder: inputBorder,
                          hintStyle: TextStyle(color: ColorConstant.manatee),
                          fillColor: context.theme.cardColor,
                          prefixIcon: Icon(LazaIcons.search, color: ColorConstant.manatee)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Hero(
                tag: 'voice',
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    onTap: () {},
                    child: Ink(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          color: ColorConstant.primary, borderRadius: const BorderRadius.all(Radius.circular(50.0))),
                      child: const Icon(LazaIcons.voice, color: Colors.white, size: 22),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
