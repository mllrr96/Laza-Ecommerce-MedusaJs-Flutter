import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laza/components/bottom_nav_button.dart';
import 'package:laza/components/colors.dart';
import 'package:laza/components/custom_appbar.dart';
import 'package:laza/components/laza_icons.dart';
import 'package:laza/extensions/context_extension.dart';
import 'package:laza/order_confirmed_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.theme.appBarTheme.systemOverlayStyle!,
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Cart'),
        bottomNavigationBar: BottomNavButton(
            label: 'Checkout',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderConfirmedScreen()))),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          children: [
            // Cart Item
            Container(
              height: 120,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: context.theme.scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        image:
                            const DecorationImage(image: AssetImage('assets/images/img3.png'), fit: BoxFit.fitWidth)),
                  ),
                  const SizedBox(width: 10.0),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Men's Tie-Dye T-Shirt Nike Sportswear",
                              style: context.bodySmallW500,
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              "\$45 (-\$4.00 Tax)",
                              style: context.bodyExtraSmall?.copyWith(color: ColorConstant.manatee),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                                    onTap: () {},
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
                                const SizedBox(width: 15.0),
                                const Text('1'),
                                const SizedBox(width: 15.0),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                                    onTap: () {},
                                    child: Ink(
                                      width: 30,
                                      height: 30,
                                      decoration: ShapeDecoration(
                                        color: context.theme.scaffoldBackgroundColor,
                                        shape: const CircleBorder(),
                                      ),
                                      child: const Icon(Icons.arrow_drop_up),
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
                                onTap: () {},
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
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            // Cart Item
            Container(
              height: 120,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: context.theme.scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        image:
                            const DecorationImage(image: AssetImage('assets/images/img3.png'), fit: BoxFit.fitWidth)),
                  ),
                  const SizedBox(width: 10.0),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Men's Tie-Dye T-Shirt Nike Sportswear",
                              style: context.bodySmallW500,
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              "\$45 (-\$4.00 Tax)",
                              style: context.bodyExtraSmall?.copyWith(color: ColorConstant.manatee),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                                    onTap: () {},
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
                                const SizedBox(width: 15.0),
                                const Text('1'),
                                const SizedBox(width: 15.0),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                                    onTap: () {},
                                    child: Ink(
                                      width: 30,
                                      height: 30,
                                      decoration: ShapeDecoration(
                                        color: context.theme.scaffoldBackgroundColor,
                                        shape: const CircleBorder(),
                                      ),
                                      child: const Icon(Icons.arrow_drop_up),
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
                                onTap: () {},
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
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20.0),
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
                const SizedBox(height: 15.0),
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
                        const SizedBox(width: 15.0),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Chhatak, Sunamgonj 12/8AB', style: context.bodyMedium),
                                    const SizedBox(height: 10.0),
                                    Text('Sylhet', style: context.bodySmall?.copyWith(color: ColorConstant.manatee)),
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
            const SizedBox(height: 20.0),
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
                const SizedBox(height: 15.0),
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
                    const SizedBox(width: 15.0),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Visa Classic', style: context.bodyMedium),
                                const SizedBox(height: 10.0),
                                Text('**** 7690', style: context.bodySmall?.copyWith(color: ColorConstant.manatee)),
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
            const SizedBox(height: 20.0),
            // Order Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Info',
                  style: context.bodyLargeW500,
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal', style: context.bodyMedium?.copyWith(color: ColorConstant.manatee)),
                    Text('\$110', style: context.bodyMediumW500),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shipping cost', style: context.bodyMedium?.copyWith(color: ColorConstant.manatee)),
                    Text('\$10', style: context.bodyMediumW500),
                  ],
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: context.bodyMedium?.copyWith(color: ColorConstant.manatee)),
                    Text('\$120', style: context.bodyMediumW500),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
