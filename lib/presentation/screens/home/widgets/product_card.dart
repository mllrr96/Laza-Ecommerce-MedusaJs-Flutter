import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:laza/common/extensions/extensions.dart';
import 'package:medusa_store_flutter/store_models/products/product.dart';

import '../../../../common/colors.dart';
import '../../../../di/di.dart';
import '../../../../domain/repository/preference_repository.dart';
import '../../../components/index.dart';
import '../../../routes/app_router.dart';
import '../../../theme/theme.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final currencyCode = PreferenceRepository.currencyCode;
    num? price = product.variants
        ?.map((e) => e.prices)
        .map((b) => b?.map((e) => e.amount).reduce((curr, next) => curr! < next! ? curr : next))
        .first;

    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      onTap: () => context.router.push(ProductDetailsRoute(product: product)),
      child: Ink(
        height: 250,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (product.thumbnail == null)
              const SizedBox(
                height: 150,
                child: Placeholder(),
              ),
            if (product.thumbnail != null)
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: product.thumbnail!,
                    fit: BoxFit.fitHeight,
                    height: 150,
                    placeholder: (_, __) => const Center(child: CircularProgressIndicator.adaptive()),
                    errorWidget: (_, __, ___) => Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.error, color: Colors.amber, size: 30),
                              const Gap(10),
                              Flexible(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  'Error loading image',
                                  style: context.bodyExtraSmall,
                                  textAlign: TextAlign.center,
                                ),
                              )),
                            ],
                          ),
                          const Placeholder(),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4, top: 4),
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                          onTap: () {},
                          child: Ink(
                            width: 35,
                            height: 35,
                            decoration: ShapeDecoration(
                              color: AppTheme.lightTheme.cardColor,
                              shape: const CircleBorder(),
                            ),
                            child: Icon(
                              LazaIcons.heart,
                              color: ColorConstant.manatee,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      product.title ?? '',
                      style: context.bodyExtraSmallW500?.copyWith(overflow: TextOverflow.ellipsis),
                      maxLines: 4,
                    ),
                  ),
                  // const Spacer(),
                  Column(
                    children: [
                      Text(price.formatAsPrice(currencyCode), style: context.bodyMedium),
                      const Gap(5),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
