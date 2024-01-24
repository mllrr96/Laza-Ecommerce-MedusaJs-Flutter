part of 'line_item_bloc.dart';

@freezed
class LineItemState with _$LineItemState {
  const factory LineItemState.initial() = _Initial;
  const factory LineItemState.loading({String? lineItemId}) = _Loading;
  const factory LineItemState.success(Cart cart) = _Success;
  const factory LineItemState.failure(String message) = _Failure;
}
