import 'package:injectable/injectable.dart';
import 'package:laza/common/exception.dart';
import 'package:laza/di/di.dart';
import 'package:medusa_store_flutter/medusa_store_flutter.dart';
import 'package:medusa_store_flutter/store_models/products/product.dart';
import 'package:multiple_result/multiple_result.dart';

import '../model/failure.dart';

@injectable
class GetHomeProductUsecase {
  Future<Result<List<Product>, Failure>> call() async {
    try {
      final storeApi = getIt.get<MedusaStore>();

      final result = await storeApi.products.list(queryParams: {'is_giftcard': false});

      if (result?.products?.isEmpty ?? true) {
        return Error(
          Failure(message: 'No products found'),
        );
      } else {
        return Success(result!.products!);
      }
    } on Exception catch (e) {
      if (e is NoRecordsException) {
        return Error(
          Failure(message: 'No notes found..\nclick + to add new one.'),
        );
      }
      return Error(
        Failure(message: 'Failed to load notes, please try again.'),
      );
    }
  }
}
