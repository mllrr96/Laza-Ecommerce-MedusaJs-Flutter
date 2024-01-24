import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:laza/blocs/auth/authentication_bloc.dart';
import 'package:laza/common/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
            loggedInAsGuest: (_) =>
                context.router.replaceAll([const DashboardRoute()]),
            loggedIn: (_) => context.router.replace(const DashboardRoute()),
            loggedOut: (_) => context.router.replace(const SignInRoute()),
            // Should push to error signing in page maybe ??
            error: (_) => context.router.replace(const SignInRoute()),
            loading: (_) {},
          );
        },
        child: Scaffold(
          backgroundColor: ColorConstant.primary,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset('assets/images/Logo.svg'),
              ),
              const Gap(10.0),
              LoadingAnimationWidget.staggeredDotsWave(color: Colors.white, size: 40),
            ],
          ),
        ),
      ),
    );
  }
}
