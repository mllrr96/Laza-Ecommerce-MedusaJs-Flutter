part of 'region_bloc.dart';

@freezed
class RegionState with _$RegionState {
  const factory RegionState.initial() = _Initial;
  const factory RegionState.loading() = _Loading;
  const factory RegionState.loaded(List<Region> regions) = _Loaded;
  const factory RegionState.error(String? message) = _Error;
}
