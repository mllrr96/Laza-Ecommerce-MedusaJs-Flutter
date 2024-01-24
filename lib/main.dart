import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:laza/blocs/auth/authentication_bloc.dart';
import 'package:laza/presentation/screens/cart/bloc/cart/cart_bloc.dart';
import 'package:laza/presentation/screens/cart/bloc/line_item/line_item_bloc.dart';
import 'package:laza/blocs/region/region_bloc.dart';
import 'package:laza/cubits/theme/theme_cubit.dart';
import 'package:laza/presentation/routes/app_router.dart';
import 'package:laza/presentation/screens/home/bloc/collections/collections_bloc.dart';
import 'package:laza/presentation/screens/home/bloc/products/products_bloc.dart';
import 'package:laza/presentation/theme/theme.dart';
import 'di/di.dart';
import 'observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //* observe bloc logs
  Bloc.observer = MyBlocObserver();

  //* inject dependencies
  await configureInjection();

  runApp(const LazaApp());
}

class LazaApp extends StatelessWidget {
  const LazaApp({super.key});

  AppRouter get _router => getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc.instance,
          lazy: false,
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit.instance..loadTheme(),
          lazy: false,
        ),
        BlocProvider<ProductsBloc>(
          create: (_) => ProductsBloc.instance,
        ),
        BlocProvider<CollectionsBloc>(
          create: (_) => CollectionsBloc.instance
            ..add(const CollectionsEvent.retrieveCollections(
                queryParameters: {'limit': 4})),
        ),
        BlocProvider<RegionBloc>(
          create: (_) =>
              RegionBloc.instance..add(const RegionEvent.retrieveRegions()),
          lazy: false,
        ),
        BlocProvider<CartBloc>(
          create: (_) => CartBloc.instance..add(const CartEvent.loadCart()),
        ),
        BlocProvider<LineItemBloc>(
          create: (_) => LineItemBloc.instance,
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Laza',
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: _router.config(),
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}
