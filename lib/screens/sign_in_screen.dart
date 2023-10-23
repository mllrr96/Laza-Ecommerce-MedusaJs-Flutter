import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laza/config/locator.dart';
import 'package:laza/extensions/context_extension.dart';
import 'package:laza/repositories/preference_repository.dart';
import 'package:laza/routes/app_router.dart';
import 'package:sign_in_button/sign_in_button.dart';

import 'components/bottom_nav_button.dart';
import 'components/colors.dart';
import 'components/custom_appbar.dart';

@RoutePage()
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
          onTap: () => context.router.push(const SignUpRoute()),
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
                          child: SignInButton(
                            Buttons.facebook,
                            onPressed: () => context.router.replaceAll([const DashboardRoute()]),
                          )),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: double.infinity, height: 50, child: SignInButton(Buttons.twitter, onPressed: () {})),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: SignInButton(Buttons.googleDark, onPressed: () {})),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: SignInButton(
                            Buttons.email,
                            onPressed: () => context.router.push(const SignInWithEmailRoute()),
                          )),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: SignInButtonBuilder(
                            onPressed: () {
                              locator.get<PreferenceRepository>().setGuest();
                              context.router.replaceAll([const DashboardRoute()]);
                            },
                            backgroundColor: ColorConstant.manatee,
                            text: 'Continue as guest',
                            icon: Icons.person,
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
