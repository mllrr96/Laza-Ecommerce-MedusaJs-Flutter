// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:laza/blocs/home_bloc.dart' as _i6;
import 'package:laza/blocs/region/region_bloc.dart' as _i13;
import 'package:laza/cubits/theme/theme_cubit.dart' as _i11;
import 'package:laza/di/module.dart' as _i14;
import 'package:laza/domain/repository/preference_repository.dart' as _i8;
import 'package:laza/domain/repository/theme_repository.dart' as _i12;
import 'package:laza/domain/usecase/get_home_category_usecase.dart' as _i4;
import 'package:laza/domain/usecase/get_home_product_usecase.dart' as _i5;
import 'package:laza/domain/usecase/retrieve_regions_usecase.dart' as _i9;
import 'package:laza/presentation/routes/app_router.dart' as _i3;
import 'package:medusa_store_flutter/medusa_store_flutter.dart' as _i7;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerCoreDependencies = _$RegisterCoreDependencies();
    gh.factory<_i3.AppRouter>(() => registerCoreDependencies.appRouter);
    gh.factory<_i4.GetHomeCategoryUsecase>(() => _i4.GetHomeCategoryUsecase());
    gh.factory<_i5.GetHomeProductUsecase>(() => _i5.GetHomeProductUsecase());
    gh.factory<_i6.HomeBloc>(
        () => _i6.HomeBloc(gh<_i5.GetHomeProductUsecase>()));
    gh.factory<_i7.MedusaStore>(() => registerCoreDependencies.medusaStore);
    gh.factory<_i8.PreferenceRepository>(() => _i8.PreferenceRepository());
    gh.factory<_i9.RetrieveRegionsUsecase>(() => _i9.RetrieveRegionsUsecase());
    await gh.factoryAsync<_i10.SharedPreferences>(
      () => registerCoreDependencies.prefs,
      preResolve: true,
    );
    gh.factory<_i11.ThemeCubit>(() => _i11.ThemeCubit());
    gh.factory<_i12.ThemeRepository>(() =>
        _i12.ThemeRepository(sharedPreferences: gh<_i10.SharedPreferences>()));
    gh.factory<_i13.RegionBloc>(
        () => _i13.RegionBloc(gh<_i9.RetrieveRegionsUsecase>()));
    return this;
  }
}

class _$RegisterCoreDependencies extends _i14.RegisterCoreDependencies {}
