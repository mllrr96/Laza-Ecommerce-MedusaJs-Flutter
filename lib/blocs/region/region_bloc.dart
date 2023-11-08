import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:laza/domain/usecase/retrieve_regions_usecase.dart';
import 'package:medusa_store_flutter/store_models/store/region.dart';

part 'region_event.dart';
part 'region_state.dart';
part 'region_bloc.freezed.dart';

@injectable
class RegionBloc extends Bloc<RegionEvent, RegionState> {
  RegionBloc(this._usecase) : super(const RegionState.initial()) {
    on<_RetrieveRegions>((event, emit) async {
      emit(const RegionState.loading());
      final result = await _usecase();

      result.when((regions) {
        emit(RegionState.loaded(regions));
      }, (error) {
        emit(RegionState.error(error.message));
      });
    });
  }

  final RetrieveRegionsUsecase _usecase;
}
