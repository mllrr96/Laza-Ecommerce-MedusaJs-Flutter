import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laza/blocs/auth/authentication_bloc.dart';
import 'package:laza/common/colors.dart';
import '../routes/app_router.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: ColorConstant.primary,
        systemNavigationBarColor: ColorConstant.primary,
        statusBarIconBrightness: Brightness.light,
      ),
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          state.map(
            guest: (_) => context.router.replaceAll([const DashboardRoute()]),
            loggedIn: (_) => context.router.replace(const DashboardRoute()),
            loggedOut: (_) => context.router.replace(const SignInRoute()),
            // Should push to error signing in page maybe ??
            error: (_) => context.router.replace(const SignInRoute()),
            loading: (_) {},
          );
        },
        child: Scaffold(
          backgroundColor: ColorConstant.primary,
          body: Center(
            child: SvgPicture.asset('assets/images/Logo.svg'),
          ),
        ),
      ),
    );
  }
}
