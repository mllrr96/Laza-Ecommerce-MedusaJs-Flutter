part of 'products_bloc.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.loading() = _Loading;
  const factory ProductsState.empty() = _Empty;
  const factory ProductsState.loaded(List<Product> products ,{int? offset, int? count, int? limit}) = _Loaded;
  const factory ProductsState.error(String? message) = _Error;
}
