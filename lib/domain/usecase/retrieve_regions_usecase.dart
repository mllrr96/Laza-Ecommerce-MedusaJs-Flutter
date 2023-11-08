import 'package:injectable/injectable.dart';
import 'package:medusa_store_flutter/medusa_store_flutter.dart';
import 'package:medusa_store_flutter/store_models/store/index.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../common/exception.dart';
import '../../di/di.dart';
import '../model/failure.dart';

@injectable
class RetrieveRegionsUsecase {
  Future<Result<List<Region>, Failure>> call() async {
    try {
      final storeApi = getIt<MedusaStore>();

      final result = await storeApi.regions.list();

      if (result?.regions?.isEmpty ?? true) {
        throw NoRecordsException;
      } else {
        return Success(result!.regions!);
      }
    } on Exception catch (e) {
      if (e is NoRecordsException) {
        return Error(
          Failure(message: 'No regions found.'),
        );
      }
      return Error(
        Failure(message: 'Failed to load regions, please try again.'),
      );
    }
  }
}
