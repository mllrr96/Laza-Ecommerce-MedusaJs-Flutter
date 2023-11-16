import 'package:injectable/injectable.dart';
import 'package:medusa_store_flutter/medusa_store_flutter.dart';
import 'package:medusa_store_flutter/request_models/index.dart';
import 'package:medusa_store_flutter/store_models/store/cart.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../common/exception.dart';
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
    } on Exception catch (e) {
      if (e is NoRecordsException) {
        return Error(
          Failure(message: 'No cart found.'),
        );
      }
      return Error(Failure(message: 'Failed to load cart, please try again.'));
    }
  }
}
