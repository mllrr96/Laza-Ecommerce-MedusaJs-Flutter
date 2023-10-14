import 'dart:io';
import 'package:flutter/material.dart';
import 'package:laza/components/custom_appbar.dart';
import 'package:laza/components/custom_text_field.dart';
import 'package:laza/reset_password/forgot_password_screen.dart';

import 'components/bottom_nav_button.dart';
import 'components/colors.dart';
import 'dashboard.dart';

class SignInWithEmail extends StatefulWidget {
  const SignInWithEmail({super.key});

  @override
  State<SignInWithEmail> createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  bool rememberMe = false;
  final formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(),
        bottomNavigationBar: BottomNavButton(
          label: 'Login',
          onTap: () {
            if (!formKey.currentState!.validate()) return;
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Dashboard()),
                    (Route<dynamic> route) => false);
          },
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(color: Color(0xff1D1E20), fontSize: 28, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Please enter your data to continue',
                      style: TextStyle(color: Color(0xff8F959E), fontSize: 15),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                        controller: emailCtrl,
                        labelText: 'Email Address',
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Field is required';
                          }

                          return null;
                        },
                      ),
                      CustomTextField(
                          controller: passwordCtrl,
                          labelText: 'Password',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Field is required';
                            }
                            if (val.length < 8) {
                              return 'Password should be 8 characters long';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done),
                      const SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                                  ),
                              child: const Text(
                                'Forget Password?',
                                style: TextStyle(color: Colors.red),
                              ))),
                      const SizedBox(height: 10),
                      SwitchListTile.adaptive(
                          activeColor: Platform.isIOS ? ColorConstant.primary : null,
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Remember me'),
                          value: rememberMe,
                          onChanged: (val) => setState(() => rememberMe = val))
                    ],
                  ),
                ),
              )),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Ink(
                      child: const Text.rich(
                        TextSpan(
                            text: 'By connecting your account confirm that you agree with our',
                            style: TextStyle(
                              color: Color(0xff8F959E),
                            ),
                            children: [
                              TextSpan(
                                  text: ' Term and Condition',
                                  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black))
                            ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
