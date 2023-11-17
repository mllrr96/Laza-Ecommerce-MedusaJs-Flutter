part of 'collections_bloc.dart';

@freezed
class CollectionsState with _$CollectionsState {
  const factory CollectionsState.loading() = _Loading;
  const factory CollectionsState.loaded(List<ProductCollection> collections) = _Loaded;
  const factory CollectionsState.error(String message) = _Error;
}
