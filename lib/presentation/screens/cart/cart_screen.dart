import 'package:animated_digit/animated_digit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:laza/common/extensions/extensions.dart';
import 'package:laza/domain/repository/preference_repository.dart';
import 'package:laza/presentation/components/index.dart';
import 'package:laza/presentation/screens/cart/widgets/line_item_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medusa_store_flutter/medusa_store.dart';
import 'bloc/cart/cart_bloc.dart';
import 'dart:math' as math;
import '../../../common/colors.dart';
import '../../routes/app_router.dart';

@RoutePage()
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.theme.appBarTheme.systemOverlayStyle!,
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const CustomAppBar(title: 'Cart'),
            bottomNavigationBar: state.whenOrNull(
                loaded: (cart) => cart.items?.isNotEmpty ?? false
                    ? BottomNavButton(
                        label: 'Checkout',
                        onTap: () =>
                            context.router.push(const OrderConfirmedRoute()))
                    : null),
            body: state.map(
              loaded: (cart) => cart.cart.items?.isEmpty ?? true
                  ? SafeArea(
                      child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Your shopping bag is empty.'),
                          const Gap(10),
                          ElevatedButton(
                              onPressed: () {},
                              child: const Text('Explore products'))
                        ],
                      ),
                    ))
                  : ItemsView(cart.cart),
              loading: (_) => Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                      color: ColorConstant.primary, size: 40)),
              initial: (_) => Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                      color: ColorConstant.primary, size: 40)),
              error: (error) => Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (error.message == null) const Text('Error loading cart'),
                    if (error.message != null) Text(error.message ?? ''),
                    ElevatedButton(
                        onPressed: () {
                          context
                              .read<CartBloc>()
                              .add(const CartEvent.loadCart());
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

class ItemsView extends StatelessWidget {
  const ItemsView(this.cart, {super.key});
  final Cart cart;
  @override
  Widget build(BuildContext context) {
    final currencyCode = PreferenceRepository.currencyCode;
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final item = cart.items?[index ~/ 2];
                if (index.isEven) {
                  return LineItemCard(lineItem: item!, cartId: cart.id!);
                }
                return const Gap(8.0);
              },
              childCount:
                  math.max(0, cart.items!.length * 2 - 1), // 1000 list items
            ),
          ),
        ),
        const SliverGap(20),
        // Delivery Address
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
            child: Column(
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
                            Image.asset('assets/images/address.png',
                                height: 50, width: 50),
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
                                    Text('Chhatak, Sunamgonj 12/8AB',
                                        style: context.bodyMedium),
                                    const Gap(10),
                                    Text('Sylhet',
                                        style: context.bodySmall?.copyWith(
                                            color: ColorConstant.manatee)),
                                  ],
                                ),
                              ),
                              const Icon(LazaIcons.verified_badge,
                                  color: Colors.green)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SliverGap(20),
        // Payment Method
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
            child: Column(
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
                        Image.asset('assets/images/address.png',
                            height: 50, width: 50),
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
                                    style: context.bodySmall?.copyWith(
                                        color: ColorConstant.manatee)),
                              ],
                            ),
                          ),
                          const Icon(LazaIcons.verified_badge,
                              color: Colors.green)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SliverGap(20),
        // Order Info
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
            child: Column(
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
                    Text('Subtotal',
                        style: context.bodyMedium
                            ?.copyWith(color: ColorConstant.manatee)),
                    Text(cart.subTotal.formatAsPrice(currencyCode),
                        style: context.bodyMediumW500),
                  ],
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shipping cost',
                        style: context.bodyMedium
                            ?.copyWith(color: ColorConstant.manatee)),
                    Text(cart.shippingTotal.formatAsPrice(currencyCode),
                        style: context.bodyMediumW500),
                  ],
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Taxes',
                        style: context.bodyMedium
                            ?.copyWith(color: ColorConstant.manatee)),
                    Text(cart.taxTotal.formatAsPrice(currencyCode),
                        style: context.bodyMediumW500),
                  ],
                ),
                const Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',
                        style: context.bodyMedium
                            ?.copyWith(color: ColorConstant.manatee)),
                    AnimatedDigitWidget(
                      prefix: NumberFormat.simpleCurrency(name: currencyCode)
                          .currencySymbol,
                      value: cart.total?.formatAsPriceNum(currencyCode),
                      textStyle: context.bodyMediumW500,
                      fractionDigits:
                          NumberFormat.simpleCurrency(name: currencyCode)
                                  .decimalDigits ??
                              0,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
