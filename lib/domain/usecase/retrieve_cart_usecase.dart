import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:laza/di/di.dart';
import 'package:laza/domain/model/failure.dart';
import 'package:laza/domain/repository/preference_repository.dart';
import 'package:medusa_store_flutter/medusa_store.dart';
import 'package:multiple_result/multiple_result.dart';


@injectable
class RetrieveCartUsecase {
  Future<Result<Cart, Failure>> call() async {
    try {
      final storeApi = getIt<MedusaStore>();
      final prefRepo = getIt<PreferenceRepository>();
      StoreCartsRes? result;
      if (prefRepo.cartId?.isNotEmpty ?? false) {
        result = await storeApi.carts.retrieve(cartId: prefRepo.cartId!);
      } else {
        result = await storeApi.carts.createCart();
        if (result?.cart?.id != null) {
          await prefRepo.setCartId(result!.cart!.id!);
        }
      }

      if (result?.cart == null) {
        return Error(Failure(message: 'Failed to load cart, retrieved cart is null'));
      } else {
        return Success(result!.cart!);
      }
    }  catch (e, stack) {
      log(stack.toString());
      log(e.toString());
      return Error(Failure.from(e));
    }
  }
}
