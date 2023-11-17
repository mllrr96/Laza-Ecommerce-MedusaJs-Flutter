import 'package:injectable/injectable.dart';
import 'package:laza/domain/model/failure.dart';
import 'package:medusa_store_flutter/medusa_store_flutter.dart';
import 'package:medusa_store_flutter/request_models/index.dart';
import 'package:medusa_store_flutter/store_models/store/index.dart';
import 'package:multiple_result/multiple_result.dart';
import 'dart:developer';

import '../../di/di.dart';

@injectable
class AuthenticationUsecase {
  Future<Result<Customer, Failure>> login({required String email, required String password}) async {
    try {
      final authResource = getIt<MedusaStore>().auth;
      final result = await authResource.authenticate(req: StoreAuthRequest(email: email, password: password));

      if (result?.customer == null) {
        return Error(Failure(message: 'Received customer is null'));
      } else {
        return Success(result!.customer!);
      }
    } catch (e, stack) {
      log(stack.toString());
      log(e.toString());
      return Error(Failure(message: 'Failed to customer profile'));
    }
  }

  Future<Result<Customer, Failure>> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String phone}) async {
    try {
      final authResource = getIt<MedusaStore>().customers;
      final result = await authResource.create(
          req: StorePostCustomersReq(
              email: email, password: password, firstName: firstName, lastName: lastName, phone: phone));

      if (result?.customer == null) {
        return Error(Failure(message: 'Error creating account'));
      } else {
        return Success(result!.customer!);
      }
    } on Exception catch (e) {
      log(e.toString());
      return Error(Failure(message: 'Error creating account'));
    }
  }

  Future<bool> logoutCustomer() async {
    try {
      final authResource = getIt<MedusaStore>().auth;
      await authResource.logout();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<Result<Customer, Failure>> getCurrentCustomer() async {
    try {
      final authResource = getIt<MedusaStore>().auth;
      final result = await authResource.getCurrentSession();
      if (result?.customer == null) {
        return Error(Failure(message: 'Received customer is null'));
      } else {
        return Success(result!.customer!);
      }
    } catch (e, stack) {
      log(stack.toString());
      log(e.toString());
      return Error(Failure(message: 'Failed to customer profile'));
    }
  }
}
