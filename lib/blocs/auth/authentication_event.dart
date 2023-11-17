part of 'authentication_bloc.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.init() = _Init;
  const factory AuthenticationEvent.loginCustomer({required String email, required String password}) = _LoginCustomer;
  const factory AuthenticationEvent.loginAsGuest() = _LoginAsGuest;
  const factory AuthenticationEvent.signUpCustomer(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) = _SignUpCustomer;
  const factory AuthenticationEvent.logoutCustomer() = _LogoutCustomer;
}
