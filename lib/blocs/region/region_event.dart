part of 'region_bloc.dart';

@freezed
class RegionEvent with _$RegionEvent {
  const factory RegionEvent.retrieveRegions() = _RetrieveRegions;
}
