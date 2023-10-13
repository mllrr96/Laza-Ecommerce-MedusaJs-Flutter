import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laza/home_screen.dart';
import '../components/bottom_nav_button.dart';
import '../components/custom_appbar.dart';
import '../components/custom_text_field.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(),
        bottomNavigationBar: BottomNavButton(
          label: 'Reset Password',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          ),
        ),
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
                        'New Password',
                        style: TextStyle(color: Color(0xff1D1E20), fontSize: 28, fontWeight: FontWeight.w600),
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
              const Column(
                children: [
                  Text(
                    'Please write your new password.',
                    style: TextStyle(
                      color: Color(0xff8F959E),
                    ),
                    textAlign: TextAlign.center,
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
