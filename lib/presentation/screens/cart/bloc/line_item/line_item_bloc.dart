import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:laza/domain/usecase/line_item_usecase.dart';
import 'package:medusa_store_flutter/store_models/store/cart.dart';

part 'line_item_event.dart';
part 'line_item_state.dart';
part 'line_item_bloc.freezed.dart';

@injectable
class LineItemBloc extends Bloc<LineItemEvent, LineItemState> {
  LineItemBloc(this.lineItemUsecase) : super(const LineItemState.loading()) {
    on<_Add>((event, emit) async {
      emit(const LineItemState.loading());
      final result = await lineItemUsecase.add(cartId: event.id, variantId: event.variantId, quantity: event.quantity);
      result.when((cart) => emit(LineItemState.success(cart)), (error) => emit(LineItemState.failure(error.message)));
    });

    on<_Update>((event, emit) async {
      emit(const LineItemState.loading());
      final result = await lineItemUsecase.update(cartId: event.cartId, quantity: event.quantity, lineId: event.lineId);
      result.when((cart) => emit(LineItemState.success(cart)), (error) => emit(LineItemState.failure(error.message)));
    });

    on<_Delete>((event, emit) async {
      emit(const LineItemState.loading());
      final result = await lineItemUsecase.delete(cartId: event.cartId, lineId: event.lineId);
      result.when((cart) => emit(LineItemState.success(cart)), (error) => emit(LineItemState.failure(error.message)));
    });
  }

  final LineItemUsecase lineItemUsecase;
}
