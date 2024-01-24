part of 'account_information_bloc.dart';

@freezed
class AccountInformationEvent with _$AccountInformationEvent {
  const factory AccountInformationEvent.started() = _Started;
}
