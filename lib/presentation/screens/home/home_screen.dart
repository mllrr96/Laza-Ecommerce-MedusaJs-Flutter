import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:laza/common/extensions/context_extension.dart';
import 'package:laza/presentation/screens/home/widgets/product_card.dart';
import 'package:medusa_store_flutter/store_models/products/product_collection.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../common/colors.dart';
import '../../components/index.dart';
import '../../routes/app_router.dart';
import '../dashboard_screen.dart';
import 'bloc/collections/collections_bloc.dart';
import 'bloc/products/products_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
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
          BlocBuilder<CollectionsBloc, CollectionsState>(
            builder: (context, state) {
              return state.map(
                  loading: (_) => Skeletonizer(
                        enabled: true,
                        child: Column(
                          children: [
                            Headline(
                              headline: 'Collections',
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
                                itemCount: 4,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return CollectionTile(collection: ProductCollection(title: 'Shorts'));
                                  // return CollectionTile(collection: collection);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                  loaded: (data) {
                    if (data.collections.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      children: [
                        Headline(
                          headline: 'Collections',
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
                            itemCount: data.collections.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final collection = data.collections[index];
                              return CollectionTile(collection: collection);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  error: (_) => Column(
                        children: [
                          Headline(
                            headline: 'Collections',
                            onViewAllTap: () {},
                          ),
                          const SizedBox(
                            height: 50,
                            child: Text('Error loading collections'),
                          ),
                        ],
                      ));
            },
          ),
          const Gap(10),
          Headline(headline: 'New Arrival', onViewAllTap: () {}),
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              return state.map(
                empty: (_) => const SizedBox.shrink(),
                error: (error) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(error.message ?? ''),
                    OutlinedButton(
                        onPressed: () {
                          context.read<ProductsBloc>().add(const ProductsEvent.loadProducts());
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
                    }),
              );
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

class CollectionTile extends StatelessWidget {
  const CollectionTile({super.key, required this.collection, this.onTap});
  final ProductCollection collection;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.router.push(CollectionRoute(collection: collection)),
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
            // Container(
            //   height: 40,
            //   width: 40,
            //   margin: const EdgeInsets.all(5),
            //   decoration: BoxDecoration(
            //     color: context.theme.scaffoldBackgroundColor,
            //     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            //   ),
            //   child: Icon(
            //     brand.iconData,
            //     size: brand.name == 'Fila' ? 12 : 18,
            //   ),
            // ),
            Expanded(
                child: Text(
              collection.title ?? '',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            )),
          ],
        ),
      ),
    );
  }
}
