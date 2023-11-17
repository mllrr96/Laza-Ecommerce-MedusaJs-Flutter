import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:laza/domain/usecase/retrieve_orders_usecase.dart';
import 'package:medusa_store_flutter/store_models/orders/order.dart';

part 'orders_event.dart';
part 'orders_state.dart';
part 'orders_bloc.freezed.dart';

@injectable
class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc(this._usecase) : super(const _Loading()) {
    on<_LoadOrders>((event, emit) async {
      emit(const _Loading());
      final result = await _usecase();
      result.when((orders) => emit(_Loaded(orders)), (error) => emit(_Error(error.message)));
    });
  }

  final RetrieveOrdersUsecase _usecase;
}
