import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:laza/di/di.dart';
import 'package:laza/domain/usecase/retrieve_regions_usecase.dart';
import 'package:medusa_store_flutter/store_models/store/region.dart';

import '../../domain/repository/preference_repository.dart';

part 'region_event.dart';
part 'region_state.dart';
part 'region_bloc.freezed.dart';

@injectable
class RegionBloc extends Bloc<RegionEvent, RegionState> {
  RegionBloc(this._usecase) : super(const RegionState.initial()) {
    on<_RetrieveRegions>(_onRetrieveRegions);
  }

  Future<void> _onRetrieveRegions(_RetrieveRegions event, Emitter<RegionState> emit) async {
    emit(const RegionState.loading());
    final result = await _usecase();
    final prefRepo = getIt<PreferenceRepository>();
    await result.when((regions) async {
      //
      // Setting country and region automatically, this could be more improved by either let the user choose
      //
      // the country or better detect his location and somehow set it to the closest country
      if ((regions.firstOrNull?.countries?.isNotEmpty ?? false) &&
          (prefRepo.country == null || prefRepo.region == null)) {
        await prefRepo.setRegion(regions.first);
        await prefRepo.setCountry(regions.first.countries!.first);
      }
      //
      //
      emit(RegionState.loaded(regions));
    }, (error) {
      emit(RegionState.error(error.message));
    });
  }

  final RetrieveRegionsUsecase _usecase;
}
