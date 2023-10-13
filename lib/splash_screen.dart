import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laza/components/colors.dart';
import 'package:laza/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const IntroductionScreen()),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.primary,
      body: Center(
        child: SvgPicture.asset('assets/images/Logo.svg'),
      ),
    );
  }
}
