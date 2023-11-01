import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laza/blocs/status.dart';
import 'package:laza/repositories/preference_repository.dart';
import 'package:medusa_store_flutter/medusa_store_flutter.dart';
import 'package:medusa_store_flutter/request_models/index.dart';
import 'package:medusa_store_flutter/services/index.dart';
import 'package:medusa_store_flutter/store_models/store/index.dart';

import '../../di/di.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({AuthResource? authResource})
      : _authResource = authResource ?? getIt.get<MedusaStore>().auth,
        super(AuthState.init()) {
    on<AuthInitialize>(onInitialize);
    on<AuthLogin>(onLogin);
    on<AuthLogout>(onLogout);
    add(AuthInitialize());
  }

  final AuthResource _authResource;

  Future<void> onInitialize(
    AuthInitialize event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: Status.inProgress));
    final isGuest = getIt.get<PreferenceRepository>().isGuest;
    if (isGuest) {
      emit(
        state.copyWith(isLoggedIn: false, status: Status.success, isGuest: true),
      );
    } else {
      await _authResource.getCurrentSession().then((result) async {
        final loggedIn = result?.customer != null;

        if (loggedIn) {
          emit(
            state.copyWith(
              isLoggedIn: true,
              customer: result?.customer,
              status: Status.success,
            ),
          );
        } else {
          emit(
            state.copyWith(
              isLoggedIn: false,
              isGuest: false,
              status: Status.success,
            ),
          );
        }
      });
    }
  }

  Future<void> onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.inProgress));

    final result =
        await _authResource.authenticate(req: StoreAuthRequest(email: event.email, password: event.password));

    final successful = result?.customer != null;

    if (successful) {
      emit(
        state.copyWith(
          customer: result?.customer,
          isLoggedIn: true,
          status: Status.success,
        ),
      );
    } else {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        customer: null,
        isLoggedIn: false,
      ),
    );

    await _authResource.logout();
  }
}
