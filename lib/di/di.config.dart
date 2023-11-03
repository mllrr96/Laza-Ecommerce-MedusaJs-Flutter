// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:laza/blocs/home_bloc.dart' as _i5;
import 'package:laza/cubits/theme/theme_cubit.dart' as _i9;
import 'package:laza/di/module.dart' as _i11;
import 'package:laza/domain/repository/preference_repository.dart' as _i7;
import 'package:laza/domain/repository/theme_repository.dart' as _i10;
import 'package:laza/domain/usecase/get_home_product_usecase.dart' as _i4;
import 'package:laza/presentation/routes/app_router.dart' as _i3;
import 'package:medusa_store_flutter/medusa_store_flutter.dart' as _i6;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

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
    gh.factory<_i4.GetHomeProductUsecase>(() => _i4.GetHomeProductUsecase());
    gh.factory<_i5.HomeBloc>(
        () => _i5.HomeBloc(gh<_i4.GetHomeProductUsecase>()));
    gh.factory<_i6.MedusaStore>(() => registerCoreDependencies.medusaStore);
    gh.factory<_i7.PreferenceRepository>(() => _i7.PreferenceRepository());
    await gh.factoryAsync<_i8.SharedPreferences>(
      () => registerCoreDependencies.prefs,
      preResolve: true,
    );
    gh.factory<_i9.ThemeCubit>(() => _i9.ThemeCubit());
    gh.factory<_i10.ThemeRepository>(() =>
        _i10.ThemeRepository(sharedPreferences: gh<_i8.SharedPreferences>()));
    return this;
  }
}

class _$RegisterCoreDependencies extends _i11.RegisterCoreDependencies {}
