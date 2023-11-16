import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:laza/blocs/products/products_bloc.dart';
import 'package:laza/common/extensions/context_extension.dart';
import '../../domain/model/index.dart';
import '../routes/app_router.dart';
import 'components/colors.dart';
import 'components/laza_icons.dart';
import 'components/product_card.dart';
import 'dashboard_screen.dart';

@RoutePage()
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
                        onTap: () => context.router.push(const SearchRoute()),
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
                const Gap(10),
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
          const Gap(10),
          Headline(
            headline: 'Choose Brand',
            onViewAllTap: () {},
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              separatorBuilder: (_, __) => const Gap(10),
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
          const Gap(10),
          Headline(headline: 'New Arrival', onViewAllTap: () {}),
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              return state.maybeMap(
                  empty: (_) => const SizedBox.shrink(),
                  orElse: () => const Text('Loading..'),
                  error: (error) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(error.message ?? ''),
                          OutlinedButton(
                              onPressed: () {
                                context.read<ProductsBloc>().add(const ProductsEvent.getProducts());
                              },
                              child: const Text('Retry'))
                        ],
                      ),
                  loading: (_) => const CircularProgressIndicator.adaptive(),
                  loaded: (data) => GridView.builder(
                      shrinkWrap: true,
                      itemCount: data.products.length,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 250,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 15.0,
                      ),
                      itemBuilder: (context, index) {
                        final product = data.products[index];
                        return ProductCard(product: product);
                      }));
            },
          ),
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

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
              Row(
                children: [
                  InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    onTap: () => context.router.push(const CartRoute()),
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
            ],
          ),
        ),
      ),
    );
  }
}

class BrandTile extends StatelessWidget {
  const BrandTile({super.key, required this.brand, this.onTap});
  final Brand brand;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.router.push(BrandProductsRoute(brand: brand)),
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
