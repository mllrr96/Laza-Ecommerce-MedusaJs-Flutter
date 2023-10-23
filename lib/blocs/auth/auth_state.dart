part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.customer,
    required this.isLoggedIn,
    required this.status,
    required this.isGuest,
  });

  final Customer? customer;
  final bool isLoggedIn;
  final bool isGuest;
  final Status status;

  AuthState.init()
      : customer = Customer(email: ''),
        isLoggedIn = false,
        status = Status.success,
        isGuest = false;

  AuthState copyWith({
    Customer? customer,
    bool? isLoggedIn,
    bool? isGuest,
    Status? status,
  }) {
    return AuthState(
        customer: customer ?? this.customer,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        status: status ?? this.status,
        isGuest: isGuest ?? this.isGuest);
  }

  @override
  List<Object> get props => [isLoggedIn, status, isGuest];
}
