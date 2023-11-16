part of 'products_bloc.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;
  const factory ProductsState.loading() = _Loading;
  const factory ProductsState.empty() = _Empty;
  const factory ProductsState.loaded(List<Product> products) = _Loaded;
  const factory ProductsState.error(String? message) = _Error;}
