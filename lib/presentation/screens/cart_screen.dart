import 'dart:math';

import 'package:animated_digit/animated_digit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:laza/blocs/line_item/line_item_bloc.dart';
import 'package:laza/common/extensions/context_extension.dart';
import 'package:laza/di/di.dart';
import 'package:laza/domain/repository/preference_repository.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../routes/app_router.dart';

import 'components/bottom_nav_button.dart';
import 'components/colors.dart';
import 'components/custom_appbar.dart';
import 'components/laza_icons.dart';

@RoutePage()
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String getPrice(int? total) {
      final formatCurrency = NumberFormat.simpleCurrency(name: getIt<PreferenceRepository>().currencyCode);

      if (total == null) {
        return '';
      }

      num priceFormatted = total;
      if (formatCurrency.decimalDigits! > 0) {
        priceFormatted /= pow(10, formatCurrency.decimalDigits!);
      }
      return formatCurrency.format(priceFormatted).toString();
    }

    num getPriceInt(int? total) {
      final formatCurrency = NumberFormat.simpleCurrency(name: getIt<PreferenceRepository>().currencyCode);

      if (total == null) {
        return 0;
      }

      num priceFormatted = total;
      if (formatCurrency.decimalDigits! > 0) {
        priceFormatted /= pow(10, formatCurrency.decimalDigits!);
      }
      final result = formatCurrency.parse(formatCurrency.format(priceFormatted));

      return result;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.theme.appBarTheme.systemOverlayStyle!,
      child: BlocBuilder<CartBloc, CartState>(
        buildWhen: (prevState, state) {
          return true;
        },
        builder: (context, state) {
          return state.maybeMap(
              loaded: (cart) => cart.cart.items?.isEmpty ?? false
                  ? Scaffold(
                      appBar: const CustomAppBar(title: 'Cart'),
                      body: SafeArea(
                          child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Your shopping bag is empty.'),
                            const Gap(10),
                            ElevatedButton(onPressed: () {}, child: const Text('Explore products'))
                          ],
                        ),
                      )),
                    )
                  : Scaffold(
                      appBar: const CustomAppBar(title: 'Cart'),
                      bottomNavigationBar: BottomNavButton(
                          label: 'Checkout', onTap: () => context.router.push(const OrderConfirmedRoute())),
                      body: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                        children: [
                          if (cart.cart.items?.isNotEmpty ?? false)
                            // Cart Item
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cart.cart.items!.length,
                              separatorBuilder: (_, __) => const Gap(10),
                              itemBuilder: (context, index) {
                                final item = cart.cart.items?[index];
                                final invQuantity = item?.variant?.inventoryQuantity;

                                final shouldAdd = (invQuantity ?? 1) > (item?.quantity?.toInt() ?? 0) ||
                                    (item?.variant?.allowBackorder ?? false);
                                return Container(
                                  height: 120,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: context.theme.cardColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  child: Row(
                                    children: [
                                      if (item?.thumbnail != null)
                                        Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: context.theme.scaffoldBackgroundColor,
                                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                              image: DecorationImage(
                                                  image: CachedNetworkImageProvider(item!.thumbnail!),
                                                  fit: BoxFit.fitWidth)),
                                        ),
                                      const Gap(10),
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item?.title ?? '',
                                                  style: context.bodySmallW500,
                                                ),
                                                const Gap(5),
                                                Text(
                                                  item?.variant?.title ?? '',
                                                  style: context.bodySmallW500,
                                                ),
                                                const Gap(5),
                                                Text(
                                                  getPrice(item?.total),
                                                  style: context.bodyExtraSmall?.copyWith(color: ColorConstant.manatee),
                                                ),
                                              ],
                                            ),
                                            BlocListener<LineItemBloc, LineItemState>(
                                              listener: (context, state) {
                                                state.whenOrNull(
                                                  success: (_) =>
                                                      context.read<CartBloc>().add(CartEvent.refreshCart(_)),
                                                  failure: (message) => Fluttertoast.showToast(msg: message),
                                                );
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Material(
                                                        color: Colors.transparent,
                                                        child: InkWell(
                                                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                                                          onTap: () {
                                                            context.read<LineItemBloc>().add(LineItemEvent.update(
                                                                cart.cart.id!, item!.id!, item.quantity! - 1));
                                                          },
                                                          child: Ink(
                                                            width: 30,
                                                            height: 30,
                                                            decoration: ShapeDecoration(
                                                              color: context.theme.scaffoldBackgroundColor,
                                                              shape: const CircleBorder(),
                                                            ),
                                                            child: const Icon(Icons.arrow_drop_down),
                                                          ),
                                                        ),
                                                      ),
                                                      const Gap(15),
                                                      Text(item?.quantity?.toString() ?? ''),
                                                      const Gap(15),
                                                      Material(
                                                        color: Colors.transparent,
                                                        child: InkWell(
                                                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                                                          onTap: shouldAdd
                                                              ? () {
                                                                  context.read<LineItemBloc>().add(LineItemEvent.update(
                                                                      cart.cart.id!, item!.id!, item.quantity! + 1));
                                                                }
                                                              : null,
                                                          child: Ink(
                                                            width: 30,
                                                            height: 30,
                                                            decoration: ShapeDecoration(
                                                              color: context.theme.scaffoldBackgroundColor,
                                                              shape: const CircleBorder(),
                                                            ),
                                                            child: shouldAdd
                                                                ? const Icon(Icons.arrow_drop_up)
                                                                : Icon(Icons.arrow_drop_up,
                                                                    color: ColorConstant.manatee),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // const Icon(LazaIcons.delete, size: 18)
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                                                      onTap: () {
                                                        context
                                                            .read<LineItemBloc>()
                                                            .add(LineItemEvent.delete(cart.cart.id!, item!.id!));
                                                      },
                                                      child: Ink(
                                                        width: 30,
                                                        height: 30,
                                                        decoration: ShapeDecoration(
                                                          color: context.theme.scaffoldBackgroundColor,
                                                          shape: const CircleBorder(),
                                                        ),
                                                        child: const Icon(LazaIcons.delete, size: 14.0),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          const Gap(20),
                          // Delivery Address
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Delivery Address', style: context.bodyLargeW500),
                                  const Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    size: 15,
                                  )
                                ],
                              ),
                              const Gap(15),
                              InkWell(
                                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                onTap: () {},
                                child: Ink(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset('assets/images/address.png', height: 50, width: 50),
                                          const Icon(
                                            Icons.location_on_rounded,
                                            color: Colors.red,
                                            size: 30,
                                          )
                                        ],
                                      ),
                                      const Gap(15),
                                      Flexible(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Chhatak, Sunamgonj 12/8AB', style: context.bodyMedium),
                                                  const Gap(10),
                                                  Text('Sylhet',
                                                      style: context.bodySmall?.copyWith(color: ColorConstant.manatee)),
                                                ],
                                              ),
                                            ),
                                            const Icon(LazaIcons.verified_badge, color: Colors.green)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Gap(20),
                          // Payment Method
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Payment Method', style: context.bodyLargeW500),
                                  const Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    size: 15,
                                  )
                                ],
                              ),
                              const Gap(15),
                              Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset('assets/images/address.png', height: 50, width: 50),
                                      const Icon(
                                        Icons.location_on_rounded,
                                        color: Colors.red,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                  const Gap(15),
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Visa Classic', style: context.bodyMedium),
                                              const Gap(10),
                                              Text('**** 7690',
                                                  style: context.bodySmall?.copyWith(color: ColorConstant.manatee)),
                                            ],
                                          ),
                                        ),
                                        const Icon(LazaIcons.verified_badge, color: Colors.green)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Gap(20),
                          // Order Info
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order Info',
                                style: context.bodyLargeW500,
                              ),
                              const Gap(15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Subtotal', style: context.bodyMedium?.copyWith(color: ColorConstant.manatee)),
                                  Text(getPrice(cart.cart.subTotal), style: context.bodyMediumW500),
                                ],
                              ),
                              const Gap(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Shipping cost',
                                      style: context.bodyMedium?.copyWith(color: ColorConstant.manatee)),
                                  Text(getPrice(cart.cart.shippingTotal), style: context.bodyMediumW500),
                                ],
                              ),
                              const Gap(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Taxes', style: context.bodyMedium?.copyWith(color: ColorConstant.manatee)),
                                  Text(getPrice(cart.cart.taxTotal), style: context.bodyMediumW500),
                                ],
                              ),
                              const Gap(15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total', style: context.bodyMedium?.copyWith(color: ColorConstant.manatee)),
                                  AnimatedDigitWidget(
                                    prefix:
                                        NumberFormat.simpleCurrency(name: getIt<PreferenceRepository>().currencyCode)
                                            .currencySymbol,
                                    value: getPriceInt(cart.cart.total),
                                    textStyle: context.bodyMediumW500,
                                    fractionDigits:
                                        NumberFormat.simpleCurrency(name: getIt<PreferenceRepository>().currencyCode)
                                                .decimalDigits ??
                                            0,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              loading: (_) => const Scaffold(
                  appBar: CustomAppBar(title: 'Cart'),
                  body: Center(
                    child: CircularProgressIndicator.adaptive(),
                  )),
              error: (error) => Scaffold(
                    appBar: const CustomAppBar(title: 'Cart'),
                    body: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (error.message == null) const Text('Error loading cart'),
                          if (error.message != null) Text(error.message ?? ''),
                          ElevatedButton(
                              onPressed: () {
                                context.read<CartBloc>().add(const CartEvent.loadCart());
                              },
                              child: const Text('Retry'))
                        ],
                      ),
                    ),
                  ),
              orElse: () => Scaffold(
                    appBar: const CustomAppBar(title: 'Cart'),
                    body: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Something went wrong'),
                          ElevatedButton(
                              onPressed: () {
                                context.read<CartBloc>().add(const CartEvent.loadCart());
                              },
                              child: const Text('Retry'))
                        ],
                      ),
                    ),
                  ));
        },
      ),
    );
  }
}
