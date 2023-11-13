part of 'line_item_bloc.dart';

@freezed
class LineItemEvent with _$LineItemEvent {
  const factory LineItemEvent.add(String id, String variantId, int quantity) = _Add;
  const factory LineItemEvent.update(String cartId, String lineId, int quantity) = _Update;
  const factory LineItemEvent.delete(String cartId, String lineId) = _Delete;
}
