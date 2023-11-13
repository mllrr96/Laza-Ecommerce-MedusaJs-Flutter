part of 'line_item_bloc.dart';

@freezed
class LineItemState with _$LineItemState {
  const factory LineItemState.loading() = _Loading;
  const factory LineItemState.success(Cart cart) = _Success;
  const factory LineItemState.failure(String message) = _Failure;
}
