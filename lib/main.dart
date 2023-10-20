import 'package:flutter/material.dart';
import 'package:laza/theme.dart';
import 'package:provider/provider.dart';

import 'routes/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp.router(
            title: 'Laza',
            debugShowCheckedModeBanner: false,
            themeMode: themeNotifier.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: _appRouter.config(),
          );
        },
      ),
    );
  }
}
