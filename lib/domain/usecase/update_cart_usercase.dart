import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:medusa_store_flutter/medusa_store_flutter.dart';
import 'package:medusa_store_flutter/request_models/index.dart';
import 'package:medusa_store_flutter/store_models/store/cart.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../di/di.dart';
import '../model/failure.dart';

@injectable
class UpdateCartUsecase {
  Future<Result<Cart, Failure>> call({
    required String cartId,
    required StorePostCartsCartReq req,
  }) async {
    try {
      final storeApi = getIt<MedusaStore>();

      final result = await storeApi.carts.update(cartId: cartId, req: req);

      if (result?.cart == null) {
        return Error(Failure(message: 'Failed to load cart, retrieved cart is null'));
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
