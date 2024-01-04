import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:laza/blocs/auth/authentication_bloc.dart';
import 'package:laza/common/colors.dart';
import 'package:laza/common/extensions/extensions.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../../di/di.dart';
import '../../domain/repository/preference_repository.dart';
import '../components/index.dart';
import '../routes/app_router.dart';

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
                      const Gap(10),
                      SizedBox(
                          width: double.infinity, height: 50, child: SignInButton(Buttons.twitter, onPressed: () {})),
                      const Gap(10),
                      SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: SignInButton(Buttons.googleDark, onPressed: () {})),
                      const Gap(10),
                      SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: SignInButton(
                            Buttons.email,
                            onPressed: () => context.router.push(const SignInWithEmailRoute()),
                          )),
                      const Gap(10),
                      if (!getIt<PreferenceRepository>().isGuest)
                        SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: SignInButtonBuilder(
                              onPressed: () {
                                context.read<AuthenticationBloc>().add(const AuthenticationEvent.loginAsGuest());
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
