import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laza/config/locator.dart';
import 'package:laza/repositories/preference_repository.dart';
import 'package:laza/routes/app_router.dart';

import 'components/colors.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final isGuest = locator.get<PreferenceRepository>().isGuest;
    if (isGuest) {
      Future.delayed(const Duration(seconds: 2)).then((value) => context.router.replaceAll([const DashboardRoute()]));
    } else {
      Future.delayed(const Duration(seconds: 2)).then((value) => context.router.replace(const SignInRoute()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: ColorConstant.primary,
        systemNavigationBarColor: ColorConstant.primary,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: ColorConstant.primary,
        body: Center(
          child: SvgPicture.asset('assets/images/Logo.svg'),
        ),
      ),
    );
  }
}
