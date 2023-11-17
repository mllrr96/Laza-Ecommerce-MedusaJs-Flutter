import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laza/common/extensions/context_extension.dart';
import 'package:laza/presentation/components/index.dart';

import '../../../common/colors.dart';
import '../../routes/app_router.dart';

@RoutePage()
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
              label: 'Confirm Email',
              onTap: () => context.router.push(const VerificationCodeRoute())),
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
                          'Forgot Password',
                          style: context.headlineMedium,
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
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 56.0),
                      child: Text(
                        'Please write your email to receive a confirmation code to set a new password.',
                        style: context.bodySmall?.copyWith(color: ColorConstant.manatee),
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
