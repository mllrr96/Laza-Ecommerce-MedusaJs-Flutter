part of 'products_bloc.dart';

@freezed
class ProductsEvent with _$ProductsEvent {
  const factory ProductsEvent.loadProducts({Map<String, dynamic>? queryParameters}) = _LoadProducts;
}
