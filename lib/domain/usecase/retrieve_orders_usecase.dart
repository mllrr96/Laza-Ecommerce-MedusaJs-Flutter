import 'dart:developer';

import 'package:injectable/injectable.dart' hide Order;
import 'package:medusa_store_flutter/medusa_store_flutter.dart';
import 'package:medusa_store_flutter/store_models/orders/order.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../di/di.dart';
import '../model/failure.dart';

@injectable
class RetrieveOrdersUsecase {
  Future<Result<List<Order>, Failure>> call() async {
    try {
      final storeApi = getIt<MedusaStore>();

      final result = await storeApi.customers.listOrders();
      if (result?.orders?.isNotEmpty ?? false) {
        return Success(result!.orders!);
      } else {
        return Error(Failure(message: 'Failed to load orders'));
      }
    } on Exception catch (e, stack) {
      log(stack.toString());
      log(e.toString());
      return Error(Failure.from(e));
    }
  }
}
