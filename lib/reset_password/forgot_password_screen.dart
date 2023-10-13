import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laza/components/custom_text_field.dart';
import 'package:laza/reset_password/verification_code_screen.dart';

import '../components/bottom_nav_button.dart';
import '../components/custom_appbar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(),
        bottomNavigationBar: BottomNavButton(
            label: 'Confirm Email',
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VerificationCodeScreen()),
                )),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(color: Color(0xff1D1E20), fontSize: 28, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SvgPicture.asset('assets/images/forgot_password.svg'),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomTextField(labelText: 'Email Address', textInputAction: TextInputAction.done),
                  ),
                ],
              ),
              const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 56.0),
                    child: Text(
                      'Please write your email to receive a confirmation code to set a new password.',
                      style: TextStyle(
                        color: Color(0xff8F959E),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
