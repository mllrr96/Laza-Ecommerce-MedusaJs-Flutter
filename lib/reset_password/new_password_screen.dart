import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laza/extensions/context_extension.dart';
import '../components/bottom_nav_button.dart';
import '../components/colors.dart';
import '../components/custom_appbar.dart';
import '../components/custom_text_field.dart';
import '../dashboard.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.theme.appBarTheme.systemOverlayStyle!,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const CustomAppBar(),
          bottomNavigationBar: BottomNavButton(
            label: 'Reset Password',
            onTap: () =>    Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Dashboard()),
                    (Route<dynamic> route) => false)
          ),
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
                          'New Password',
                          style: context.headlineMedium,
                        ),
                      ),
                    ),
                    SvgPicture.asset('assets/images/forgot_password.svg'),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          CustomTextField(labelText: 'Password'),
                          CustomTextField(labelText: 'Confirm Password', textInputAction: TextInputAction.done),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Please write your new password.',
                      style: context.bodySmall?.copyWith(color: ColorConstant.manatee),
                      textAlign: TextAlign.center,
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
