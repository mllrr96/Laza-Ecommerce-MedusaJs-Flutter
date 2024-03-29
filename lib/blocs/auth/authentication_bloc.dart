import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:laza/domain/model/failure.dart';
import 'package:laza/domain/usecase/auth_usecase.dart';
import 'package:medusa_store_flutter/medusa_store.dart';

import '../../di/di.dart';
import '../../domain/repository/preference_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  static AuthenticationBloc get instance => getIt<AuthenticationBloc>();
  AuthenticationBloc(this._authUsecase) : super(const _Loading()) {
    on<_Init>(_onInitialize);
    on<_LoginCustomer>(_onLogin);
    on<_LogoutCustomer>(_onLogout);
    on<_SignUpCustomer>(_onSignUp);
    on<_LoginAsGuest>(_onLoginAsGuest);
    add(const _Init());
  }

  Future<void> _onInitialize(
    _Init event,
    Emitter<AuthenticationState> emit,
  ) async {
    final result = await _authUsecase.getCurrentCustomer();
    result.when((customer) => emit(_LoggedIn(customer)), (error) {
      final isGuest = getIt<PreferenceRepository>().isGuest;
      if (isGuest) {
        emit(const _LoggedInAsGuest());
      } else if (error.code == 401) {
        emit(const _LoggedOut());
      } else {
        emit(_Error(error));
      }
    });
  }

  Future<void> _onLogin(
    _LoginCustomer event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const _Loading());
    final jwt = await _authUsecase.loginJWT(
        email: event.email, password: event.password);
    await jwt.when((jwt) async {
      await PreferenceRepository.instance.setCookie(jwt);
      final result = await _authUsecase.getCurrentCustomer();
      result.when((customer) => emit(_LoggedIn(customer)), (error) {
        final isGuest = PreferenceRepository.instance.isGuest;
        if (isGuest) {
          emit(_LoggedInAsGuest(failure: error));
        } else {
          emit(_LoggedOut(failure: error));
        }
      });
    }, (error) {
      final isGuest = PreferenceRepository.instance.isGuest;
      if (isGuest) {
        emit(_LoggedInAsGuest(failure: error));
      } else {
        emit(_LoggedOut(failure: error));
      }
    });
  }

  Future<void> _onLogout(
    _LogoutCustomer event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const _Loading());
    final result = await _authUsecase.logoutCustomer();
    if (result) {
      emit(const _LoggedOut());
    } else {
      emit(_Error(Failure(message: 'Error signing out')));
    }
  }

  Future<void> _onSignUp(
    _SignUpCustomer event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const _Loading());
    final result = await _authUsecase.signUp(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
        phone: '');
    result.when((customer) => emit(_LoggedIn(customer)), (error) {
      final isGuest = getIt<PreferenceRepository>().isGuest;
      if (isGuest) {
        emit(_LoggedInAsGuest(failure: error));
      } else {
        emit(_LoggedOut(failure: error));
      }
    });
  }

  Future<void> _onLoginAsGuest(
    _LoginAsGuest event,
    Emitter<AuthenticationState> emit,
  ) async {
    getIt<PreferenceRepository>().setGuest();
    emit(const _LoggedInAsGuest());
  }

  final AuthenticationUsecase _authUsecase;
}
