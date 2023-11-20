import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:laza/common/extensions/context_extension.dart';
import 'package:laza/presentation/screens/home/widgets/index.dart';
import 'package:medusa_store_flutter/store_models/store/index.dart';
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
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
            sliver: SliverAppBar(
              shadowColor: Colors.transparent,
              snap: true,
              floating: true,
              leadingWidth: 45,
              title: Hero(
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
              leading: Hero(
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
                      child: Icon(
                        LazaIcons.menu_horizontal,
                        size: 13,
                        color: context.theme.iconTheme.color,
                      ),
                    ),
                  ),
                ),
              ),
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
                    child: Icon(
                      LazaIcons.bag,
                      color: context.theme.iconTheme.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SliverGap(10),
          SliverToBoxAdapter(
            child: Headline(
              headline: 'Collections',
              onViewAllTap: () {},
            ),
          ),
          BlocBuilder<CollectionsBloc, CollectionsState>(
            builder: (context, state) {
              return state.map(
                  loading: (_) => SliverToBoxAdapter(
                        child: Skeletonizer(
                          enabled: true,
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              separatorBuilder: (_, __) => const Gap(10),
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return CollectionTile(collection: ProductCollection(title: 'Shorts'));
                                // return CollectionTile(collection: collection);
                              },
                            ),
                          ),
                        ),
                      ),
                  loaded: (data) {
                    if (data.collections.isEmpty) {
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    }
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 50,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          separatorBuilder: (_, __) => const Gap(10),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.collections.length + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (index == data.collections.length) {
                              if (data.collections.length > 3) {
                                return CollectionTile(collection: ProductCollection(title: 'More'), onTap: () {});
                              } else {
                                return const SizedBox.shrink();
                              }
                            }
                            final collection = data.collections[index];
                            return CollectionTile(collection: collection);
                            // return CollectionTile(collection: collection);
                          },
                        ),
                      ),
                    );
                  },
                  error: (_) => const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 50,
                          child: Text('Error loading collections'),
                        ),
                      ));
            },
          ),
          const SliverGap(10),
          SliverToBoxAdapter(child: Headline(headline: 'New Arrival', onViewAllTap: () {})),
          const NewArrival()
        ],
      )),
    );
  }
}

class NewArrival extends StatefulWidget {
  const NewArrival({super.key});

  @override
  State<NewArrival> createState() => _NewArrivalState();
}

class _NewArrivalState extends State<NewArrival> {
  static const _pageSize = 10;

  final PagingController<int, Product> _pagingController = PagingController(firstPageKey: 0);
  late ProductsBloc productsBloc;
  List<Product> loadedProducts = [];

  @override
  void initState() {
    productsBloc = context.read<ProductsBloc>();
    _pagingController.addPageRequestListener((pageKey) {
      productsBloc.add(ProductsEvent.loadProducts(queryParameters: {
        'offset': pageKey,
        'limit': _pageSize,
      }));
    });
    super.initState();
  }

  void _loaded(List<Product> products, int? limit, int? count, int? offset) {
    final newItems = products;
    loadedProducts.addAll(products);
    final isLastPage = newItems.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(newItems);
    } else {
      final nextPageKey = 1 + loadedProducts.length;
      _pagingController.appendPage(newItems, nextPageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (BuildContext context, ProductsState state) {
        state.whenOrNull(
          loaded: _loaded,
          error: (error) => _pagingController.error = error,
        );
      },
      builder: (context, state) {
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          sliver: PagedSliverGrid(
            pagingController: _pagingController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 250,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 15.0,
            ),
            builderDelegate: PagedChildBuilderDelegate<Product>(
              itemBuilder: (context, product, index) => ProductCard(product: product),
            ),
          ),
        );
      },
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

class CollectionTile extends StatelessWidget {
  const CollectionTile({super.key, required this.collection, this.onTap});
  final ProductCollection collection;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () => context.router.push(CollectionRoute(collection: collection)),
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
      ),
    );
  }
}
