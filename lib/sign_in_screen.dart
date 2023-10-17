import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laza/components/bottom_nav_button.dart';
import 'package:laza/components/custom_appbar.dart';
import 'package:laza/dashboard.dart';
import 'package:laza/extensions/context_extension.dart';
import 'package:laza/sign_in_with_email.dart';
import 'package:laza/sign_up_screen.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.theme.appBarTheme.systemOverlayStyle!,
      child: Scaffold(
        appBar: const CustomAppBar(),
        bottomNavigationBar: BottomNavButton(
          label: 'Create An Account',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Let’s Get Started',
                    style: context.headlineMedium,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: SignInButton(Buttons.facebook, onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const Dashboard()),
                                (Route<dynamic> route) => false);
                          })),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: double.infinity, height: 50, child: SignInButton(Buttons.twitter, onPressed: () {})),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: double.infinity, height: 50, child: SignInButton(Buttons.googleDark, onPressed: () {})),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: SignInButton(
                            Buttons.email,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignInWithEmail()),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
