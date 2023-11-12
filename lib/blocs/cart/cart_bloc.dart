import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:laza/domain/usecase/retrieve_cart_usecase.dart';
import 'package:medusa_store_flutter/store_models/store/cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._usecase) : super(const CartState.initial()) {
    on<_LoadCart>((event, emit) async {
      emit(const CartState.loading());
      final result = await _usecase();
      result.when((cart) {
        emit(CartState.loaded(cart));
      }, (error) {
        emit(CartState.error(error.message));
      });
    });
  }
  final RetrieveCartUsecase _usecase;
}
