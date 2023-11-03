import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:laza/domain/usecase/get_home_product_usecase.dart';
import 'package:medusa_store_flutter/store_models/products/product.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._usecase) : super(const HomeState.initial()) {
    on<_GetProducts>((event, emit) async {
      emit(const HomeState.loading());
      final result = await _usecase();

      result.when(
        (products) {
          if(products.isEmpty){
            emit(const HomeState.empty());
          } else {
            emit(HomeState.loaded(products));
          }
        },
        (error) => emit(HomeState.error(error.message)),
      );
    });
  }

  final GetHomeProductUsecase _usecase;
}
