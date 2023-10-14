import 'package:flutter/material.dart';
import 'package:laza/components/colors.dart';
import 'package:laza/dashboard.dart';
import 'package:laza/extensions/context_extension.dart';
import 'package:laza/order_confirmed_screen.dart';
import 'package:laza/search_screen.dart';

import 'components/laza_icons.dart';

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
      Product('Nike Sportswear Club Fleece', 'assets/images/img2.png', '\$99'),
      Product('Trail Running Jacket Nike Windrunner', 'assets/images/img3.png', '\$99'),
      Product('Training Top Nike Sport Clash', 'assets/images/img2.png', '\$99'),
      Product('Trail Running Jacket Nike Windrunner', 'assets/images/img3.png', '\$99'),
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
                  style: context.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
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
                  child: TextField(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen())),
                    readOnly: true,
                    decoration:  InputDecoration(
                        filled: true,
                        hintText: 'Search ...',
                        contentPadding: EdgeInsets.zero,
                        border: inputBorder,
                        enabledBorder: inputBorder,
                        focusedBorder: inputBorder,
                        hintStyle: TextStyle(color: ColorConstant.manatee),
                        fillColor: context.theme.cardColor,
                        prefixIcon: Hero(tag: 'search', child: Icon(LazaIcons.search, color: ColorConstant.manatee))),
                  ),
                ),
                const SizedBox(width: 10.0),
                InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  onTap: () {},
                  child: Ink(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: ColorConstant.primary, borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                    child: const Icon(LazaIcons.voice, color: Colors.white, size: 22),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          const Headline(headline: 'Choose Brand'),
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
                return InkWell(
                  onTap: () {},
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Ink(
                    height: 50,
                    width: 115,
                    decoration: const BoxDecoration(
                      color: Color(0xffF5F6FA),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Color(0xffFEFEFE),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
              },
            ),
          ),
          const SizedBox(height: 10.0),
          const Headline(headline: 'New Arrival'),
          GridView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 15.0, mainAxisSpacing: 15.0),
              itemBuilder: (context, index) {
                final product = products[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Image.asset(
                      product.imagePath,
                      fit: BoxFit.fitWidth,
                    )),
                    Text(
                      product.title,
                      style: const TextStyle(fontSize: 11),
                    ),
                    Text(product.price),
                  ],
                );
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
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                onTap: () {
                  dashboardScaffoldKey.currentState?.openDrawer();
                },
                child: Ink(
                  width: 45,
                  height: 45,
                  decoration:  ShapeDecoration(
                    color: context.theme.cardColor,
                    shape: CircleBorder(),
                  ),
                  child: const Icon(
                    LazaIcons.menu_horizontal,
                    size: 13,
                  ),
                ),
              ),
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderConfirmedScreen()));
                },
                child: Ink(
                  width: 45,
                  height: 45,
                  decoration:  ShapeDecoration(
                    color: context.theme.cardColor,
                    shape: CircleBorder(),
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

class Brand {
  final String name;
  final IconData iconData;
  const Brand(this.name, this.iconData);
}

class Product {
  final String title;
  final String imagePath;
  final String price;
  const Product(this.title, this.imagePath, this.price);
}
