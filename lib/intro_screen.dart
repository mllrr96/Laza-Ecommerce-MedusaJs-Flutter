import 'package:flutter/material.dart';
import 'package:laza/components/colors.dart';
import 'package:laza/extensions/context_extension.dart';
import 'package:laza/sign_in_screen.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  bool? isMale;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(10));
    return Scaffold(
      backgroundColor: ColorConstant.primary,
      body: SafeArea(
          child: Stack(
        children: [
          Align(alignment: Alignment.center, child: Image.asset('assets/images/intro.png')),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: context.theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 25, 10),
                    child: Column(
                      children: [
                        Text(
                          'Look Good, Feel Good',
                          style: context.headlineMedium
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Create your individual & unique style and look amazing everyday.',
                          style: context.bodyMedium?.copyWith(color: ColorConstant.manatee),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isMale = true;
                              });
                            },
                            borderRadius: borderRadius,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 150,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  borderRadius: borderRadius,
                                  color: isMale != null && isMale == true ? ColorConstant.primary : context.theme.cardColor),
                              child: Text(
                                'Men',
                                style: context.bodyLarge?.copyWith(
                                  color: isMale != null && isMale == true ? Colors.white : const Color(0xff8F959E),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isMale = false;
                              });
                            },
                            borderRadius: borderRadius,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 150,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  borderRadius: borderRadius,
                                  color: isMale != null && isMale == false ? ColorConstant.primary : context.theme.cardColor),
                              child: Text(
                                'Women',
                                style: context.bodyLarge?.copyWith(
                                  color: isMale != null && isMale == false ? Colors.white : const Color(0xff8F959E),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextButton(
                          onPressed: () =>   Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignInScreen()),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(isMale != null ? 'Next' :'Skip'),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
