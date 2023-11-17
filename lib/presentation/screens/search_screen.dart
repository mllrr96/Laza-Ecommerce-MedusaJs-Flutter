import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:laza/common/extensions/context_extension.dart';
import 'package:laza/di/di.dart';
import 'package:laza/presentation/routes/app_router.dart';

import '../../common/colors.dart';
import '../components/index.dart';

@RoutePage()
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
  bool get canPop => getIt<AppRouter>().canPop();
  @override
  Widget build(BuildContext context) {
    const inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(width: 0, color: Colors.transparent));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.theme.appBarTheme.systemOverlayStyle!,
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.fromLTRB(20, context.viewPadding.top, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (canPop)
              Hero(
                tag: 'search_back',
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    onTap: () => context.router.pop(),
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
            if (canPop) const Gap(15),
            Expanded(
              child: Hero(
                tag: canPop ? 'search' : '',
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
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
