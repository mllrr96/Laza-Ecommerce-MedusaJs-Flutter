import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/di.dart';

@injectable
class ThemeRepository {
  ThemeRepository({
    required SharedPreferences? sharedPreferences,
  }) : _sharedPreferences = sharedPreferences ?? getIt<SharedPreferences>();

  final SharedPreferences _sharedPreferences;
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;
  static const _kThemePersistenceKey = 'themeMode';

  saveTheme(ThemeMode themeMode) async {
    await _sharedPreferences.setString(_kThemePersistenceKey, themeMode.name);
    _themeMode = themeMode;
  }

  Future<ThemeMode> loadFromPrefs() async {
    switch (_sharedPreferences.getString(_kThemePersistenceKey)) {
      case 'system':
        _themeMode = ThemeMode.system;
      case 'light':
        _themeMode = ThemeMode.light;
      case 'dark':
        _themeMode = ThemeMode.light;
      default:
        _themeMode = ThemeMode.system;
    }
    return _themeMode;
  }
}
