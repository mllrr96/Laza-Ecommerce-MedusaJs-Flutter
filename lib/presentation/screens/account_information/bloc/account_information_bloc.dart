import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_information_event.dart';
part 'account_information_state.dart';
part 'account_information_bloc.freezed.dart';

class AccountInformationBloc extends Bloc<AccountInformationEvent, AccountInformationState> {
  AccountInformationBloc() : super(const AccountInformationState.initial()) {
    on<AccountInformationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
