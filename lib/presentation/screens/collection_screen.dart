import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:laza/common/extensions/context_extension.dart';
import 'package:laza/di/di.dart';
import 'package:laza/presentation/screens/home/bloc/products/products_bloc.dart';
import 'package:medusa_store_flutter/store_models/products/product_collection.dart';
import '../components/index.dart';
import '../routes/app_router.dart';
import 'home/widgets/product_card.dart';

@RoutePage()
class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key, required this.collection});
  final ProductCollection collection;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<ProductsBloc>()
          ..add(ProductsEvent.loadProducts(queryParameters: {
            'collection_id': ['', collection.id]
          })),
        child: Scaffold(
          appBar: CollectionAppBar(
            collection: collection,
            actions: [
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
                  child: const Icon(LazaIcons.bag),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  return state.map(
                      loaded: (data) {
                        if (data.products.isEmpty) {
                          return const Center(child: Text('No products here'));
                        }
                        return Column(
                          children: [
                            const Gap(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${data.count?.toString() ?? 0} items', style: context.bodyLargeW500),
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
                                        const Gap(10),
                                        Text('Sort', style: context.bodyMediumW500),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(20),
                            Expanded(
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: data.products.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisExtent: 250,
                                    crossAxisSpacing: 15.0,
                                  ),
                                  itemBuilder: (context, index) {
                                    final product = data.products[index];
                                    return ProductCard(product: product);
                                  }),
                            ),
                          ],
                        );
                      },
                      loading: (_) => const Center(child: CircularProgressIndicator.adaptive()),
                      error: (error) => Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(error.message ?? 'Error loading products'),
                                ElevatedButton(
                                    onPressed: () {
                                      context.read<ProductsBloc>().add(ProductsEvent.loadProducts(queryParameters: {
                                            'collection_id': ['', collection.id]
                                          }));
                                    },
                                    child: const Text('Retry')),
                              ],
                            ),
                          ));
                },
              ),
            ),
          ),
        ));
  }
}

class CollectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CollectionAppBar({super.key, required this.collection, this.actions});
  final ProductCollection collection;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    final canPop = context.router.canPop();
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
                onTap: () => context.router.pop(),
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
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: context.theme.cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Text(collection.title ?? '')),
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
