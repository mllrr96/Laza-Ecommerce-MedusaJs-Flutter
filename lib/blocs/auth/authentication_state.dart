part of 'authentication_bloc.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.loading() = _Loading;
  const factory AuthenticationState.loggedInAsGuest({Failure? failure}) = _LoggedInAsGuest;
  const factory AuthenticationState.loggedOut({Failure? failure}) = _LoggedOut;
  const factory AuthenticationState.loggedIn(Customer customer) = _LoggedIn;
  const factory AuthenticationState.error(Failure failure) = _Error;
}
