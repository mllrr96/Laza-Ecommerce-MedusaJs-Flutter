import 'package:shared_preferences/shared_preferences.dart';

class PreferenceRepository {
  PreferenceRepository({
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  final SharedPreferences _prefs;

  static const String _guestKey = 'guest';

  bool get isGuest => _prefs.getBool(_guestKey) ?? false;

  void setGuest() => _prefs.setBool(_guestKey, true);
}
