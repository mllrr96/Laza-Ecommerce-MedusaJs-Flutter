import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:laza/domain/usecase/auth_usecase.dart';
import 'package:medusa_store_flutter/store_models/store/customer.dart';

import '../../di/di.dart';
import '../../domain/repository/preference_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

@injectable
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this._authUsecase) : super(const _Loading()) {
    on<_Init>(_onInitialize);
    on<_Login>(_onLogin);
    on<_Logout>(_onLogout);
    add(const _Init());
  }

  Future<void> _onInitialize(
    _Init event,
    Emitter<AuthenticationState> emit,
  ) async {
    final isGuest = getIt<PreferenceRepository>().isGuest;
    if (isGuest) {
      emit(const _Guest());
    } else {
      final result = await _authUsecase.getCurrentCustomer();
      result.when((customer) => _LoggedIn(customer), (error) => emit(const _LoggedOut()));
    }
  }

  Future<void> _onLogin(
    _Login event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const _Loading());
    final result = await _authUsecase.login(email: event.email, password: event.password);
    result.when((customer) => emit(_LoggedIn(customer)), (error) => emit(const _LoggedOut()));
  }

  Future<void> _onLogout(
    _Logout event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const _Loading());
    final result = await _authUsecase.logout();
    if (result) {
      emit(const _LoggedOut());
    } else {
      emit(const _LoggedOut());
    }
  }

  final AuthUsecase _authUsecase;
}
