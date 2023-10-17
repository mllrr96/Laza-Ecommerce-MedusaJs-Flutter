import 'package:flutter/material.dart';
import 'package:laza/components/bottom_nav_button.dart';
import 'package:laza/components/colors.dart';
import 'package:laza/extensions/context_extension.dart';
import 'package:laza/models/index.dart';
import 'package:laza/reviews_screen.dart';
import 'package:laza/theme.dart';

import 'cart_screen.dart';
import 'components/laza_icons.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late String selectedImage;
  @override
  void initState() {
    selectedImage = widget.product.thumbnailPath;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final bottomPadding = context.bottomViewPadding == 0.0 ? 30.0 : context.bottomViewPadding;
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
              onTap: () => Navigator.pop(context),
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
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen())),
                  child: Ink(
                    width: 45,
                    height: 45,
                    decoration: ShapeDecoration(
                      color: AppTheme.lightTheme.cardColor,
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(
                      LazaIcons.bag,
                    ),
                  ),
                ),
              ),
            ],
            backgroundColor: const Color(0xffF2F2F2),
            surfaceTintColor: Colors.transparent,
            // backgroundColor: context.theme.scaffoldBackgroundColor,
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                  child: Image.asset(
                selectedImage,
                fit: BoxFit.fitHeight,
              )),
            ),
            systemOverlayStyle: context.theme.appBarTheme.systemOverlayStyle!.copyWith(
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
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
                      Text(product.category ?? 'Men\'s Printed Pullover Hoodie', style: context.bodySmall),
                      const SizedBox(height: 5.0),
                      Text(
                        product.title,
                        style: context.headlineSmall,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price', style: context.bodySmall),
                    const SizedBox(height: 5.0),
                    Text(
                      product.price,
                      style: context.headlineSmall,
                    ),
                  ],
                ),
              ],
            ),
          )),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          if (widget.product.images != null)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 80,
                width: double.infinity,
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final image = widget.product.images![index];
                      return InkWell(
                        onTap: () => setState(() => selectedImage = image),
                        child: Ink(
                          height: double.infinity,
                          width: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(image)),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 10.0),
                    itemCount: widget.product.images!.length),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 5)),
          // ============================================================
          // Size Guide
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Size',
                        style: context.bodyLargeW600,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text('Size Guide',
                              style: context.bodyMedium?.copyWith(color: context.theme.primaryColor))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: ListView.separated(
                      separatorBuilder: (_, __) => const SizedBox(width: 10.0),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final text = ['S', 'M', 'L', 'XL', 'XXL'][index];
                        return Container(
                          height: 70,
                          width: 70,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: context.theme.cardColor,
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Text(
                            text,
                            style: context.bodyLargeW600,
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          // ============================================================
          // Size Guide
          if (product.description != null)
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description', style: context.bodyLargeW600),
                  const SizedBox(height: 10.0),
                  Text(product.description!, style: context.bodyMedium?.copyWith(color: ColorConstant.manatee)),
                  const SizedBox(height: 20.0),
                ],
              ),
            )),
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ReviewsScreen())),
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
          SliverToBoxAdapter(child: SizedBox(height: bottomPadding)),
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
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ronald Richards', style: context.bodyMediumW500),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        Icon(
                          LazaIcons.clock,
                          color: ColorConstant.manatee,
                          size: 18,
                        ),
                        const SizedBox(width: 5.0),
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
                const SizedBox(height: 5.0),
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
        const SizedBox(height: 10.0),
        const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...')
      ],
    );
  }
}
