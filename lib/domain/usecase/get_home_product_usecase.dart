import 'package:injectable/injectable.dart';
import 'package:laza/common/exception.dart';
import 'package:laza/di/di.dart';
import 'package:laza/domain/repository/preference_repository.dart';
import 'package:medusa_store_flutter/medusa_store_flutter.dart';
import 'package:medusa_store_flutter/store_models/products/product.dart';
import 'package:multiple_result/multiple_result.dart';

import '../model/failure.dart';

@injectable
class GetHomeProductUsecase {
  Future<Result<List<Product>, Failure>> call() async {
    try {
      final storeApi = getIt<MedusaStore>();
      final prefRepo = getIt<PreferenceRepository>();
      final regionId = prefRepo.country?.regionId;
      final result = await storeApi.products.list(queryParams: {
        'is_giftcard': false,
        'currency_code': prefRepo.currencyCode,
        if (regionId != null) 'region_id': regionId
      });

      if (result?.products?.isEmpty ?? true) {
        throw NoRecordsException;
      } else {
        return Success(result!.products!);
      }
    } on Exception catch (e) {
      if (e is NoRecordsException) {
        return Error(
          Failure(message: 'No products found.'),
        );
      }
      return Error(
        Failure(message: 'Failed to load products, please try again.'),
      );
    }
  }
}
