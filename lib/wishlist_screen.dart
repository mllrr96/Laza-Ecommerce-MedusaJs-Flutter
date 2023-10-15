import 'package:flutter/material.dart';
import 'package:laza/components/colors.dart';
import 'package:laza/components/custom_appbar.dart';
import 'package:laza/extensions/context_extension.dart';

import 'cart_screen.dart';
import 'components/laza_icons.dart';
import 'components/product_card.dart';
import 'models/product.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const products = [
      Product(
          title: 'Nike Sportswear Club Fleece',
          thumbnailPath: 'assets/images/img2.png',
          price: '\$99',
          description:
              'The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends a performance feel with',
          images: [
            'assets/images/product-img1.png',
            'assets/images/product-img2.png',
            'assets/images/product-img3.png',
            'assets/images/product-img4.png',
          ]),
      Product(title: 'Trail Running Jacket Nike Windrunner', thumbnailPath: 'assets/images/img3.png', price: '\$99'),
      Product(title: 'Training Top Nike Sport Clash', thumbnailPath: 'assets/images/img2.png', price: '\$99'),
      Product(title: 'Trail Running Jacket Nike Windrunner', thumbnailPath: 'assets/images/img3.png', price: '\$99'),
      Product(title: 'Training Top Nike Sport Clash', thumbnailPath: 'assets/images/img2.png', price: '\$99'),
      Product(title: 'Trail Running Jacket Nike Windrunner', thumbnailPath: 'assets/images/img3.png', price: '\$99'),
      Product(title: 'Training Top Nike Sport Clash', thumbnailPath: 'assets/images/img2.png', price: '\$99'),
      Product(title: 'Trail Running Jacket Nike Windrunner', thumbnailPath: 'assets/images/img3.png', price: '\$99'),
      Product(title: 'Training Top Nike Sport Clash', thumbnailPath: 'assets/images/img2.png', price: '\$99'),
      Product(title: 'Trail Running Jacket Nike Windrunner', thumbnailPath: 'assets/images/img3.png', price: '\$99'),
      Product(title: 'Training Top Nike Sport Clash', thumbnailPath: 'assets/images/img2.png', price: '\$99'),
      Product(title: 'Trail Running Jacket Nike Windrunner', thumbnailPath: 'assets/images/img3.png', price: '\$99'),
      Product(title: 'Training Top Nike Sport Clash', thumbnailPath: 'assets/images/img2.png', price: '\$99'),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Wishlist',
        actions: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
            },
            child: Ink(
              width: 45,
              height: 45,
              decoration: ShapeDecoration(
                color: context.theme.cardColor,
                shape: const CircleBorder(),
              ),
              child: const Icon(LazaIcons.bag),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('65 Items', style: context.bodyLargeW500),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        Text(
                          'in wishlist',
                          style: context.bodyMedium?.copyWith(color: ColorConstant.manatee),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                  ],
                ),
                FilledButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 10.0)),
                    backgroundColor: MaterialStateProperty.all<Color>(context.theme.cardColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Icon(LazaIcons.edit, size: 18),
                      SizedBox(width: 5.0),
                      Text('Edit'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: products.length,
                  // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 250,
                    crossAxisSpacing: 15.0,
                    // mainAxisSpacing: 15.0,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(product: product);
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
