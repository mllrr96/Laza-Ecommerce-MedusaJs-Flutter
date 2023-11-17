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
  ProductsBloc(this._usecase) : super(const ProductsState.initial()) {
    on<_GetProducts>((event, emit) async {
      emit(const ProductsState.loading());
      final result = await _usecase();

      result.when(
        (products) {
          if (products.isEmpty) {
            emit(const ProductsState.empty());
          } else {
            emit(ProductsState.loaded(products));
          }
        },
        (error) => emit(ProductsState.error(error.message)),
      );
    });
  }

  final GetHomeProductUsecase _usecase;
}
