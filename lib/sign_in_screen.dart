import 'package:flutter/material.dart';
import 'package:laza/components/bottom_nav_button.dart';
import 'package:laza/components/custom_appbar.dart';
import 'package:laza/sign_in_with_email.dart';
import 'package:laza/sign_up_screen.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  'Let’s Get Started',
                  style: TextStyle(color: Color(0xff1D1E20), fontSize: 28, fontWeight: FontWeight.w600),
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
                        width: double.infinity, height: 50, child: SignInButton(Buttons.facebook, onPressed: () {})),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: double.infinity, height: 50, child: SignInButton(Buttons.twitter, onPressed: () {})),
                    const SizedBox(height: 10),
                    SizedBox(width: double.infinity, height: 50, child: SignInButton(Buttons.google, onPressed: () {})),
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
    );
  }
}
