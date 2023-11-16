import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:laza/common/extensions/context_extension.dart';
import 'package:medusa_store_flutter/store_models/products/product.dart';

import '../../../di/di.dart';
import '../../../domain/repository/preference_repository.dart';
import '../../routes/app_router.dart';
import '../../theme/theme.dart';
import 'colors.dart';
import 'laza_icons.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    String getPriceText() {
      num? price;
      if (product.variants?.isNotEmpty ?? false) {
        price = product.variants
            ?.map((e) => e.prices)
            .map((b) => b?.map((e) => e.amount).reduce((curr, next) => curr! < next! ? curr : next))
            .first;
      }

      final formatCurrency = NumberFormat.simpleCurrency(name: getIt<PreferenceRepository>().currencyCode);

      num lowestPriceNum = price ?? 0;
      if (formatCurrency.decimalDigits! > 0) {
        lowestPriceNum /= pow(10, formatCurrency.decimalDigits!);
      }
      if (price == null) {
        return '';
      }
      return formatCurrency.format(lowestPriceNum);
    }

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
              Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(image: CachedNetworkImageProvider(product.thumbnail!), fit: BoxFit.fitHeight),
                ),
                child: Align(
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
              ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      product.title ?? '',
                      style: context.bodyExtraSmallW500?.copyWith(overflow: TextOverflow.ellipsis),
                      maxLines: 4,
                    ),
                  ),
                  const Spacer(),
                  Text(getPriceText(), style: context.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
