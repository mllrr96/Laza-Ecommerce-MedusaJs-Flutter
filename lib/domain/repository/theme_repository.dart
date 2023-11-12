import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/di.dart';

@injectable
class ThemeRepository {
  ThemeRepository() : _sharedPreferences = getIt.get<SharedPreferences>();

  final SharedPreferences _sharedPreferences;
  static const _kThemePersistenceKey = 'themeMode';

  saveTheme(ThemeMode themeMode) async {
    await _sharedPreferences.setString(_kThemePersistenceKey, themeMode.name);
  }

  ThemeMode loadFromPrefs() {
    switch (_sharedPreferences.getString(_kThemePersistenceKey)) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
