import 'package:flutter/material.dart';
import 'package:laza/extensions/context_extension.dart';
import 'package:laza/models/brand.dart';

import 'cart_screen.dart';
import 'components/colors.dart';
import 'components/laza_icons.dart';
import 'components/product_card.dart';
import 'models/product.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key, required this.brand});
  final Brand brand;
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
      appBar: BrandAppBar(
        brand: brand,
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
            const SizedBox(height: 10),
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
                          'Available in stock',
                          style: context.bodyMedium?.copyWith(color: ColorConstant.manatee),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      color: context.theme.cardColor,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(LazaIcons.sort, size: 10, color: context.bodyMediumW500?.color),
                        const SizedBox(width: 10.0),
                        Text('Sort', style: context.bodyMediumW500),
                      ],
                    ),
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

class BrandAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BrandAppBar({super.key, required this.brand, this.actions});
  final Brand brand;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
    return Container(
      height: kToolbarHeight,
      margin: EdgeInsets.only(top: context.viewPadding.top),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: canPop || actions != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
          children: [
            if (canPop)
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                onTap: () => Navigator.pop(context),
                child: Ink(
                  width: 45,
                  height: 45,
                  decoration: ShapeDecoration(
                    color: context.theme.cardColor,
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.arrow_back_outlined),
                ),
              ),
            if (!canPop && actions != null) const SizedBox(height: 45, width: 45),
            Container(
              height: 40,
              width: 70,
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Icon(
                brand.iconData,
                size: brand.name == 'Fila' ? 16 : 25,
              ),
            ),
            if (canPop && actions == null) const SizedBox(height: 45, width: 45),
            if (actions != null)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: actions!,
              )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
