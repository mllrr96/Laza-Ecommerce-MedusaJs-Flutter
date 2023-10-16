import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laza/extensions/context_extension.dart';
import 'package:laza/reset_password/new_password_screen.dart';

import '../components/bottom_nav_button.dart';
import '../components/colors.dart';
import '../components/custom_appbar.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.theme.appBarTheme.systemOverlayStyle!,
      child: GestureDetector(
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
                    SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Verification Code',
                          style: context.headlineMedium,
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
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                      child: Text.rich(
                        TextSpan(text: '00:20', style: context.bodySmallW500, children: [
                          TextSpan(
                            text: ' resend confirmation code.',
                            style: context.bodySmall?.copyWith(color: ColorConstant.manatee),
                          )
                        ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
