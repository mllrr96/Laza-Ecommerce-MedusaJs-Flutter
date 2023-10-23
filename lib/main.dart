import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza/blocs/auth/auth_bloc.dart';
import 'package:laza/styles/theme.dart';
import 'package:provider/provider.dart';

import 'config/locator.dart';
import 'routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          lazy: false,
          create: (BuildContext context) => AuthBloc(),
        )
      ],
      child: ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
          builder: (context, themeNotifier, child) {
            return MaterialApp.router(
              title: 'Laza',
              debugShowCheckedModeBanner: false,
              themeMode: themeNotifier.themeMode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              routerConfig: locator.get<AppRouter>().config(),
            );
          },
        ),
      ),
    );
  }
}
