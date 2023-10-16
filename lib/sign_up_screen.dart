import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laza/components/colors.dart';
import 'package:laza/components/custom_text_field.dart';
import 'package:laza/extensions/context_extension.dart';
import 'components/bottom_nav_button.dart';
import 'components/custom_appbar.dart';
import 'dashboard.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final usernameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool rememberMe = false;
  @override
  void dispose() {
    super.dispose();
    usernameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.theme.appBarTheme.systemOverlayStyle!,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: const CustomAppBar(),
          bottomNavigationBar: BottomNavButton(
            label: 'Sign Up',
            onTap: () {
              if (!formKey.currentState!.validate()) return;
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) => const Dashboard()), (Route<dynamic> route) => false);
            },
          ),
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: context.headlineMedium,
                    ),
                  ),
                ),
                Expanded(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: usernameCtrl,
                                labelText: 'Username',
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Field is required';
                                  }

                                  return null;
                                },
                              ),
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
                                textInputAction: TextInputAction.done,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Field is required';
                                  }
                                  if (val.length < 8) {
                                    return 'Password should be 8 characters long';
                                  }

                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              SwitchListTile.adaptive(
                                  activeColor: Platform.isIOS ? ColorConstant.primary : null,
                                  contentPadding: EdgeInsets.zero,
                                  title: const Text('Remember me'),
                                  value: rememberMe,
                                  onChanged: (val) => setState(() => rememberMe = val))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Ink(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      child: Text.rich(
                        TextSpan(
                            text: 'Already have an account?',
                            style: context.bodyMedium?.copyWith(color: ColorConstant.manatee),
                            children: [
                              TextSpan(
                                text: ' Signin',
                                style: context.bodyMediumW500,
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
