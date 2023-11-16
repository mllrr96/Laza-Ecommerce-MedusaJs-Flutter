// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:laza/blocs/cart/cart_bloc.dart' as _i15;
import 'package:laza/blocs/line_item/line_item_bloc.dart' as _i16;
import 'package:laza/blocs/products/products_bloc.dart' as _i8;
import 'package:laza/blocs/region/region_bloc.dart' as _i18;
import 'package:laza/cubits/theme/theme_cubit.dart' as _i12;
import 'package:laza/di/module.dart' as _i19;
import 'package:laza/domain/repository/preference_repository.dart' as _i17;
import 'package:laza/domain/repository/theme_repository.dart' as _i13;
import 'package:laza/domain/usecase/get_home_category_usecase.dart' as _i4;
import 'package:laza/domain/usecase/get_home_product_usecase.dart' as _i5;
import 'package:laza/domain/usecase/line_item_usecase.dart' as _i6;
import 'package:laza/domain/usecase/retrieve_cart_usecase.dart' as _i9;
import 'package:laza/domain/usecase/retrieve_regions_usecase.dart' as _i10;
import 'package:laza/domain/usecase/update_cart_usercase.dart' as _i14;
import 'package:laza/presentation/routes/app_router.dart' as _i3;
import 'package:medusa_store_flutter/medusa_store_flutter.dart' as _i7;
import 'package:shared_preferences/shared_preferences.dart' as _i11;

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
    gh.factory<_i6.LineItemUsecase>(() => _i6.LineItemUsecase());
    gh.factory<_i7.MedusaStore>(() => registerCoreDependencies.medusaStore);
    gh.factory<_i8.ProductsBloc>(
        () => _i8.ProductsBloc(gh<_i5.GetHomeProductUsecase>()));
    gh.factory<_i9.RetrieveCartUsecase>(() => _i9.RetrieveCartUsecase());
    gh.factory<_i10.RetrieveRegionsUsecase>(
        () => _i10.RetrieveRegionsUsecase());
    await gh.factoryAsync<_i11.SharedPreferences>(
      () => registerCoreDependencies.prefs,
      preResolve: true,
    );
    gh.factory<_i12.ThemeCubit>(() => _i12.ThemeCubit());
    gh.factory<_i13.ThemeRepository>(() => _i13.ThemeRepository());
    gh.factory<_i14.UpdateCartUsecase>(() => _i14.UpdateCartUsecase());
    gh.factory<_i15.CartBloc>(() => _i15.CartBloc(
          gh<_i9.RetrieveCartUsecase>(),
          gh<_i14.UpdateCartUsecase>(),
        ));
    gh.factory<_i16.LineItemBloc>(
        () => _i16.LineItemBloc(gh<_i6.LineItemUsecase>()));
    gh.singleton<_i17.PreferenceRepository>(
        _i17.PreferenceRepository(gh<_i11.SharedPreferences>()));
    gh.factory<_i18.RegionBloc>(
        () => _i18.RegionBloc(gh<_i10.RetrieveRegionsUsecase>()));
    return this;
  }
}

class _$RegisterCoreDependencies extends _i19.RegisterCoreDependencies {}
