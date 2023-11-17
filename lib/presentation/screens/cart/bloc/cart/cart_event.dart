part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.loadCart() = _LoadCart;
  const factory CartEvent.updateCart({required String cartId, required StorePostCartsCartReq req}) = _UpdateCart;
  const factory CartEvent.refreshCart(Cart cart) = _RefreshCart;
}
