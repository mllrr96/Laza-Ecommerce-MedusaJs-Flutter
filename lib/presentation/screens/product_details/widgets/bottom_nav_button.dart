import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laza/common/colors.dart';
import 'package:laza/common/extensions/extensions.dart';
import 'package:laza/domain/repository/preference_repository.dart';
import 'package:laza/presentation/components/index.dart';
import 'package:laza/presentation/screens/cart/bloc/cart/cart_bloc.dart';
import 'package:laza/presentation/screens/cart/bloc/line_item/line_item_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medusa_store_flutter/medusa_store.dart';

class ProductDetailsBottomNavButton extends StatefulWidget {
  const ProductDetailsBottomNavButton(
      {super.key,
      required this.selectedVariant,
      required this.product,
      required this.optionsSelected});
  final ProductVariant? selectedVariant;
  final Product product;
  final Map<String, String> optionsSelected;

  @override
  State<ProductDetailsBottomNavButton> createState() =>
      _ProductDetailsBottomNavButtonState();
}

class _ProductDetailsBottomNavButtonState
    extends State<ProductDetailsBottomNavButton> {
  @override
  Widget build(BuildContext context) {
    final String currencyCode = PreferenceRepository.currencyCode;
    return BlocConsumer<LineItemBloc, LineItemState>(
      listener: (context, lineState) {
        lineState.whenOrNull(
          success: (_) =>
              context.read<CartBloc>().add(CartEvent.refreshCart(_)),
          failure: (message) => Fluttertoast.showToast(msg: message),
        );
      },
      builder: (context, lineState) {
        return BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            return cartState.maybeMap(
                loaded: (loaded) {
                  final inCart = loaded.cart.items
                          ?.map((e) => e.variantId)
                          .toList()
                          .contains(widget.selectedVariant?.id) ??
                      false;
                  final lineItem = loaded.cart.items
                      ?.where((element) =>
                          element.variantId == widget.selectedVariant?.id)
                      .firstOrNull;
                  final Widget addRemoveItemWidget = Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              context.read<LineItemBloc>().add(
                                  LineItemEvent.update(
                                      loaded.cart.id!,
                                      lineItem!.id!,
                                      lineItem.quantity! - 1));
                            },
                            child: Ink(
                              height: 50,
                              color: ColorConstant.primary,
                              child: const Center(
                                  child: Icon(Icons.remove, color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Center(
                              child: Text(lineItem?.quantity
                                  ?.toString() ??
                                  '', style: const TextStyle(color: Colors.white),))),
                      Expanded(
                        flex: 2,
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              context.read<LineItemBloc>().add(
                                  LineItemEvent.update(
                                      loaded.cart.id!,
                                      lineItem!.id!,
                                      lineItem.quantity! + 1));
                            },
                            child: Ink(
                              height: 50,
                              color: ColorConstant.primary,
                              child: const Center(
                                  child: Icon(Icons.add, color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                  final Widget addRemoveItemLoadingWidget = Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Material(
                          child: InkWell(
                            onTap:null,
                            child: Ink(
                              height: 50,
                              color: ColorConstant.primary,
                              child: const Center(
                                  child: Icon(Icons.remove, color: Colors.white70)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Center(
                              child: LoadingAnimationWidget
                                  .threeArchedCircle(
                                  color: Colors.white, size: 24))),
                      Expanded(
                        flex: 2,
                        child: Material(
                          child: InkWell(
                            onTap:null,
                            child: Ink(
                              height: 50,
                              color: ColorConstant.primary,
                              child: const Center(
                                  child: Icon(Icons.add, color: Colors.white70)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );

                  if (inCart) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Divider(height: 0),
                        Container(
                          color: context.theme.scaffoldBackgroundColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Total Price',
                                      style: context.bodyMediumW600),
                                  Text('with VAT,SD',
                                      style: context.bodyExtraSmall?.copyWith(
                                          color: ColorConstant.manatee)),
                                ],
                              ),
                              Text(
                                  lineItem?.total.formatAsPrice(currencyCode) ??
                                      '',
                                  style: context.bodyLargeW600)
                            ],
                          ),
                        ),
                        Container(
                          color: ColorConstant.primary,
                          height: 50,
                          child: BlocBuilder<LineItemBloc, LineItemState>(
                            builder: (context, state) {
                              return state.map(
                                initial: (_) => addRemoveItemWidget,
                                success: (cart) => addRemoveItemWidget,
                                loading: (_) => addRemoveItemLoadingWidget,
                                failure: (error) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Error adding item'),
                                      TextButton(
                                          onPressed: () {
                                            if (widget.optionsSelected.length !=
                                                    widget.product.options!
                                                        .length &&
                                                widget.selectedVariant ==
                                                    null) {
                                              return;
                                            }
                                            context.read<LineItemBloc>().add(
                                                LineItemEvent.add(
                                                    PreferenceRepository
                                                        .instance.cartId!,
                                                    widget.selectedVariant!.id!,
                                                    1));
                                          },
                                          child: const Text('Retry')),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Container(
                          height: context.bottomViewPadding,
                          color: ColorConstant.primary,
                        )
                      ],
                    );
                  } else if(!inCart && lineState == LineItemState.loading(lineItemId: widget.selectedVariant?.id)){
                    return Container(
                      color: ColorConstant.primary,
                      height: 50,
                      child: Center(
                          child: LoadingAnimationWidget.threeArchedCircle(
                              color: Colors.white, size: 24)),
                    );
                  }
                  return BottomNavButton(
                      label: 'Add to Cart',
                      onTap: widget.optionsSelected.length !=
                                  widget.product.options!.length &&
                              widget.selectedVariant == null
                          ? null
                          : () {
                              context.read<LineItemBloc>().add(
                                  LineItemEvent.add(
                                      PreferenceRepository.instance.cartId!,
                                      widget.selectedVariant!.id!,
                                      1));
                            });
                },
                loading: (_) => Container(
                      color: ColorConstant.primary,
                      height: 50,
                      child: Center(
                          child: LoadingAnimationWidget.threeArchedCircle(
                              color: Colors.white, size: 24)),
                    ),
                orElse: () => const SizedBox.shrink());
          },
        );
      },
    );
  }
}
