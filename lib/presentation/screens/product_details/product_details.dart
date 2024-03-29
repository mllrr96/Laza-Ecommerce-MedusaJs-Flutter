import 'package:animated_digit/animated_digit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:laza/domain/repository/preference_repository.dart';
import 'package:laza/presentation/routes/app_router.dart';
import 'package:laza/common/colors.dart';
import 'package:laza/common/extensions/extensions.dart';
import 'package:laza/presentation/components/index.dart';
import 'package:laza/presentation/theme/theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medusa_store_flutter/medusa_store.dart';
import 'widgets/bottom_nav_button.dart';

@RoutePage()
class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late String? selectedImage;
  late num? price;
  Map<String, String> optionsSelected = {};
  ProductVariant? selectedVariant;
  @override
  void initState() {
    selectedImage = widget.product.thumbnail;
    if (widget.product.options?.length == 1 &&
        widget.product.options?.first.values?.length == 1 &&
        widget.product.variants?.length == 1) {
      optionsSelected.addAll({
        widget.product.options!.first.id!:
            widget.product.options!.first.values!.first.value!
      });
      selectedVariant = widget.product.variants?.first;
    }

    if (widget.product.variants?.isNotEmpty ?? false) {
      price = widget.product.variants
              ?.map((e) => e.prices)
              .map((b) => b
                  ?.map((e) => e.amount)
                  .reduce((curr, next) => curr! < next! ? curr : next))
              .first ??
          0.0;
    }

    super.initState();
  }

  void selectVariant() {
    if (optionsSelected.length != widget.product.options!.length) {
      return;
    }
    final values = optionsSelected.values.toList();
    widget.product.variants?.forEach((variant) {
      List<String>? titleList = variant.title
          ?.split('/')
          .toList()
          .map((e) => e.replaceAll(' ', ''))
          .toList();
      if (titleList != null && titleList.toSet().containsAll(values.toSet())) {
        setState(() {
          selectedVariant = variant;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final bottomPadding =
        context.bottomViewPadding == 0.0 ? 30.0 : context.bottomViewPadding;
    final currencyCode = PreferenceRepository.currencyCode;

    num variantPrice() {
      // in case the customer didn't select any variant then show the lowest price of the product
      // aka starts from price
      if (selectedVariant == null) {
        List<MoneyAmount> prices = [];
        product.variants?.forEach((variant) {
          variant.prices?.forEach((price) {
            if (price.currencyCode?.toUpperCase() == currencyCode) {
              prices.add(price);
            }
          });
        });
        final startFromPrice = prices
            .map((e) => e.amount ?? 0)
            .reduce((current, next) => current < next ? current : next);
        return startFromPrice.formatAsPriceNum(currencyCode);
      }
      final amount = selectedVariant?.prices
          ?.where((price) => price.currencyCode?.toUpperCase() == currencyCode)
          .firstOrNull
          ?.amount;
      return amount.formatAsPriceNum(currencyCode);
    }

    return Scaffold(
      bottomNavigationBar: ProductDetailsBottomNavButton(
        selectedVariant: selectedVariant,
        product: widget.product,
        optionsSelected: optionsSelected,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leadingWidth: 0,
            leading: const SizedBox.shrink(),
            title: InkWell(
              borderRadius: BorderRadius.circular(56),
              radius: 56,
              onTap: () => context.router.pop(),
              child: Ink(
                width: 45,
                height: 45,
                decoration: ShapeDecoration(
                  color: AppTheme.lightTheme.cardColor,
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.arrow_back_outlined),
              ),
            ),
            centerTitle: false,
            pinned: true,
            actions: [
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                onTap: () {},
                child: Ink(
                  width: 45,
                  height: 45,
                  decoration: ShapeDecoration(
                    color: AppTheme.lightTheme.cardColor,
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(LazaIcons.heart),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 10.0),
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  onTap: () => context.router.push(const CartRoute()),
                  child: Ink(
                    width: 45,
                    height: 45,
                    decoration: ShapeDecoration(
                      color: AppTheme.lightTheme.cardColor,
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(LazaIcons.bag),
                  ),
                ),
              ),
            ],
            foregroundColor: ColorConstant.primary,
            backgroundColor: const Color(0xffF2F2F2),
            surfaceTintColor: Colors.transparent,
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              background: selectedImage != null
                  ? SafeArea(
                      child: CachedNetworkImage(
                          imageUrl: selectedImage!, fit: BoxFit.fitHeight),
                    )
                  : null,
            ),
            systemOverlayStyle:
                context.theme.appBarTheme.systemOverlayStyle!.copyWith(
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
          ),
          const SliverGap(20),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product.collection?.title != null)
                          Text(product.collection!.title!,
                              style: context.bodySmall),
                        if (product.collection?.title != null) const Gap(5.0),
                        Text(product.title ?? '', style: context.headlineSmall),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(selectedVariant == null ? 'Starts From' : 'Price',
                          style: context.bodySmall),
                      const Gap(5.0),
                      AnimatedDigitWidget(
                          value: variantPrice(),
                          prefix:
                              NumberFormat.simpleCurrency(name: currencyCode)
                                  .currencySymbol,
                          textStyle: context.headlineSmall,
                          fractionDigits:
                              NumberFormat.simpleCurrency(name: currencyCode)
                                      .decimalDigits ??
                                  0),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SliverGap(10),
          if (product.description != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.description!,
                        style: context.bodyMedium
                            ?.copyWith(color: ColorConstant.manatee)),
                    const Gap(20),
                  ],
                ),
              ),
            ),
          if (widget.product.images?.isNotEmpty ?? false)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 90,
                width: double.infinity,
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final image = widget.product.images![index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () =>
                                setState(() => selectedImage = image.url),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            child: Ink(
                              height: 80,
                              width: 80,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: CachedNetworkImage(
                                imageUrl: image.url!,
                                fit: BoxFit.fitWidth,
                                placeholder: (_, __) => Center(
                                    child: LoadingAnimationWidget
                                        .threeArchedCircle(
                                            color: Colors.grey, size: 24)),
                                errorWidget: (_, __, ___) => const Icon(
                                    Icons.error,
                                    size: 30,
                                    color: Colors.amber),
                              ),
                            ),
                          ),
                          const Gap(5),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 5,
                            width: selectedImage == image.url ? 40 : 0,
                            decoration: BoxDecoration(
                                color: ColorConstant.primary,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                          )
                        ],
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 10.0),
                    itemCount: widget.product.images!.length),
              ),
            ),
          const SliverGap(5),
          // ============================================================
          // Options
          if (product.options?.isNotEmpty ?? false)
            SliverToBoxAdapter(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: product.options!.length,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const Gap(10),
                itemBuilder: (context, index) {
                  final productOption = product.options![index];
                  // final values = options.values.;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(productOption.title ?? '',
                            style: context.bodyLargeW600),
                      ),
                      const Gap(10),
                      SizedBox(
                        height: 70,
                        width: double.infinity,
                        child: ListView.separated(
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 10.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: productOption.values!
                                .map((e) => e.value)
                                .toSet()
                                .toList()
                                .length,
                            itemBuilder: (context, index) {
                              final productOptionValue = productOption.values!
                                  .map((e) => e.value)
                                  .toSet()
                                  .toList()[index];
                              final bool isSelected = optionsSelected
                                      .containsKey(productOption.id) &&
                                  optionsSelected
                                      .containsValue(productOptionValue);

                              return InkWell(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                onTap: () {
                                  setState(() => optionsSelected.addAll({
                                        productOption.id!: productOptionValue!
                                      }));
                                  selectVariant();
                                },
                                child: Ink(
                                  height: 70,
                                  // width: 70,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 70 / 2),
                                  decoration: BoxDecoration(
                                      color: context.theme.cardColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      border: Border.all(
                                          color: isSelected
                                              ? ColorConstant.manatee
                                              : Colors.transparent)),
                                  child: Center(
                                    child: Text(
                                      productOptionValue ?? '',
                                      style: context.bodyLargeW600,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  );
                },
              ),
            ),
          const SliverGap(20),
          // ============================================================
          // Reviews
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reviews',
                        style: context.bodyLargeW600,
                      ),
                      TextButton(
                          onPressed: () =>
                              context.pushRoute(const ReviewsRoute()),
                          child: const Text('View All')),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: ReviewCard(),
                ),
              ],
            ),
          ),

          // ============================================================
          // Bottom padding
          SliverGap(bottomPadding),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ronald Richards', style: context.bodyMediumW500),
                    const Gap(5),
                    Row(
                      children: [
                        Icon(
                          LazaIcons.clock,
                          color: ColorConstant.manatee,
                          size: 18,
                        ),
                        const Gap(5),
                        Text(
                          '13 Sep, 2020',
                          style: context.bodyExtraSmall
                              ?.copyWith(color: ColorConstant.manatee),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      '4.8',
                      style: context.bodyMediumW500,
                    ),
                    Text(
                      ' rating',
                      style: context.bodyExtraSmall
                          ?.copyWith(color: ColorConstant.manatee),
                    )
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Color(0xffFF981F)),
                    const Icon(Icons.star, size: 14, color: Color(0xffFF981F)),
                    const Icon(Icons.star, size: 14, color: Color(0xffFF981F)),
                    Icon(Icons.star_border,
                        size: 14, color: ColorConstant.manatee),
                    Icon(Icons.star_border,
                        size: 14, color: ColorConstant.manatee)
                  ],
                ),
              ],
            ),
          ],
        ),
        const Gap(10),
        const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...')
      ],
    );
  }
}
