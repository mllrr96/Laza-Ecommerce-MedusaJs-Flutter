import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:medusa_store_flutter/medusa_store.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../di/di.dart';
import '../model/failure.dart';

@injectable
class RetrieveRegionsUsecase {
  Future<Result<List<Region>, Failure>> call() async {
    try {
      final storeApi = getIt<MedusaStore>();

      final result = await storeApi.regions.list();

      if (result?.regions?.isEmpty ?? true) {
        return Error(Failure(message: 'No regions found.'));
      } else {
        return Success(result!.regions!);
      }
    } catch (e, stack) {
      log(stack.toString());
      log(e.toString());
      return Error(Failure.from(e));
    }
  }
}
