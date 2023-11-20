import 'dart:math';
import 'package:animated_digit/animated_digit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:laza/common/extensions/context_extension.dart';
import 'package:laza/di/di.dart';
import 'package:laza/domain/repository/preference_repository.dart';
import 'package:laza/presentation/components/index.dart';
import 'package:laza/presentation/screens/cart/widgets/line_item_card.dart';
import 'bloc/cart/cart_bloc.dart';
import '../../../common/colors.dart';
import '../../routes/app_router.dart';

@RoutePage()
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyCode = getIt<PreferenceRepository>().currencyCode;

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
        builder: (context, state) {
          return Scaffold(
            appBar: const CustomAppBar(title: 'Cart'),
            bottomNavigationBar: state.whenOrNull(
                loaded: (cart) => cart.items?.isNotEmpty ?? false
                    ? BottomNavButton(label: 'Checkout', onTap: () => context.router.push(const OrderConfirmedRoute()))
                    : null),
            body: state.maybeMap(
              loaded: (cart) => cart.cart.items?.isEmpty ?? false
                  ? SafeArea(
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
                    ))
                  : ListView(
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
                              return LineItemCard(lineItem: item!, cartId: cart.cart.id!);
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
                                Text(cart.cart.subTotal.formatAsPrice(currencyCode), style: context.bodyMediumW500),
                              ],
                            ),
                            const Gap(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Shipping cost',
                                    style: context.bodyMedium?.copyWith(color: ColorConstant.manatee)),
                                Text(cart.cart.shippingTotal.formatAsPrice(currencyCode), style: context.bodyMediumW500),
                              ],
                            ),
                            const Gap(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Taxes', style: context.bodyMedium?.copyWith(color: ColorConstant.manatee)),
                                Text(cart.cart.taxTotal.formatAsPrice(currencyCode), style: context.bodyMediumW500),
                              ],
                            ),
                            const Gap(15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total', style: context.bodyMedium?.copyWith(color: ColorConstant.manatee)),
                                AnimatedDigitWidget(
                                  prefix: NumberFormat.simpleCurrency(name: getIt<PreferenceRepository>().currencyCode)
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
              loading: (_) => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              error: (error) => Center(
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
              orElse: () => Center(
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
            ),
          );
        },
      ),
    );
  }
}
