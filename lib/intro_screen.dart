import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/components/colors.dart';
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
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Text(
                          'Look Good, Feel Good',
                          style: GoogleFonts.inter(
                              fontSize: 25, color: const Color(0xff1D1E20), fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Create your individual & unique style and look amazing everyday.',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            color: const Color(0xff8F959E),
                          ),
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
                                  color: isMale != null && isMale == true ? ColorConstant.primary : const Color(0xffF5F6FA)),
                              child: Text(
                                'Men',
                                style: GoogleFonts.inter(
                                  fontSize: 17,
                                  color: isMale != null && isMale == true ? Colors.white : const Color(0xff8F959E),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          InkWell(
                            borderRadius: borderRadius,
                            onTap: () {
                              setState(() {
                                isMale = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 150,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  borderRadius: borderRadius,
                                  color: isMale != null && isMale == false ?   ColorConstant.primary : const Color(0xffF5F6FA)),
                              child: Text(
                                'Women',
                                style: GoogleFonts.inter(
                                  fontSize: 17,
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
