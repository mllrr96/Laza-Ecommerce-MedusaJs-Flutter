import 'package:flutter/material.dart';
import 'package:laza/extensions/context_extension.dart';

import '../models/product.dart';
import '../product_details.dart';
import '../theme.dart';
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
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product))),
      child: Ink(
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(product.thumbnailPath), fit: BoxFit.fitHeight),
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
            const SizedBox(height: 10.0),
            SizedBox(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      product.title,
                      style: context.bodyExtraSmallW500?.copyWith(overflow: TextOverflow.ellipsis),
                      maxLines: 4,
                    ),
                  ),
                  Text(product.price),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
