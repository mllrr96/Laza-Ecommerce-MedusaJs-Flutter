
import 'package:injectable/injectable.dart';
import 'package:laza/common/exception.dart';
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
        throw NoRecordsException;
      } else {
        return Success(result!.collections!);
      }
    } on Exception catch (e) {
      if (e is NoRecordsException) {
        return Error(
          Failure(message: 'No collections found.'),
        );
      }
      return Error(
        Failure(message: 'Failed to load collection, please try again.'),
      );
    }
  }
}