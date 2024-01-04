import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:laza/common/extensions/extensions.dart';
import 'package:medusa_store_flutter/store_models/store/line_item.dart';

import '../../../../common/colors.dart';
import '../../../../domain/repository/preference_repository.dart';
import '../../../components/laza_icons.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/line_item/line_item_bloc.dart';

class LineItemCard extends StatelessWidget {
  const LineItemCard({super.key, required this.lineItem, required this.cartId});
  final LineItem lineItem;
  final String cartId;
  @override
  Widget build(BuildContext context) {
    final invQuantity = lineItem.variant?.inventoryQuantity;
    final shouldAdd =
        (invQuantity ?? 1) > (lineItem.quantity?.toInt() ?? 0) || (lineItem.variant?.allowBackorder ?? false);
    final currencyCode = PreferenceRepository.currencyCode;

    return Container(
      height: 130,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        children: [
          if (lineItem.thumbnail != null)
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: context.theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  image: DecorationImage(image: CachedNetworkImageProvider(lineItem.thumbnail!), fit: BoxFit.fitWidth)),
            ),
          const Gap(10),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lineItem.title ?? '',
                      style: context.bodySmallW500,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const Gap(5),
                    Text(
                      lineItem.variant?.title ?? '',
                      style: context.bodySmallW500,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const Gap(5),
                    Text(
                      lineItem.total.formatAsPrice(currencyCode),
                      style: context.bodyExtraSmall?.copyWith(color: ColorConstant.manatee),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
                BlocListener<LineItemBloc, LineItemState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      success: (_) => context.read<CartBloc>().add(CartEvent.refreshCart(_)),
                      failure: (message) => Fluttertoast.showToast(msg: message),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                              onTap: () {
                                context
                                    .read<LineItemBloc>()
                                    .add(LineItemEvent.update(cartId, lineItem.id!, lineItem.quantity! - 1));
                              },
                              child: Ink(
                                width: 30,
                                height: 30,
                                decoration: ShapeDecoration(
                                  color: context.theme.scaffoldBackgroundColor,
                                  shape: const CircleBorder(),
                                ),
                                child: const Icon(Icons.arrow_drop_down),
                              ),
                            ),
                          ),
                          const Gap(15),
                          Text(lineItem.quantity?.toString() ?? ''),
                          const Gap(15),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                              onTap: shouldAdd
                                  ? () {
                                      context
                                          .read<LineItemBloc>()
                                          .add(LineItemEvent.update(cartId, lineItem.id!, lineItem.quantity! + 1));
                                    }
                                  : null,
                              child: Ink(
                                width: 30,
                                height: 30,
                                decoration: ShapeDecoration(
                                  color: context.theme.scaffoldBackgroundColor,
                                  shape: const CircleBorder(),
                                ),
                                child: shouldAdd
                                    ? const Icon(Icons.arrow_drop_up)
                                    : Icon(Icons.arrow_drop_up, color: ColorConstant.manatee),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // const Icon(LazaIcons.delete, size: 18)
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                          onTap: () {
                            context.read<LineItemBloc>().add(LineItemEvent.delete(cartId, lineItem.id!));
                          },
                          child: Ink(
                            width: 30,
                            height: 30,
                            decoration: ShapeDecoration(
                              color: context.theme.scaffoldBackgroundColor,
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(LazaIcons.delete, size: 14.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
