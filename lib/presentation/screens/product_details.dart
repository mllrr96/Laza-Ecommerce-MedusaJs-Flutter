import 'dart:math';
import 'package:animated_digit/animated_digit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:laza/common/extensions/context_extension.dart';
import 'package:medusa_store_flutter/store_models/products/product.dart';
import 'package:medusa_store_flutter/store_models/store/index.dart';
import '../routes/app_router.dart';
import '../theme/theme.dart';
import 'components/bottom_nav_button.dart';
import 'components/colors.dart';
import 'components/laza_icons.dart';

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
  ProductOption? selectedOption;
  ProductOptionValue? selectedOptionValue;
  ProductVariant? selectedVariant;
  @override
  void initState() {
    selectedImage = widget.product.thumbnail;
    if (widget.product.options?.length == 1 && widget.product.options?.first.values?.length == 1) {
      optionsSelected.addAll({widget.product.options!.first.id!: widget.product.options!.first.values!.first.value!});
    }

    if (widget.product.variants?.isNotEmpty ?? false) {
      price = widget.product.variants
              ?.map((e) => e.prices)
              .map((b) => b?.map((e) => e.amount).reduce((curr, next) => curr! < next! ? curr : next))
              .first ??
          0.0;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final bottomPadding = context.bottomViewPadding == 0.0 ? 30.0 : context.bottomViewPadding;

    num getPrice() {
      final formatCurrency = NumberFormat.simpleCurrency(name: 'USD');
      selectedOption = product.options?.where((option) => option.id == optionsSelected.keys.firstOrNull).firstOrNull;
      selectedOptionValue =
          selectedOption?.values?.where((value) => value.value == optionsSelected.values.firstOrNull).firstOrNull;
      selectedVariant = product.variants?.where((element) => element.id == selectedOptionValue?.variantId).firstOrNull;
      final amount = selectedVariant?.prices?.firstOrNull?.amount;
      if (amount != null) {
        price = amount;
      }

      num priceFormatted = price ?? 0;
      if (formatCurrency.decimalDigits! > 0) {
        priceFormatted /= pow(10, formatCurrency.decimalDigits!);
      }
      if (price == null) {
        return 0.0;
      }
      return formatCurrency.parse(formatCurrency.format(priceFormatted));
    }

    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 0),
          Container(
            color: context.theme.scaffoldBackgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Price', style: context.bodyMediumW600),
                    Text('with VAT,SD', style: context.bodyExtraSmall?.copyWith(color: ColorConstant.manatee)),
                  ],
                ),
                Text('\$125', style: context.bodyLargeW600)
              ],
            ),
          ),
          BottomNavButton(label: 'Add to Cart', onTap: () {}),
        ],
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
                      child: CachedNetworkImage(imageUrl: selectedImage!, fit: BoxFit.fitHeight),
                    )
                  : null,
            ),
            systemOverlayStyle: context.theme.appBarTheme.systemOverlayStyle!.copyWith(
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
                          Text(product.collection!.title!, style: context.bodySmall),
                        if (product.collection?.title != null) const Gap(5.0),
                        Text(product.title ?? '', style: context.headlineSmall),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price', style: context.bodySmall),
                      const Gap(5.0),
                      AnimatedDigitWidget(
                          value: getPrice(),
                          prefix: NumberFormat.simpleCurrency(name: 'USD').currencySymbol,
                          textStyle: context.headlineSmall,
                          fractionDigits: NumberFormat.simpleCurrency(name: 'USD').decimalDigits ?? 0),
                      // Text(getPriceText(), style: context.headlineSmall),
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
                    // const Gap(10),
                    Text(product.description!, style: context.bodyMedium?.copyWith(color: ColorConstant.manatee)),
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
                            onTap: () => setState(() => selectedImage = image.url),
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            child: Ink(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(image.url!), fit: BoxFit.fitWidth),
                              ),
                            ),
                          ),
                          const Gap(5),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: selectedImage == image.url ? 5 : 0,
                            width: 80,
                            decoration: BoxDecoration(
                                color: ColorConstant.primary,
                                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
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
                  final options = product.options![index];
                  // final values = options.values.;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(options.title ?? '', style: context.bodyLargeW600),
                      ),
                      const Gap(10),
                      SizedBox(
                        height: 70,
                        width: double.infinity,
                        child: ListView.separated(
                            separatorBuilder: (_, __) => const SizedBox(width: 10.0),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: options.values!.map((e) => e.value).toSet().toList().length,
                            itemBuilder: (context, index) {
                              final option = options.values!.map((e) => e.value).toSet().toList()[index];
                              // final option2 = product.variants?.where((element) => element.);
                              final bool isSelected =
                                  optionsSelected.containsKey(options.id) && optionsSelected.containsValue(option);
                              return InkWell(
                                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                onTap: () => setState(() => optionsSelected.addAll({options.id!: option!})),
                                child: Ink(
                                  height: 70,
                                  // width: 70,
                                  padding: const EdgeInsets.symmetric(horizontal: 70 / 2),
                                  decoration: BoxDecoration(
                                      color: context.theme.cardColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                      border:
                                          Border.all(color: isSelected ? ColorConstant.manatee : Colors.transparent)),
                                  child: Center(
                                    child: Text(
                                      option ?? '',
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
                          onPressed: () => context.router.push(const ReviewsRoute()), child: const Text('View All')),
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
                          style: context.bodyExtraSmall?.copyWith(color: ColorConstant.manatee),
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
                      style: context.bodyExtraSmall?.copyWith(color: ColorConstant.manatee),
                    )
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Color(0xffFF981F)),
                    const Icon(Icons.star, size: 14, color: Color(0xffFF981F)),
                    const Icon(Icons.star, size: 14, color: Color(0xffFF981F)),
                    Icon(Icons.star_border, size: 14, color: ColorConstant.manatee),
                    Icon(Icons.star_border, size: 14, color: ColorConstant.manatee)
                  ],
                ),
              ],
            ),
          ],
        ),
        const Gap(10),
        const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...')
      ],
    );
  }
}
