import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:laza/di/di.dart';
import 'package:laza/domain/repository/preference_repository.dart';
import 'package:medusa_store_flutter/medusa_store_flutter.dart';
import 'package:medusa_store_flutter/response_models/products.dart';
import 'package:multiple_result/multiple_result.dart';

import '../model/failure.dart';

@injectable
class GetHomeProductUsecase {
  Future<Result<StoreProductsListRes, Failure>> call({Map<String, dynamic>? queryParameters}) async {
    try {
      final storeApi = getIt<MedusaStore>();
      final prefRepo = getIt<PreferenceRepository>();

      final regionId = prefRepo.country?.regionId;

      Map<String, dynamic> queryParams = {
        'is_giftcard': false,
        'currency_code': PreferenceRepository.currencyCode,
        if (regionId != null) 'region_id': regionId
      };

      if (queryParameters != null) {
        queryParams.addAll(queryParameters);
      }
      final result = await storeApi.products.list(queryParams: queryParams);
      if (result?.products == null) {
        return Error(Failure(message: 'Failed to load products, please try again.'));
      } else {
        return Success(result!);
      }
    } catch (e, stack) {
      log(stack.toString());
      return Error(Failure.from(e));
    }
  }
}
