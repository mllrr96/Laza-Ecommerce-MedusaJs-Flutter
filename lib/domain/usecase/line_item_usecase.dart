import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:laza/di/di.dart';
import 'package:laza/domain/model/failure.dart';
import 'package:medusa_store_flutter/medusa_store_flutter.dart';
import 'package:medusa_store_flutter/store_models/store/cart.dart';
import 'package:multiple_result/multiple_result.dart';

@injectable
class LineItemUsecase {
  Future<Result<Cart, Failure>> add({required String cartId, required String variantId, required int quantity}) async {
    try {
      final storeApi = getIt<MedusaStore>();
      final result = await storeApi.carts.addLineItem(cartId: cartId, variantId: variantId, quantity: quantity);
      if (result?.cart == null) {
        return Error(
          Failure(message: 'No regions found.'),
        );
      } else {
        return Success(result!.cart!);
      }
    } on Exception catch (e) {
      return Error(Failure.from(e));
    }
  }

  Future<Result<Cart, Failure>> update({required String cartId, required String lineId, required int quantity}) async {
    try {
      final storeApi = getIt<MedusaStore>();
      final result = await storeApi.carts.updateLineItem(cartId: cartId, quantity: quantity, lineId: lineId);
      if (result?.cart == null) {
        return Error(Failure(message: 'No regions found.'));
      } else {
        return Success(result!.cart!);
      }
    } on Exception catch (e) {
      return Error(Failure.from(e));
    }
  }

  Future<Result<Cart, Failure>> delete({required String cartId, required String lineId}) async {
    try {
      final storeApi = getIt<MedusaStore>();
      final result = await storeApi.carts.deleteLineItem(cartId: cartId, lineId: lineId);
      if (result?.cart == null) {
        return Error(Failure(message: 'No regions found.'));
      } else {
        return Success(result!.cart!);
      }
    } catch (e, stack) {
      log(stack.toString());
      log(e.toString());
      return Error(Failure.from(e));
    }
  }
}
