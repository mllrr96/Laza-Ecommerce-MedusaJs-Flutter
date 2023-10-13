import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laza/reset_password/new_password_screen.dart';

import '../components/bottom_nav_button.dart';
import '../components/custom_appbar.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(),
        bottomNavigationBar: BottomNavButton(
            label: 'Confirm Code',
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewPasswordScreen()),
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
                  const SizedBox(height: 20),
                  OtpTextField(
                    numberOfFields: 4,
                    fieldWidth: 77, borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {},
                    onSubmit: (String verificationCode) {}, // end onSubmit
                  ),
                ],
              ),
              const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: Text.rich(
                      TextSpan(
                          text: '00:20',
                          style: TextStyle(
                            color: Color(0xff8F959E),
                          ),
                          children: [
                            TextSpan(
                                text: ' resend confirmation code.',
                                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black))
                          ]),
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
