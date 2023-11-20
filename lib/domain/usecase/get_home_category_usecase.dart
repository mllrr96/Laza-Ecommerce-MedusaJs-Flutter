import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:laza/di/di.dart';
import 'package:laza/domain/model/failure.dart';
import 'package:medusa_store_flutter/medusa_store_flutter.dart';
import 'package:medusa_store_flutter/store_models/store/index.dart';
import 'package:multiple_result/multiple_result.dart';

@injectable
class GetHomeCategoryUsecase {
  Future<Result<List<ProductCollection>, Failure>> call() async {
    try {
      final storeApi = getIt<MedusaStore>();

      final result = await storeApi.collections.list();

      if (result?.collections?.isEmpty ?? true) {
        return Error(Failure(message: 'No collections found.'));
      } else {
        return Success(result!.collections!);
      }
    } catch (e, stack) {
      log(stack.toString());
      log(e.toString());
      return Error(Failure.from(e));
    }
  }
}
