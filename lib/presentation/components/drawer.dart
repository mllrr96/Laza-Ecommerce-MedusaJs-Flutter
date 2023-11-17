import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:laza/blocs/auth/authentication_bloc.dart';
import 'package:laza/presentation/screens/cart/bloc/cart/cart_bloc.dart';
import 'package:laza/blocs/region/region_bloc.dart';
import 'package:laza/cubits/theme/theme_cubit.dart';
import 'package:laza/di/di.dart';
import 'package:laza/common/extensions/context_extension.dart';
import 'package:medusa_store_flutter/request_models/index.dart';
import 'package:medusa_store_flutter/store_models/store/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/repository/preference_repository.dart';
import '../../common/colors.dart';
import '../routes/app_router.dart';
import '../screens/home/bloc/products/products_bloc.dart';
import 'laza_icons.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {
        state.whenOrNull(loggedOut: () {
          // When signing out clear shared prefs
          getIt<SharedPreferences>().clear();
          context.router.replaceAll([const SignInRoute()]);
        });
      },
      builder: (context, state) {
        return Drawer(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
            bottom: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 5),
                      child: InkWell(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        onTap: () => Scaffold.of(context).closeDrawer(),
                        child: Ink(
                          width: 45,
                          height: 45,
                          decoration: ShapeDecoration(
                            color: context.theme.cardColor,
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(LazaIcons.menu_vertical),
                        ),
                      ),
                    ),
                    const Gap(30),
                    state.maybeMap(
                        loggedIn: (data) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          maxRadius: 24,
                                          child: Text(data.customer.firstName?[0] ?? ''),
                                        ),
                                        const Gap(10),
                                        Flexible(
                                          child: Text(
                                            (data.customer.firstName ?? '') + (data.customer.lastName ?? ''),
                                            style: context.bodyLargeW500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (data.customer.orders?.isNotEmpty ?? false)
                                    Container(
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          color: context.theme.cardColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(5.0))),
                                      child: Text(
                                        data.customer.orders?.length.toString() ?? '',
                                        style: TextStyle(color: ColorConstant.manatee),
                                      ),
                                    )
                                ],
                              ),
                            ),
                        orElse: () => const SizedBox.shrink()),
                    const Gap(30),
                    BlocBuilder<ThemeCubit, ThemeState>(
                      builder: (context, state) {
                        IconData iconData = Icons.brightness_auto;
                        switch (state.themeMode) {
                          case ThemeMode.system:
                            iconData = Icons.brightness_auto_outlined;
                          case ThemeMode.light:
                            iconData = LazaIcons.sun;
                          case ThemeMode.dark:
                            iconData = Icons.dark_mode_outlined;
                        }
                        return ListTile(
                          leading: Icon(iconData),
                          onTap: () async {
                            await showModalActionSheet(
                                context: context,
                                title: 'Choose app appearance',
                                actions: <SheetAction<ThemeMode>>[
                                  const SheetAction(label: 'Automatic (follow system)', key: ThemeMode.system),
                                  const SheetAction(label: 'Light', key: ThemeMode.light),
                                  const SheetAction(label: 'Dark', key: ThemeMode.dark),
                                ]).then((result) {
                              if (result == null) return;
                              context.read<ThemeCubit>().updateTheme(result);
                              // themeNotifier.toggleTheme(result);
                            });
                          },
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                          title: const Text('Appearance'),
                          horizontalTitleGap: 10.0,
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(LazaIcons.info_circle),
                      onTap: () {},
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                      title: const Text('Account Information'),
                      horizontalTitleGap: 10.0,
                    ),
                    ListTile(
                      leading: const Icon(LazaIcons.lock),
                      onTap: () {},
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                      title: const Text('Password'),
                      horizontalTitleGap: 10.0,
                    ),
                    ListTile(
                      leading: const Icon(LazaIcons.bag),
                      onTap: () => context.pushRoute(const OrdersRoute()),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                      title: const Text('Orders'),
                      horizontalTitleGap: 10.0,
                    ),
                    ListTile(
                      leading: const Icon(LazaIcons.wallet),
                      onTap: () {},
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                      title: const Text('My Cards'),
                      horizontalTitleGap: 10.0,
                    ),
                    ListTile(
                      leading: const Icon(LazaIcons.heart),
                      onTap: () {},
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                      title: const Text('Whislist'),
                      horizontalTitleGap: 10.0,
                    ),
                    ListTile(
                      leading: const Icon(LazaIcons.settings),
                      onTap: () {},
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                      title: const Text('Settings'),
                      horizontalTitleGap: 10.0,
                    ),
                  ],
                ),
                Column(
                  children: [
                    BlocBuilder<RegionBloc, RegionState>(
                      builder: (context, state) {
                        return state.maybeMap(
                          loaded: (loaded) {
                            List<Country> countries = [];
                            for (var region in loaded.regions) {
                              if (region.countries?.isNotEmpty ?? false) {
                                countries.addAll(region.countries!);
                              }
                            }
                            return ListTile(
                              leading: const Icon(Icons.local_shipping_outlined),
                              onTap: () async {
                                final prefRepo = getIt<PreferenceRepository>();
                                final savedCountry = getIt<PreferenceRepository>().country;
                                final countryId = await showConfirmationDialog<int?>(
                                    context: context,
                                    title: 'Shipping to',
                                    initialSelectedActionKey: savedCountry?.id,
                                    actions: countries
                                        .map((e) => AlertDialogAction<int?>(key: e.id, label: e.name ?? ''))
                                        .toList());
                                if (countryId != null) {
                                  final country = countries.where((element) => element.id == countryId).first;
                                  final region = loaded.regions.firstWhere((element) => element.id == country.regionId);
                                  if (country.id != savedCountry?.id) {
                                    await prefRepo.setCountry(country);
                                    await prefRepo.setRegion(region).then((_) {
                                      context.read<ProductsBloc>().add(const ProductsEvent.loadProducts());
                                      if (prefRepo.cartId != null) {
                                        context.read<CartBloc>().add(CartEvent.updateCart(
                                            cartId: prefRepo.cartId!, req: StorePostCartsCartReq(regionId: region.id)));
                                      }
                                    });
                                  }
                                  setState(() {});
                                }
                              },
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                              title: const Text('Shipping to:'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (getIt<PreferenceRepository>().country != null)
                                    Row(
                                      children: [
                                        Flag.fromString(getIt<PreferenceRepository>().country!.iso2!,
                                            height: 15, width: 20),
                                        const Gap(10),
                                        Text(
                                          getIt<PreferenceRepository>().country?.iso2?.toUpperCase() ?? '',
                                          style: context.bodyMedium,
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              horizontalTitleGap: 10.0,
                            );
                          },
                          loading: (_) => const SizedBox.shrink(),
                          orElse: () => const SizedBox.shrink(),
                        );
                      },
                    ),
                    state.maybeMap(
                        loggedIn: (_) => ListTile(
                              leading: const Icon(LazaIcons.logout, color: Colors.red),
                              onTap: () async {
                                await showOkCancelAlertDialog(
                                  context: context,
                                  title: 'Confirm Logout',
                                  message: 'Are you sure you want to logout?',
                                  isDestructiveAction: true,
                                  okLabel: 'Logout',
                                ).then((result) {
                                  if (result == OkCancelResult.ok) {
                                    context.read<AuthenticationBloc>().add(const AuthenticationEvent.logoutCustomer());
                                  }
                                });
                              },
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                              title: const Text('Logout'),
                              horizontalTitleGap: 10.0,
                            ),
                        loggedOut: (_) => ListTile(
                              leading: const Icon(Icons.login),
                              onTap: () async {
                                context.pushRoute(const SignInRoute());
                              },
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                              title: const Text('Sign in'),
                              horizontalTitleGap: 10.0,
                            ),
                        guest: (_) => ListTile(
                              leading: const Icon(Icons.login),
                              onTap: () async {
                                context.pushRoute(const SignInRoute());
                              },
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                              title: const Text('Sign in'),
                              horizontalTitleGap: 10.0,
                            ),
                        orElse: () => const SizedBox.shrink()),
                    const Gap(30),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
