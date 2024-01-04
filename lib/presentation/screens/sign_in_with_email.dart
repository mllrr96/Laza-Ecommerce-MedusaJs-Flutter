import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:laza/blocs/auth/authentication_bloc.dart';
import 'package:laza/common/extensions/extensions.dart';
import 'package:laza/di/di.dart';
import 'package:laza/domain/repository/preference_repository.dart';
import '../../common/colors.dart';
import '../components/index.dart';
import '../routes/app_router.dart';

@RoutePage()
class SignInWithEmailScreen extends StatefulWidget {
  const SignInWithEmailScreen({super.key});

  @override
  State<SignInWithEmailScreen> createState() => _SignInWithEmailScreenState();
}

class _SignInWithEmailScreenState extends State<SignInWithEmailScreen> {
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
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        state.maybeMap(
          loading: (_) => EasyLoading.show(maskType: EasyLoadingMaskType.black),
          loggedIn: (customer) {
            getIt<PreferenceRepository>().setGuest(value: false);
            EasyLoading.dismiss();
            context.router.replaceAll([const DashboardRoute()]);
          },
          orElse: () => EasyLoading.dismiss(),
        );
      },
      builder: (context, state) {
        final error = state.mapOrNull(
            error: (_) => _.failure.message, loggedInAsGuest: (_) => _.failure?.message, loggedOut: (_) => _.failure?.message);
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: context.theme.appBarTheme.systemOverlayStyle!,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: const CustomAppBar(),
              bottomNavigationBar: BottomNavButton(
                label: 'Login',
                onTap: () {
                  if (!formKey.currentState!.validate()) return;
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationEvent.loginCustomer(email: emailCtrl.text, password: passwordCtrl.text));
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
                      child: Column(
                        children: [
                          Text(
                            'Welcome',
                            style: context.headlineMedium,
                          ),
                          Text(
                            'Please enter your data to continue',
                            style: context.bodyMedium?.copyWith(color: ColorConstant.manatee),
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
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: error != null ? 50.0 : 0.0,
                              margin: EdgeInsets.only(bottom: error != null ? 0 : 50),
                              decoration: const BoxDecoration(
                                color: Color(0xffFFE9E9),
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.error,
                                      color: Colors.redAccent,
                                      size: error != null ? 25 : 0,
                                    ),
                                    const Gap(5),
                                    Expanded(
                                      child: Text(
                                        error ?? '',
                                        style: context.bodyMedium?.copyWith(color: Colors.redAccent),
                                        overflow: TextOverflow.fade,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Gap(10),
                            CustomTextField(
                              controller: emailCtrl,
                              labelText: 'Email Address',
                              keyboardType: TextInputType.emailAddress,
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
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Field is required';
                                }
                                if (val.length < 8) {
                                  return 'Password should be 8 characters long';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) {
                                if (!formKey.currentState!.validate()) return;
                                context.read<AuthenticationBloc>().add(AuthenticationEvent.loginCustomer(
                                    email: emailCtrl.text, password: passwordCtrl.text));
                              },
                            ),
                            const Gap(10),
                            Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: () => context.router.push(const ForgotPasswordRoute()),
                                    child: const Text(
                                      'Forget Password?',
                                      style: TextStyle(color: Colors.red),
                                    ))),
                            const Gap(10),
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
                            child: Text.rich(
                              TextSpan(
                                  text: 'By connecting your account confirm that you agree with our',
                                  style: context.bodySmall?.copyWith(color: ColorConstant.manatee),
                                  children: [
                                    TextSpan(
                                      text: ' Term and Condition',
                                      style: context.bodySmallW500,
                                    )
                                  ]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
