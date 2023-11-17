import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:medusa_store_flutter/store_models/products/product.dart';

import '../../../../../domain/usecase/get_home_product_usecase.dart';

part 'products_event.dart';
part 'products_state.dart';
part 'products_bloc.freezed.dart';

@injectable
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(this._usecase) : super(const _Loading()) {
    on<_LoadProducts>((event, emit) async {
      final result = await _usecase(queryParameters: event.queryParameters);
      result.when(
        (response) {
          if (response.products!.isEmpty) {
            emit(const _Empty());
          } else {
            emit(_Loaded(response.products!, count: response.count, limit: response.limit, offset: response.offset));
          }
        },
        (error) => emit(_Error(error.message)),
      );
    });
  }

  final GetHomeProductUsecase _usecase;
}
