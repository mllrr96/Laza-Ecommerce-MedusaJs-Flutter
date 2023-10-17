import 'package:flutter/material.dart';
import 'package:laza/brand_products_screen.dart';
import 'package:laza/cart_screen.dart';
import 'package:laza/components/colors.dart';
import 'package:laza/dashboard.dart';
import 'package:laza/extensions/context_extension.dart';
import 'package:laza/search_screen.dart';

import 'components/laza_icons.dart';
import 'components/product_card.dart';
import 'models/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const brands = [
      Brand('Adidas', LazaIcons.adidas_logo),
      Brand('Nike', LazaIcons.nike_logo),
      Brand('Puma', LazaIcons.puma_logo),
      Brand('Fila', LazaIcons.fila_logo),
    ];

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
        ],
      ),
      Product(title: 'Trail Running Jacket Nike Windrunner', thumbnailPath: 'assets/images/img3.png', price: '\$99'),
      Product(title: 'Training Top Nike Sport Clash', thumbnailPath: 'assets/images/img2.png', price: '\$99'),
      Product(title: 'Trail Running Jacket Nike Windrunner', thumbnailPath: 'assets/images/img3.png', price: '\$99'),
    ];

    const inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(width: 0, color: Colors.transparent));
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello',
                  style: context.headlineMedium,
                ),
                Text(
                  'Welcome to Laza',
                  style: context.bodyMedium?.copyWith(color: ColorConstant.manatee),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Hero(
                    tag: 'search',
                    child: Material(
                      color: Colors.transparent,
                      child: TextField(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const SearchScreen(), fullscreenDialog: true)),
                        readOnly: true,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: 'Search ...',
                            contentPadding: EdgeInsets.zero,
                            border: inputBorder,
                            enabledBorder: inputBorder,
                            focusedBorder: inputBorder,
                            hintStyle: TextStyle(color: ColorConstant.manatee),
                            fillColor: context.theme.cardColor,
                            prefixIcon: Icon(LazaIcons.search, color: ColorConstant.manatee)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Hero(
                  tag: 'voice',
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      onTap: () {},
                      child: Ink(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            color: ColorConstant.primary, borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                        child: const Icon(LazaIcons.voice, color: Colors.white, size: 22),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Headline(
            headline: 'Choose Brand',
            onViewAllTap: () {},
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              separatorBuilder: (_, __) => const SizedBox(width: 10.0),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: brands.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final brand = brands[index];
                return BrandTile(brand: brand);
              },
            ),
          ),
          const SizedBox(height: 10.0),
          Headline(headline: 'New Arrival', onViewAllTap: () {}),
          GridView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 250,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(product: product);
              }),
        ],
      )),
    );
  }
}


class Headline extends StatelessWidget {
  const Headline({super.key, required this.headline, this.onViewAllTap});
  final String headline;
  final void Function()? onViewAllTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headline,
            style: context.bodyLargeW500,
          ),
          TextButton(
            onPressed: onViewAllTap,
            child: Text(
              'View All',
              style: context.bodySmall?.copyWith(color: ColorConstant.manatee),
            ),
          )
        ],
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: 'search_back',
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    onTap: () {
                      dashboardScaffoldKey.currentState?.openDrawer();
                    },
                    child: Ink(
                      width: 45,
                      height: 45,
                      decoration: ShapeDecoration(
                        color: context.theme.cardColor,
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(
                        LazaIcons.menu_horizontal,
                        size: 13,
                      ),
                    ),
                  ),
                ),
              ),
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
                  child: const Icon(
                    LazaIcons.bag,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class BrandTile extends StatelessWidget {
  const BrandTile({super.key, required this.brand, this.onTap});
  final Brand brand;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> BrandProductsScreen(brand: brand))),
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: Ink(
        height: 50,
        width: 115,
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: context.theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Icon(
                brand.iconData,
                size: brand.name == 'Fila' ? 12 : 18,
              ),
            ),
            Expanded(
                child: Text(
              brand.name,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            )),
          ],
        ),
      ),
    );
  }
}
